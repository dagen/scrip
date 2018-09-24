<cfcomponent output="false">

	<cffunction  name="getCards">
		<cfquery name="qCards" datasource="scrip" cachedwithin="#createTimeSpan(0,0,1,0)#">
			SELECT C.card_id, C.denomination, C.code,
				   V.vendor_id, V.category_id, V.vendor, V.discount, V.instock, V.notes,
				   CAT.category, CONCAT(V.vendor, ' - $', C.denomination) AS cardDescription
			FROM scrip_card C, scrip_vendor V, scrip_category CAT
			WHERE V.category_id = CAT.category_id
			AND	  C.vendor_id = V.vendor_id
			ORDER BY LOWER(vendor) ASC 
		</cfquery>
		<cfreturn qCards />
	</cffunction>
	
	
	<cffunction name="addCard" output="false" returntype="any" hint="Adds a item to the order.">
		<cfargument name="card_id" type="numeric" required="true" />
		<cfargument name="quantity" type="numeric" required="true" />
		
		<!---	Get the card and vendor information --->
		<cfquery datasource="scrip" name="qCard">
			SELECT C.card_id, C.vendor_id, C.denomination, V.vendor, V.instock
			FROM scrip_card C, scrip_vendor V
			WHERE 
				C.vendor_id = V.vendor_id AND
				C.card_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.card_id#" />
		</cfquery>
		
		<cfscript>
			
			//	Create a local variable to hold the item details
			var myItem = StructNew();
			
			myItem.card_id = arguments.card_id;
			myItem.quantity = arguments.quantity;
			myItem.vendor = qCard.vendor;
			myItem.instock = qCard.instock;
			myItem.denomination = qCard.denomination;
			myItem.subtotal = arguments.quantity * qCard.denomination;
			// ArrayAppend(this.items, myItem);
						
		</cfscript>
		
		<cfreturn myItem />
	</cffunction>
	
	<cffunction name="processOrder">		
		<cfargument name="emailaddress" type="string" required="true" default="" />
		<cfargument name="name" type="string" required="true" default="" />
		<cfargument name="notes" type="string" required="false" default="" />
		

		<cfif LEN(trim(arguments.emailaddress)) AND ArrayLen(session.order.items) GT 0>
			
			<!--- First, let's insert a new order record.  Be sure to obtain the record identifier. --->
			<cfset request.orderKey = CreateUUID() />
			<cfquery name="qNewOrder" datasource="#request.dsn#" result="myQueryResult">
				INSERT INTO scrip_order
				(
					order_date, customer_name, customer_email, order_notes, bCompleted, order_key, order_total
				)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" />,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.name)#" />,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.emailAddress)#" />,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.notes)#" />,
					<cfqueryparam cfsqltype="cf_sql_bit" value="0" />,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#request.orderKey#" />,
					<cfqueryparam cfsqltype="cf_sql_numeric" value="0" />
					
				)
			</cfquery>
			
			<!---	Next, get the order_id. --->
			<cfset request.order_id = myQueryResult.generated_key />
			
			<!--- Now, loop over the session.items struct to insert the order_cards. --->
			<cfset ordinal = 1 />
			<cfloop array="#session.order.items#" index="myItem">
				<cfquery name="addOrderCard" datasource="#request.dsn#">
					INSERT INTO scrip_order_cards
					(order_id, card_id, qty, ordinal)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#request.order_id#" />,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#myItem.card_id#" />,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#myItem.quantity#" />,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#ordinal#" />
					)
				</cfquery>
				<cfset ordinal = ordinal + 1 />
			</cfloop>
		
			
			
		
			<!---	Now, let's get the data from the order_options table. // --->
			<cfquery name="myOptions" datasource="#request.dsn#">
				SELECT *
				FROM scrip_options
			</cfquery>
		
			<cfsavecontent variable="strEmailBody">
				<cfoutput>
				<cfset totalPrice = 0 />
				<p>A Scrip Order has been submitted.</p>
				<p>#arguments.name# (#arguments.emailAddress#) has requested the following cards:</p>
				<ul>
				<cfloop array="#session.order.items#" index="myItem">
					<li>#myItem.quantity# - #myItem.vendor# (#LSCurrencyFormat(myItem.denomination)#)</li>
					<cfset totalPrice = totalPrice + (myItem.quantity * myItem.denomination) />	
				</cfloop>
				</ul>
				<p>For an order total of: <em>#LSCurrencyFormat(totalPrice)#</em>.</p>
				<p>Order notes:</p>
					<blockquote>#arguments.notes#</blockquote>
				<p>&nbsp;</p>
				<p>#myOptions.orderText#</p>
				<br />&nbsp;<br />
				</cfoutput>
			</cfsavecontent>
			
			<cfquery name="qFinalizeOrder" datasource="#request.dsn#">
				UPDATE scrip_order
				SET bCompleted = <cfqueryparam cfsqltype="cf_sql_bit" value="1" />,
				    order_total = <cfqueryparam cfsqltype="cf_sql_float" value="#totalPrice#" />
				WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.order_id#" />
			</cfquery>
			
			
			<cfset mailAttributes = {
				to="#arguments.emailAddress#",
				from="#application.email.fromaddress#",
				subject="#application.email.subject#"
				
				}
				/>
			
			<cfset lEmailAddresses = myOptions.orderRecipient />
			<cfset lEmailAddresses = listAppend(lEmailAddresses, arguments.emailAddress) />
			<cfloop list="#lEmailAddresses#" index="email">
			<cfmail 
					to="#email#" 
					from="#arguments.emailAddress#" 
					replyto="mroe@stceciliaschool.us"
					subject="SCRIP ORDER"  
					type="html">
				<cfoutput>#strEmailBody#</cfoutput>
			</cfmail>
			</cfloop>
			
		<cfelse>
			<cfset request.order_id = 0 />
		</cfif>
		
		
		
		
		<cfreturn request.order_id />
	</cffunction>

</cfcomponent>
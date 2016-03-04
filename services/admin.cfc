<cfcomponent output="false">


	<!---	//	ACCOUNTS	//	--->
	<cffunction name="getAccounts">
		<cfargument name="account_id" type="numeric" required="false" default="0"/>
		<cfargument name="emailaddress" type="string" required="false" default="" />
		
		<cfquery name="qAccounts" datasource="#request.dsn#">
			SELECT *
			FROM scrip_account
			WHERE 1=1
			<cfif arguments.account_id NEQ 0>
				AND account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account_id#" />
			</cfif>
			<cfif LEN(arguments.emailaddress) GT 0>
				AND emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailaddress#" />
			</cfif>
		</cfquery>
		
		<cfreturn qAccounts>

	</cffunction>
	
	<cffunction name="getAccountByID">
		<cfargument name="account_id" type="numeric" required="true" default="-1"/>
		
		<cfquery name="qAccounts" datasource="#request.dsn#">
			SELECT *
			FROM scrip_account
			WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account_id#" />
		</cfquery>
		
		<cfreturn qAccounts>

	</cffunction>
	
	
	<cffunction name="saveAccount" returntype="any">
		<cfargument name="account_id" type="numeric" required="true" default="0"/>
		<cfargument name="emailaddress" type="string" required="true" default="" />
		<cfargument name="password" type="string" required="true" default="" />
		<cfargument name="displayname" type="string" required="true" default="" />
		<cfargument name="dbax" type="string" required="false" default="insert" />
		
		<cfswitch expression="#arguments.dbax#">
		
			<cfcase value="insert">
				<!---	Check to make sure I'm not entering a duplicate email address	--->
				<cfquery name="qAccountCheck" datasource="#request.dsn#">
					SELECT *
					FROM scrip_account
					WHERE emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.emailaddress)#">
				</cfquery>
				
				<cfif qAccountCheck.recordCount EQ 0>
				
					<cfquery name="saveAccount" datasource="#request.dsn#" result="myResult">
						INSERT INTO scrip_account (emailaddress,password,displayname)
						VALUES
						(
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailaddress#" />,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#" />,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.displayname#" />
						)
					</cfquery>
			
				<cfelse>
					<cfset myResult = "Duplicate Account Exists.  Try using a different email address." />
				</cfif>
			
			</cfcase>
			
			
			<cfcase value="update">
				<cfquery name="updateAccount" datasource="#request.dsn#" result="myResult">
					UPDATE scrip_account 
					SET	 
						emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailaddress#" />,
						password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#" />,
						displayname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.displayname#" />
						
					WHERE
						account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account_ID#" />
				</cfquery>
			</cfcase>
		
		
			<cfcase value="delete">
				<cfquery name="deleteAccount" datasource="#request.dsn#" result="myResult">
					DELETE
					FROM scrip_account
					WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account_id#" />
				</cfquery>
			</cfcase>
		
			<cfdefaultcase>
			
			</cfdefaultcase>
		
		</cfswitch>

		
		
		
		
		
		<cfreturn myResult>

	</cffunction>

	
	<!---	//	CARDS	//	--->
	<cffunction name="getCardsByVendorID">
		<cfargument name="vendor_id" type="numeric" required="true" />
		<cfquery name="qCards" datasource="#request.dsn#">
			SELECT *
			FROM scrip_card
			WHERE vendor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.vendor_id#" />
		</cfquery>
		<cfreturn qCards />
	</cffunction>

	<cffunction name="getCardsByVendor">
		<cfargument name="vendor_id" type="numeric" required="true" default="-1">
		
		<cfquery name="qCards" datasource="#request.dsn#">
			SELECT C.card_id, C.denomination, C.code, V.vendor, V.vendor_id
			FROM scrip_card C, scrip_vendor V
			WHERE C.vendor_ID = V.vendor_ID
			AND V.vendor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.vendor_ID#">
		</cfquery>
		
		<cfreturn qCards />
	</cffunction>
	
	
	<cffunction name="deleteCard">
		<cfargument name="card_id" type="numeric" required="true" default="-1" />
		<cfquery name="qCards" datasource="#request.dsn#">
			DELETE from scrip_card
			WHERE card_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.card_id#" />
		</cfquery>
		
		<cfreturn true />
	</cffunction>

	<cffunction name="saveCard">
		<cfargument name="vendor_id" type="numeric" required="true" default="-1" />
		<cfargument name="denomination" type="numeric" required="true" default="-1" />
		<cfargument name="code" type="string" required="true" default="T" />
		<cfquery name="qCards" datasource="#request.dsn#">
			INSERT INTO scrip_card
			(vendor_id, denomination, code)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.vendor_id#" />,
				<cfqueryparam cfsqltype="cf_sql_float" value="#arguments.denomination#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.code#">
			)
		</cfquery>
		
		<cfreturn true />
	</cffunction>


	<!---	//	CATEGORIES	//	--->
	<cffunction name="getCategories">
		<cfquery name="qCategories" datasource="#request.dsn#">
			SELECT * 
			FROM scrip_category
			ORDER BY category
		</cfquery>
		<cfreturn qCategories />
	</cffunction>
	
	<cffunction name="saveCategory">
		<cfargument name="category_id" type="numeric" required="true" default="-1" />
		<cfargument name="category" type="string" required="true" default="" />
		
		
		<cfif arguments.category_ID GT 0>
			<!---	Assume we are updating	--->
			<cfquery name="addCategory" datasource="#request.dsn#">
				UPDATE scrip_category
				SET
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.category)#" />
				WHERE
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.category_id#" />
			</cfquery>
			
		<cfelse>
			<!---	We must have a new one	--->
			<cfquery name="addCategory" datasource="#request.dsn#">
				INSERT INTO scrip_category
				(category)
				VALUES
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.category)#" />
				)
			</cfquery>
		</cfif>
		<cfreturn true />
	</cffunction>

	<cffunction name="deleteCategory">
		<cfargument name="category_id" type="numeric" required="true">
		<cfquery name="qDeleteCategory" datasource="#request.dsn#">
			DELETE FROM scrip_category
			WHERE category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.category_id#" />
		</cfquery>
		<cfreturn true />
	</cffunction>




	<!---	//	ORDERS	//	--->
	<cffunction name="getOptions">
		<cfquery name="qOptions" datasource="#request.dsn#">
			SELECT * 
			FROM scrip_options
		</cfquery>
		<cfreturn qOptions>
	</cffunction>
	
	
	

	
	<!---	//	ORDERS	//	--->
	<cffunction name="getOrder">
		<cfargument name="order_key" type="string" required="false" default="ZZZZ" />
		<cfquery name="myOrder" datasource="#request.dsn#">
			SELECT O.*, OC.*, C.*, V.*
			FROM scrip_order O, scrip_order_cards OC, scrip_card C, scrip_vendor V
			WHERE O.order_id = OC.order_id
			AND OC.card_id = C.card_id
			AND C.vendor_id = V.vendor_id
			AND O.order_key = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.order_key)#" />
		</cfquery>
		<cfreturn myOrder />
	</cffunction>
	
	
	<cffunction name="getOrders">
		<cfargument name="customer_name" type="string" required="false" default="" />
		<cfquery name="qOrders" datasource="#request.dsn#">
			SELECT * 
			FROM scrip_order
			WHERE bDisplayOrder = 1
			<cfif LEN(arguments.customer_name) GT 0>
			AND customer_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.customer_name)#" />
			</cfif>
			ORDER BY order_id DESC
		</cfquery>
		<cfreturn qOrders />
	</cffunction>
	

	<cffunction name="hideOrder">
		<cfargument name="order_key" type="string" required="true" default="-1" />
		<cfquery name="qhideOrder" datasource="#request.dsn#">
			UPDATE scrip_order
			SET bDisplayOrder = 0
			WHERE order_key = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.order_key#">
		</cfquery>
	</cffunction>
	
	<!---	//	CUSTOMERS	//	--->
	<cffunction name="getCustomers">
	
		<cfquery name="qCustomers" datasource="#request.dsn#">
			SELECT distinct(customer_name)
			FROM scrip_order
			ORDER BY customer_name
		</cfquery>
		<cfreturn qCustomers />
	</cffunction>


	<!---	//	VENDORS	//	--->
	<cffunction name="getVendors">
		<cfquery name="qVendors" datasource="#request.dsn#">
			SELECT V.vendor_ID, V.category_ID, V.vendor, V.discount, V.instock, V.notes, C.category
			FROM scrip_vendor V, scrip_category C
			WHERE V.category_ID = C.category_ID
			ORDER BY category, LOWER(vendor)
		</cfquery>
		
		<cfreturn qVendors />
	</cffunction>
	
	
	<cffunction name="getVendorByID">
		<cfargument name="vendor_id" type="numeric" required="true" default="-1">
		
		<cfquery name="qVendor" datasource="#request.dsn#">
			SELECT V.vendor_ID, V.category_ID, V.vendor, V.discount, V.instock, V.notes, C.category
			FROM scrip_vendor V, scrip_category C
			WHERE V.category_ID = C.category_ID
			AND V.vendor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.vendor_ID#">
			ORDER BY category, vendor
		</cfquery>
		
		<cfreturn qVendor />
	</cffunction>
	
	
		
	
	<cffunction name="saveVendor">
		<cfargument name="vendor_id" type="numeric" required="true" default="-1" />
		<cfargument name="category_id" type="numeric" required="true" default="-1" />
		<cfargument name="vendor" type="string" required="true" default="" />
		<cfargument name="discount" type="numeric" required="true" default="" />
		<cfargument name="instock" type="string" required="true" default="0" />
		<cfargument name="notes" type="string" required="false" default="" />
		<cfargument name="dbax" type="string" required="false" default="nothing" />
		
		<cfif arguments.instock EQ "off">
			<cfset arguments.instock = 0 />
		<cfelse>
			<cfset arguments.instock = 1 />
		</cfif>
		
		<cfswitch expression="#trim(arguments.dbax)#">
		
			<cfcase value="add">
				<cfquery name="qAddVendor" datasource="#request.dsn#" result="myAddResult">
					INSERT INTO scrip_vendor
					(
						category_id,vendor,discount,instock,notes
					)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.category_id#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vendor#" />,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.discount#" />,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.instock#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.notes#" />
					)
				</cfquery>
				<cfset returnValue = myAddResult.GENERATED_KEY />
			</cfcase>
			
			<cfcase value="update">
				<cfquery name="qUpdateVendor" datasource="#request.dsn#">
					UPDATE scrip_vendor
					SET
						category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.category_id#" />,
						vendor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vendor#" />,
						discount = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.discount#" />,
						instock = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.instock#" />,
						notes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.notes#" />
					WHERE
						vendor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.vendor_id#" />
				</cfquery>
				<cfset returnValue = arguments.vendor_id />
			</cfcase>
			
			<cfcase value="delete">
				<!---	Before you delete a vendor, check to see if they have any cards	--->
				<cfset vendorCards = getCardsByVendorID(arguments.vendor_id) />
				<cfif vendorCards.recordCount EQ 0>
					<cfquery name="qDeleteVendor" datasource="#request.dsn#">
						DELETE FROM scrip_vendor
						WHERE vendor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.vendor_id#" />
					</cfquery>
					
				</cfif>
				<cfset returnValue = true />
			</cfcase>
		
		
			<cfdefaultcase>
				<cfset returnValue = "0">
			</cfdefaultcase>
		</cfswitch>
		
		
		<cfreturn returnValue />
	</cffunction>


	<cffunction name="saveOptions">
		<cfargument name="orderrecipient" type="string" required="true" default="" />
		<cfargument name="ordertext" type="string" required="true" default="" />
		
		<cfquery name="setOptions" datasource="#request.dsn#">
			UPDATE scrip_options
			SET orderRecipient = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.orderRecipient#" />,
			    orderText = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.orderText#" />
		</cfquery>
		
		<cfreturn true />
		
	</cffunction>


	
</cfcomponent>
<!---
	items:  An Array of Structs.  Each struct represents an order item.
--->

<cfcomponent displayname="An Order Object" output="false">

	<cfset this.items = ArrayNew(1) />


	<cffunction name="init" output="false" returntype="any">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="addCard" output="false" returntype="any" hint="Adds a item to the order.">
		<cfargument name="card_id" type="numeric" required="true" />
		<cfargument name="quantity" type="numeric" required="true" />
		
		<!---	Get the card and vendor information --->
		<cfquery datasource="#request.dsn#" name="qCard">
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
			ArrayAppend(this.items, myItem);
						
		</cfscript>
		
		<cfreturn true />
	</cffunction>
	
	<!--- Removes an item from the order.  --->
	<cffunction name="removeCard" output="false" returntype="any">
		<cfargument name="arrayPos" type="numeric" required="true" />
			
		<cfscript>
			ArrayDeleteAt(this.items, arguments.arrayPos);
			//StructDelete(this.items, arguments.card_id);			
		</cfscript>
		
		<cfreturn true />
	</cffunction>
	
	<!--- Removes an item from the order.  --->
	<cffunction name="clear" output="false" returntype="any">
		<cfset ArrayClear(this.items) />
		<cfreturn true />
	</cffunction>

</cfcomponent>
<script type="text/javascript">
	$.ready() {
		var spinner = $("#quantity").spinner();
	}
	
	
</script>

<cfscript>
	var editClass = "";
	if (getItem() eq 'review') {
		editClass = "disabled";	
	}
</cfscript>
	

<h3>Order Cards:</h3>
<cfform action="#buildURL('cart.addCard')#" name="scripForm" id="scripForm" class="form">
	<cfoutput>
	<div class="control-group">
		<label class="control-label" for="card_id">Select a Card:</label>
		<div class="controls">
			
			<select name="card_id" class="input-xlarge #editClass#">
				<cfoutput query="rc.myCards">
					<option value="#card_id#">#carddescription#<cfif rc.myCards.instock>*</cfif></option>
				</cfoutput>
			</select><div class="control-group">
		<label class="control-label" for="quantity">Qty:</label>
		<div class="controls">
			<cfinput type="text" name="quantity" id="quantity" value="1" validate="integer" message="Please enter a whole number (integer) for the quantity of cards you want." class="input-mini" />
		</div>
	</div>
			<!--- <cfselect name="card_id" query="#rc.myCards#" display="carddescription" value="cardID"> --->
		</div>
	</div>
	
	</cfoutput>
	
	<div class="control-group">
		<div class="controls">
			<cfinput type="submit" name="Submit" value="Add to Order >>" />
		</div>
	</div>
				
</cfform>


<!--- <div class="alert alert-info">
* card is usually in stock
</div> --->

<!--- <cfif ArrayLen(session.order.items)>
	<cfoutput>
	<h2><a href="#buildURL('cart.display')#">Your Order</a></h2>
	
	<ul>
	<cfloop array="#session.order.items#" index="myItem">
		<li>#myItem.vendor#  (#LSCurrencyFormat(myItem.subtotal)#)</li>
	</cfloop>
	</ul>
	<a href="#buildURL('cart.clear')#">Remove All</a>
	</cfoutput>
<cfelse>

	<h2>What is Scrip?</h2>
	<p>Scrip is a great way to support St. Cecilia School with very little effort!  Simply stated,
	scrip is gift cards - just like the ones you can purchase from any grocery store, restaurant
	or retail store.  Our program purchases them at a discount and you pay face value.  It's a
	win-win situation!</p>
</cfif> --->

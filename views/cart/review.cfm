<cfoutput>
<h2 class="title">Review your order:</h2>

<cfset orderTotal = 0 />

<table class="table table-bordered table-striped table-condensed">
	<thead>
	<tr>
		<th>Card</th>
		<th><span class="pull-right">Qty</span></th>
		<th><span class="pull-right">Price</span</th>
		<th><span class="pull-right">Total</span</th>

	</tr>
	</thead>
	<cfset counter = 1 />
	<tbody>
	<cfloop array="#session.order.items#" index="myItem">
		<cfif NOT myItem.instock>
			<cfset stockWarning = true />
		</cfif>
		<cfset orderTotal = orderTotal + myItem.subtotal />
		<tr>
			<td>#myItem.vendor#</td>
			<td><span class="pull-right">#myItem.quantity#</span></td>
			<td><span class="pull-right">#LSCurrencyFormat(myItem.denomination)#</span></td>
			<td><span class="pull-right">#LSCurrencyFormat(myItem.subtotal)#</span></td>
		</tr>
		
		<cfset counter = counter + 1 />
	</cfloop>
	
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><span class="pull-right"><strong>#LSCurrencyFormat(orderTotal)#</strong></span></td>
		</tr>
	</tbody>
</table>

<br />
<p>In order to submit the above Scrip Order, please enter your name, e-mail address and press the 'Process Order' button.  A 
copy of this order will be e-mailed to you, and another copy will be e-mailed to the Scrip Administrator.</p>

<p></p>

<cfform action="index.cfm" name="orderForm" method="post" class="form">
	<cfinput type="hidden" name="action" value="cart.sendOrder" />
	
	<div class="control-group">
		<label for="name" class="control-label">Your name:</label>
		<div class="controls">
			<cfinput type="text" name="name" value="" size="25" maxlength="50" required="true" message="Please enter your name." />
		</div>
	</div>
	
	<div class="control-group">
		<label for="emailAddress" class="control-label">Your Email:</label>
		<div class="controls">
			<cfinput type="text" name="emailAddress" value="" size="25" maxlength="50" required="true" message="Please enter an e-mail address." />
		</div>
	</div>
	
	
	<div class="control-group">
		<label for="name" class="control-label">Comments:</label>
		<div class="controls">
			<textarea name="notes" rows="3" class="input-xxlarge"></textarea>
		</div>
	</div>
	
	<div class="control-group">
		<div class="controls">
			<cfinput type="submit" name="Submit" value="Submit Order" class="btn btn-primary" />
		</div>
	</div>
	
	


</cfform>
</cfoutput>

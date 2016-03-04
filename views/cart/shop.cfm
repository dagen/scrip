<cfoutput>

<h2 class="title">Your Order</h2>

<cfset orderTotal = 0 />
<cfset stockWarning = "false" />

<table class="table table-bordered table-striped table-condensed">
	<thead>
	<tr>
		<th>&nbsp;</th>
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
			<td class="pagination-centered"><a href="#buildURL(action='cart.removeCard',queryString='arrayPos=' & counter)#"><i class="icon icon-remove" title="Remove this item"></i></a></td>
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
			<td>&nbsp;</td>
			<td><span class="pull-right"><strong>#LSCurrencyFormat(orderTotal)#</strong></span></td>
		</tr>
	</tbody>
</table>

	
	
<!--- 	<cfform action="index.cfm" name="reviewOrder" method="get">
		<cfinput type="hidden" name="action" value="cart.review" />
		<cfif counter GT 1>
			<cfinput type="submit" name="submit" value="Submit your order" />
		</cfif>
	</cfform> --->



<cfif ArrayLen(session.order.items) GT 0>

<cfif stockWarning>
<div class="alert alert-error clearfix">
	<p>Some items of your order may not be in stock.  If your order is received prior to 9am on Tuesday
	morning, then your cards will usually be available on Thursday afternoon.  If your order is received after 9am on Tuesday,
	then your cards may not be available until the following Thursday.</p>
<cfelse>
<div class="alert alert-success clearfix">
	<p>All of your ttems are most likely in stock and ready to be picked up or sent home once payment is received.</p>
	<p>If we cannot fill the order immediately, it will be ordered this next Tuesday and available Thursday at noon.</p>
</cfif>
</div>
</cfif>

<cfif ArrayLen(session.order.items)>
<p class="pull-right"><a href="#buildURL('cart.review')#" class="btn btn-primary">Submit Order</a></p>
</cfif>

</cfoutput>




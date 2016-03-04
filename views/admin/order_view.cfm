<cfoutput>
<h2>Viewing Order Number: #rc.myOrder.order_id#</h2>

</cfoutput>
<p>&nbsp;</p>
<table class="table table-striped table-bordered">
	<tbody>
	<cfoutput query="rc.myOrder" group="customer_name">
	<tr>
		<th>Customer</th>
		<td><a href="mailto:#rc.myORder.customer_email#">#rc.myOrder.customer_name#</a></td>
	</tr>
	
	<tr>
		<th>Order Date</th>
		<td>#LSDateFormat(rc.myOrder.order_date)#, #LSTimeFormat(rc.myOrder.order_date)#</td>
	</tr>
	
	<tr>
		<th>Notes</th>
		<td>#rc.myOrder.order_notes#</td>
	</tr>
	</tbody>
	</cfoutput>
</table>

<p>&nbsp;</p>
<h3>Cards</h3>
<table class="table table-striped table-bordered">
	<thead>
	<tr>
		<th>Vendor</th>
		<th>Amount</th>
		<th>Qty.</th>
		<th>SubTotal</th>
	</tr>
	</thead>
	<tbody>
	<cfoutput query="rc.myOrder">
	<tr>
		<td>#rc.myOrder.vendor#</td>
		<td class="right">#LSCurrencyFormat(rc.myOrder.denomination)#</td>
		<td class="right">#rc.myOrder.qty#</td>
		<td class="right">#LSCurrencyFormat(rc.myOrder.denomination * rc.myOrder.qty)#</td>
	</tr>
	</cfoutput>
	<cfoutput>
	<tr>
		<td colspan="3"><em>Total:</em></td>
		<td class="right"><strong>#LSCurrencyFormat(rc.myOrder.order_total)#</strong></td>
	</tr>
	</cfoutput>
	</tbody>
</table>

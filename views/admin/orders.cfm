<cfscript>
	param name="rc.startRow" default="1";
	param name="rc.customer_name" default="";
	request.maxrows = 10;
	if (rc.qOrders.recordCount LTE rc.startRow + request.maxrows) {
		request.endRow = rc.qOrders.recordCount;
	}
	else {
		request.endRow = rc.startrow + request.maxrows - 1;
	}
	
	
		
	if (rc.startRow LTE request.maxrows) {
		request.prevStart = 1;	
	}
	else {
		request.prevStart = rc.startRow - request.maxrows;	
	}
	
	if (rc.startRow LTE (rc.qOrders.recordCount - request.maxrows)) {
		request.nextStart = rc.startRow + request.maxrows;	
	}
	else {
		request.nextStart = rc.startRow;	
	}
	

	
	

</cfscript>

<h2>Orders Received Online</h2>

<p>The following is a list of orders that have been received online.</p>
<cfform action="index.cfm" name="orderFilters" method="post">
	<input type="hidden" name="action" value="admin.orders" />
	<p>Only show orders from:

	<cfselect name="customer_name" query="rc.qCustomers" display="customer_name" value="customer_name" selected="#rc.customer_name#"></cfselect>
	
	
	
	<cfoutput>
	<cfinput type="submit" name="submit" value="Go" class="btn btn-small btn-primary" />
	&nbsp; &nbsp; &nbsp; <a href="#buildURL('admin.orders')#">Show All</a>
	</cfoutput>
			
			
	
</cfform>




<table class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>Order Date</th>
		<th>Customer</th>
		<th>Total</th>
		<th>Options</th>
	</tr>
	</thead>
	<tbody>
	<cfoutput query="rc.qOrders" startrow="#rc.startRow#" maxrows="#request.maxrows#">
	<cfif currentRow MOD 2 EQ 0><tr><cfelse><tr class="oddrow"></cfif>
		<td>#LSDateFormat(rc.qOrders.order_date, 'mm/dd/yy')#</td>
		<td>#rc.qOrders.customer_name#&nbsp;</td>
		<td>#LSCurrencyFormat(rc.qOrders.order_total)#</td>
		<td><a href="#buildURL(action='admin.order_view', queryString='order_key=' & rc.qOrders.order_key)#">view</a> |
		<a href="#buildURL(action='admin.order_hide', queryString='order_key=' & rc.qOrders.order_key)#">hide</a></td>
	</tr>
	</cfoutput>
	</tbody>
</table>

<cfoutput>
<p>&nbsp;</p>
<ul class="pager">
	<li><a href="#buildURL(action='admin.orders', queryString='startRow=' & request.prevStart)#">Previous</a></li>
	<li>#NumberFormat(rc.startRow, '999')# - #NumberFormat(request.endRow, '999')# of #rc.qOrders.recordcount# orders.</li>
	<li><a href="#buildURL(action='admin.orders', queryString='startRow=' & request.nextStart)#">Next</a></li>
</ul>

</cfoutput>

<br />&nbsp;<br />
<p>'Hide' orders to remove them from this display.  A record of the order is still in the database,
but you'll probably have to ask Damon to get the data back for you.  We are keeping the data in
the database for future reports.</p>
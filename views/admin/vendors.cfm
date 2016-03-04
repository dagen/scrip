<h2 class="title">Vendors</h2>

<p>The following table displays a list of vendors for Scrip.</p>


<cfoutput>
	<p>
	<span class="pull-right">
		<a href="#buildURL(action='admin.vendor_edit')#" class="btn btn-primary">Add New Vendor</a>
	</span>
	</p>
</cfoutput>



<table class="table table-bordered table-striped table-condensed">
	<thead>
		<tr>
			<th>Vendor</th>
			<th>Discount</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
	<cfoutput query="rc.myVendors" group="category">
	<tr class="alert alert-info">
		<td colspan="3"><strong>#rc.myVendors.category#</strong></td>
	</tr>
	<cfoutput>
	<cfif rc.myVendors.inStock EQ 1>
		<cfset stockClass = "instock" />
	<cfelse>
		<cfset stockClass = "" />
	</cfif>

	<tr class="#stockclass#">
		<td>#rc.myVendors.vendor#</td>
		<td>#rc.myVendors.discount#%</td>
		<td>
			<a href="#buildURL(action='admin.vendor_edit', queryString='vendor_id=' & rc.myVendors.vendor_ID)#">edit</a> |
			<a href="#buildURL(action='admin.vendor_cards', queryString='vendor_id=' & rc.myVendors.vendor_ID)#">cards</a>
		</td>
	</tr>
	</cfoutput>
	</cfoutput>
	</tbody>
</table>

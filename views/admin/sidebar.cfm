<cfscript>
	lItems = "accounts,vendors,categories,orderoptions,orders";
	stItems = StructNew();
	for (i=1; i LTE ListLen(lItems); i = i + 1) {
		stItems[listGetat(lItems, i)] = "";	
	}
	
	stItems[getItem()] = 'active';
</cfscript>

<cfoutput>

<div class="well affix">
<h2>Admin</h2>
<ul class="nav nav-pills nav-stacked">
	<li class="#stItems['accounts']#"><a href="#buildURL('admin.accounts')#">Manage Accounts</a></li>
	<li class="#stItems['vendors']#"><a href="#buildURL('admin.vendors')#">Manage Vendors</a></li>
	<li class="#stItems['categories']#"><a href="#buildURL('admin.categories')#">Manage Categories</a></li>
	<li class="#stItems['orderoptions']#"><a href="#buildURL('admin.orderoptions')#">Manage Order Options</a></li>
	<li class="#stItems['orders']#"><a href="#buildURL('admin.orders')#">View Submitted Orders</a></li>
</ul>
</div>
</cfoutput>
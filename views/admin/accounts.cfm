<h2 class="title">Admin Users</h2>

<p>The following users are considered 'admin' users.  They can log into the site and make changes
to the database.</p>

<cfoutput>
<p><a href="#buildURL(action='admin.account_edit',querystring='account_id=-1')#" class="btn btn-primary">Add New Account</a></p>
</cfoutput>

<table class="table table-striped table-bordered">
	<thead>
	<tr>
		<th>Account</th>
		<th>E-Mail Address</th>
		<th>Options</th>
	</tr>
	</thead>
	<tbody>
	<cfoutput query="rc.qAccounts">
	<tr>
		<td>#rc.qAccounts.displayname#</td>
		<td>#rc.qAccounts.emailaddress#</td>
		<td><a href="#buildURL(action='admin.account_edit', queryString='account_id=' & rc.qAccounts.account_id)#">edit</a></td>
	</tr>
	</cfoutput>
	</tbody>
</table>


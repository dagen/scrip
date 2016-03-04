<h2 class="title">Categories</h2>

<p>All vendor cards must be associated with a category.  Use this page to manage the list of categories.</p>

<p class="warning">Please use extra caution when deleting categories.  Removing a category will also remove the relationship
between cards and categories.  Vendor Cards with no associated category will not be displayed on the order
form, or in the back-end admin section.</p>

<cfform action="index.cfm" name="categoryForm" id="categoryForm">

	<cfinput type="hidden" name="action" value="admin.category_save" />
	<cfinput type="hidden" name="category_id" value="-1" />
	<cfinput type="hidden" name="dbax" value="add" />

<table class="table table-striped table-bordered">
	<thead>
	<tr>
		<th>Category</th>
		<th>Action</th>
	</tr>
	</thead>
	<tbody>
	<cfoutput query="rc.qCategories">
	<tr>
		<td>#rc.qCategories.category#</td>
		<td><a href="#buildURL(action='admin.category_delete', queryString='category_ID=' & rc.qCategories.category_ID)#">delete</a></td>
	</tr>
	</cfoutput>
	<tr>
		<td>
			<cfinput type="text" name="category" value="" required="true" message="Please enter a category." />
		</td>
		
		<td>
			<cfinput type="submit" name="Submit" value="Save New Category" />
		</td>
	</tr>
	</tbody>
</table>
</cfform>


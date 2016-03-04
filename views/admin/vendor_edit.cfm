<!---	'attributes.vendor_id' is ensured by the model.  --->
<cfif rc.vendor_id LT 0>
	<cfset attributes.dbax = "add" />
	<cfset titleTxt = "Add a New Vendor" />
<cfelse>
	<cfset attributes.dbax = "update" />
	<cfset titleTxt = "Edit Vendor" />
</cfif>


<cfoutput>
<h2 class="title">#titleTxt#</h2>
</cfoutput>


<cfform name="vendorForm" id="vendorForm" action="#self#" method="post">
	<cfinput type="hidden" name="action" value="admin.vendor_save" />
	<cfinput type="hidden" name="dbax" id="dbax" value="#attributes.dbax#" />
	<cfinput type="hidden" name="vendor_id" value="#rc.vendor_id#" />
	
		<fieldset>
			<legend>Vendor Information</legend>
			<ul>
				<li>
					<label for="vendor">Name: <em>*</em></label>
					<cfinput type="text" name="vendor" value="#rc.myVendor.vendor#" required="true" />		
				</li>
				<li>
					<label for="category_id">Category: <em>*</em></label>
					<cfselect query="rc.myCategories" name="category_id" value="category_id" display="category" selected="#rc.myVendor.category_id#" />
				</li>
				<li>
					<label for="discount">Discount: <em>*</em></label>
					<cfinput type="text" name="discount" value="#rc.myVendor.discount#" required="true"/>% (do not add the '%' sign in this field)
				</li>
				<li>
					<label for="instock">In Stock?: </label>
					<cfinput type="checkbox" name="instock" checked="#YesNoFormat(rc.myVendor.instock)#" />
				</li>
				<li>
					<label for="notes">Notes</label>
					<cfoutput>
					<textarea name="notes" cols="48" rows="8">#rc.myVendor.notes#</textarea>
					</cfoutput>
				</li>
			</ul>
		
		
		</fieldset>
		
		<br />&nbsp;		
		
		<cfinput type="submit" name="Submit" value="Save" /> &nbsp;&nbsp;
		<cfif rc.myCards.recordCount EQ 0>
			<cfinput type="button" name="Delete" value="Delete" onclick="verifyDelete();" />&nbsp;&nbsp;
		</cfif>
		<cfinput type="button" name="Cancel" value="Cancel" onclick="javascript:window.history.back();" />

</cfform>


<script type="text/javascript">
<!-- //
	function verifyDelete() {
		userResponse = confirm("Are you sure you wish to delete this record?\n\nThis action cannot be undone.\n\nClick 'OK' to delete this record, or 'Cancel' to return to the form.'");
		if (userResponse) {
			$('#dbax').val('delete');
			//$('#vendorForm').submit();
			document.getElementById('vendorForm').submit();
			return true;
		}
		else {
			return false;
		}
	}
// -->
</script>

<hr />




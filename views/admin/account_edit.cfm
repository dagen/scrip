<!---	'attributes.account_id' is ensured by the model.  --->
<cfif rc.account_id LT 0>
	<cfset dbax = "insert" />
	<cfset titleTxt = "Add a New Account" />
<cfelse>
	<cfset dbax = "update" />
	<cfset titleTxt = "Edit Account" />
</cfif>


<cfoutput>
<h2 class="title">#titleTxt#</h2>
</cfoutput>


<cfform name="accountForm" id="accountForm" action="index.cfm" method="post">
	<cfinput type="hidden" name="action" value="admin.account_save" />
	<cfinput type="hidden" name="account_id" value="#rc.account_id#" />
	<cfinput type="hidden" name="dbax" id="dbax" value="#dbax#" />

	<fieldset>
		<legend>Account Information</legend>
				<label for="displayname">Name: <em>*</em></label>
				<cfinput type="text" name="displayname" value="#rc.qAccount.DisplayName#" required="true" />		
				<label for="emailaddress">E-Mail Address: <em>*</em></label>
				<cfif rc.account_id GT 0>
					<cfinput type="text" name="emailaddress" value="#rc.qAccount.emailaddress#" readonly="true"/> (cannot change this field)
				<cfelse>
					<cfinput type="text" name="emailaddress" value="#rc.qAccount.emailaddress#" required="true"/>
				</cfif>
				<label for="password">Password: </label>
				<cfinput type="password" name="password" value="" required="true"/>
	</fieldset>

	<br />&nbsp;		
	
	<cfinput type="submit" name="Submit" value="Save" /> &nbsp;&nbsp;
	<cfif rc.qAccount.account_id GT 0>
		<cfinput type="button" name="Delete" value="Delete" onclick="javascript:verifyDelete();" /> &nbsp;&nbsp;
	</cfif>
	<cfinput type="button" name="Cancel" value="Cancel" onclick="javascript:window.history.back();" />

</cfform>


<script type="text/javascript">

	function verifyDelete() {
		userResponse = confirm("Are you sure you wish to delete this record?\n\nThis action cannot be undone.\n\nClick 'OK' to delete this record, or 'Cancel' to return to the form.'");
		if (userResponse) {
			document.getElementById('dbax').value = 'delete';
			document.getElementById('accountForm').submit();
			return true;
		}
		else {
			return false;
		}
	}
</script>


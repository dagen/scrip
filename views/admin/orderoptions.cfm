<h2 class="title">Order Options</h2>
<p>Use this form to update information used when processing order forms.</p>

<cfform name="optionsForm" id="optionsForm" action="index.cfm" method="post" class="form">
	<cfinput type="hidden" name="action" value="admin.orderoptions_save" />
	
		<legend>Order Options</legend>
		<label for="scripAdmins">Order Recipient(s): <em>*</em></label>
		<cfinput type="text" name="orderRecipient" value="#rc.qOptions.OrderRecipient#" required="true" class="input-xxlarge"/>		
		<label for="orderText">Order Text: <em>*</em></label>
		<textarea name="orderText" id="orderText" rows="5"><cfoutput>#rc.qOptions.OrderText#</cfoutput></textarea>
		<label for="submit">&nbsp;</label>
		<cfinput type="submit" name="Submit" value="Save Changes" class="btn btn-primary" />
	</fieldset>

	
</cfform>

<dl>
	<dt>Order Recipient(s)</dt>
	<dd>This is the e-mail address that the system will use to send the scrip orders.  To use more than one address,
simply seperate e-mail addresses with a comma.</dd>


	<dt>Order Text</dt> 
	<dd>This is the text (or copy) that will be displayed to the user when they submit their order.  It will also be
provided to the customer on the confirmation e-mail that they receive.  Use this space to post instructions, or
other messages for each order.</dd>
</dl>
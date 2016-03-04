<h2>Vendor Cards</h2>
<p>The purpose of this page is to show all cards by a vendor.</p>


<cfform action="index.cfm" name="vendorCardForm" id="vendorCardForm">
	<cfinput type="hidden" name="action" value="admin.vendor_cards_save" />
	<cfinput type="hidden" name="vendor_id" value="#rc.vendor_id#" />
	

<table class="table table-striped table-bordered span6">
	<thead>
		<tr>
			<th>Denomination</th>
			<th>Code</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="#rc.myCards#">
		<tr>
			<td><span class="pull-right">#LSCurrencyFormat(rc.myCards.denomination)#</span></td>
			<td>#rc.myCards.code#</td>
			<td>
				<a href="#buildURL(action='admin.vendor_card_delete', querystring='card_id=' & rc.myCards.card_id & '&vendor_id=' & rc.myCards.vendor_id)#"><i class="icon-remove"></i></a>
			</td>
		</tr>
		</cfoutput>
		
		<tr>
			<td>
				<span class="pull-right">
				$ <cfinput type="text" name="denomination" value="" class="span1" required="true" message="Please enter a denomination." validate="float"/ >
				</span>
			</td>
			<td>
				<cfinput type="text" name="code" value="" />
			</td>
			<td>
				<cfinput type="submit" name="submit" value="Save" />
			</td>
		</tr>
	</tbody>

</table>
</cfform>

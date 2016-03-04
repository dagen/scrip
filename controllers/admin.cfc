component {
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public void function before( rc ) {
		if (session.userinfo.displayname EQ "guest") {
			variables.fw.redirect(action="security.login");	
		}
	}
	
	
	// ACCOUNTS
	public void function accounts( rc ) {
		variables.fw.service('admin.getAccounts', 'qAccounts');	
	}
	

	
	public void function account_edit ( rc ) {
		param name="rc.account_id" default="-1" type="numeric";
		variables.fw.service('admin.getAccounts', 'qAccount', {account_id = rc.account_id});
		
	}
	
	public void function account_save ( rc ) {
		variables.fw.service('admin.saveAccount', 'myAccount', 
			{
				account_id = rc.account_id,
				emailaddress = rc.emailaddress,
				password = rc.password,
				displayname = rc.displayname				
			}
		);
	}
	public void function endaccount_save ( rc ) {
		variables.fw.redirect(action='admin.accounts');	
	}
	
	
	// CATEGORIES
	public void function categories ( rc ) {
		variables.fw.service('admin.getCategories', 'qCategories');
	}
	
	public void function category_save ( rc ) {
		variables.fw.service('admin.saveCategory', 'myCategory',
			{
				category_id = rc.category_id,
				category = rc.category
			}
		
		);
	}
	
	public void function category_delete ( rc ) {
		variables.fw.service('admin.deleteCategory', 'myCategory', {category_id = rc.category_id} );
	}
	
	public void function endcategory_save ( rc ) {
		variables.fw.redirect(action='admin.categories');	
	}
	
	public void function endcategory_delete ( rc ) {
		variables.fw.redirect(action='admin.categories');	
	}
	
	
	// ORDERS
	public void function orders ( rc ) {
		param name="rc.customer_name" default="";
		variables.fw.service('admin.getOrders', 'qOrders', {customer_name = rc.customer_name});	
		variables.fw.service('admin.getCustomers', 'qCustomers');
	}
	
	public void function order_view ( rc ) {
		param name="rc.order_key" default="";
		variables.fw.service('admin.getOrder', 'myOrder', {order_key = rc.order_key});	
	}
	
	
	public void function order_hide ( rc ) {
		variables.fw.service('admin.hideOrder', 'myOrder', {order_key = rc.order_key});	
	}
	
	public void function endorder_hide ( rc ) {
		variables.fw.redirect(action='admin.orders');	
	}
	
	// ORDER OPTIONS
	public void function orderoptions ( rc ) {
		variables.fw.service('admin.getOptions', 'qOptions');
	}
	
	public void function orderoptions_save ( rc ) {
		variables.fw.service('admin.saveOptions', 'myOptions', 
		
			{
				orderrecipient = rc.orderrecipient,
				ordertext = rc.ordertext		
			}
		
		);
	}
	
	public void function endorderoptions_save ( rc ) {
		variables.fw.redirect(action='admin.orderoptions');	
	}
	
	
	// VENDORS
	public void function vendors ( rc ) {
		variables.fw.service('admin.getVendors', 'myVendors');	
	}
	
	public void function vendor_edit ( rc ) {
		param name="rc.vendor_id" default="-1";
		variables.fw.service('admin.getVendorByID', 'myVendor', {vendor_id = rc.vendor_id});
		variables.fw.service('admin.getCardsByVendor', 'myCards', {vendor_id = rc.vendor_id});	
		variables.fw.service('admin.getCategories', 'myCategories');
	}
	
	public void function vendor_save ( rc ) {
		param name="rc.instock" default="off";
		variables.fw.service('admin.saveVendor', 'myVendor', 
			{
				vendor_id = rc.vendor_id,
				category_id = rc.category_id,
				vendor = rc.vendor,
				discount = rc.discount,
				instock = rc.instock,
				notes = rc.notes,
				dbax = rc.dbax
			}
		);
	}
	
	public void function endvendor_save ( rc ) {
		variables.fw.redirect(action='admin.vendors');	
	}
	
	
	
	
	// VENDOR CARDS
	public void function vendor_cards ( rc ) {
		variables.fw.service('admin.getCardsByVendor', 'myCards', {vendor_id = rc.vendor_id});
	}
	
	public void function vendor_cards ( rc ) {
		variables.fw.service('admin.getCardsByVendor', 'myCards', {vendor_id = rc.vendor_id});
	}
	
	public void function vendor_cards_save ( rc ) {
		variables.fw.service('admin.saveCard', 'myCard', {vendor_id = rc.vendor_id, denomination = rc.denomination, code = rc.code});
	}
	
	public void function endvendor_cards_save ( rc ) {
		variables.fw.redirect(action='admin.vendor_cards', queryString='vendor_id=' & rc.vendor_id);
	}
	
	public void function vendor_card_delete ( rc ) {
		variables.fw.service('admin.deleteCard', 'myCard', {card_id = rc.card_id});
	}
	
	public void function endvendor_card_delete ( rc ) {
		variables.fw.redirect(action='admin.vendor_cards', queryString='vendor_id=' & rc.vendor_id);
	}
}
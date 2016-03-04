component {
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public void function shop( rc ) {
		 variables.fw.service('cart.getCards', 'myCards');
	}
	
	public void function addCard( rc ) {
		session.order.addCard(card_id = rc.card_id, quantity = rc.quantity);
	}
	
	public void function removeCard( rc ) {
		session.order.removeCard(arrayPos = rc.arrayPos);
		variables.fw.redirect(action='cart.shop');
	}
	
	public void function endaddCard( rc ) {
		variables.fw.redirect(action='cart.shop');
	}
	
	public void function review( rc ) {
		variables.fw.service('cart.getCards', 'myCards');
	}
	
	public void function sendOrder( rc ) {
		
		// variables.fw.service('cart.getCards', 'myCards');
		
		if (arrayLen(session.order.items) EQ 0) {
			variables.fw.redirect(action='cart.shop');
			break;
		}
		else {
		
			variables.fw.service('cart.processOrder', 'myOrderID', 
				{
					emailaddress = rc.emailaddress,
					name = rc.name,
					notes = rc.notes			
				}
			)	
		}
	}
	
	public void function endsendOrder ( rc ) {
		variables.fw.redirect('home.ordercomplete');	
	}
	
	public void function clear( rc ) {
		session.order.clear();
		variables.fw.redirect(action='cart.shop');
	}
	
}
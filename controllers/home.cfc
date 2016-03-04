component {
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public void function welcome( rc ) {
		rc.when = now(); // set when for service argument
		// queue up a specific service (formatter.longdate) with named result (today)
		// variables.fw.service( 'formatter.longdate', 'today' );
	}
	
	public void function ordercomplete ( rc ) {
		session.order.clear();	
	}
	
}
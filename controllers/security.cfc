component {
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public void function authenticate( rc ) {
		variables.fw.service('security.authenticate', 'myResult', {emailaddress=rc.emailaddress, password=rc.password});
	}
	
	public void function endauthenticate ( rc ) {
		variables.fw.redirect(action=rc.myResult.xfa);
		
	}
	
}
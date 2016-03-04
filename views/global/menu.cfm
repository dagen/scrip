<cfscript>
	lSections = "home,cart,contact,admin";
	stSections = StructNew();

	for (i=1; i LTE listlen(lSections); i = i + 1) {
		stSections[listGetAt(lSections, i)] = "";
	}

	stSections[getSection()] = 'active';
	if (getSection() EQ 'security') {
		stSections['admin'] = 'active';
	}

</cfscript>

<cfoutput>
<a class="brand">St. Cecilia SCRIP:</a>
<div class="nav-collapse collapse">
	<p class="navbar-text pull-right">
		<a href="http://dagen.net/" class="navbar-link">dagen.net</a>
	</p>
	<ul class="nav">
		<li class="#stSections['home']#"><a href="#buildURL('home.welcome')#">Home</a></li>
		<li class="#stSections['cart']#"><a href="#buildURL('cart.shop')#">Order Form</a></li>
		<li class="#stSections['contact']#"><a href="#buildURL('contact.us')#">Contact Us</a></li>
		<li class="#stSections['admin']#"><a href="#buildURL('admin.vendors')#">Admin</a></li>
	</ul>
</div>
</cfoutput>



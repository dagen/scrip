
<h2 class="title">Site Security</h2>
<p>You have requested a page on this site that requires authentication.  Please log in with your email address and 
	your password to continue.</p>

<cfform name="loginForm" action="#self#" method="post">
	<cfinput type="hidden" name="action" value="security.authenticate" />
	
	
	<div class="control-group">
		<label class="control-label" for="emailaddress">Email Address:</label>
		<div class="controls">
			<cfinput type="text" name="emailAddress" required="true" message="Please enter your email address." />
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label" for="password">Password:</label>
		<div class="controls">
			<cfinput type="password" name="password" required="true" message="Please enter your password." />
		</div>
	</div>
	
	<div class="control-group">
		<div class="controls">
			<cfinput type="submit" name="Submit" value="Login" />
		</div>
	</div>

</cfform>

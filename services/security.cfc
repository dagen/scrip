<cfcomponent output="false">

	<cffunction name="authenticate">
		<cfargument name="emailaddress" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfquery name="qUser" datasource="#request.dsn#">
			SELECT *
			FROM scrip_account
			WHERE emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.emailaddress)#" />
			AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.password)#" />
		</cfquery>
		
		
		<cfscript>
			myResponse = StructNew();
			myResponse.result = false;
			myResponse.xfa = "security.login";
			
			// Now, decide where to go next.
			if (qUser.recordcount EQ 1) {
				session.userinfo.displayname = qUser.displayname;
				myResponse.result = "true";
				myResponse.xfa = "admin.dashboard";
			}
			
		</cfscript>
		

		<cfreturn myResponse />
	</cffunction>
</cfcomponent>
<cfcomponent output="false">
	
	<cffunction name="getCaptcha">
		<cfscript>
			var myString = "";
			for (i=1;i LTE 5; i = i + 1) {
				myCharPos = RandRange(65,90);
				myString = myString & CHR(myCharPos);
			}
		
		</cfscript>
		
		<cfreturn myString />
	</cffunction>

</cfcomponent>
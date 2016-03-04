<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
Design by Free CSS Templates
http://www.freecsstemplates.org
Released for free under a Creative Commons Attribution 2.5 License

Name       : Republic  
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20090910

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="keywords" content="St. Cecilia SCRIP Program" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Scrip Online - Support St. Cecilia School</title>
	<link href="layouts/republic/style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<div id="wrapper">
	<div id="header">
		<!--- Render a header view here and cache it for 30 minutes.--->
		<cfoutput>
			#view('global/header')#
		</cfoutput>
		
	</div>
	<!-- end #header -->
	<div id="menu">
		<cfoutput>
			#view('global/menu')#	
		</cfoutput>
	</div>
	<!-- end #menu -->
	<div id="page">
	<div id="page-bgtop">
	<div id="page-bgbtm">
		<div id="content">
			<cfoutput>#body#</cfoutput>
		<div style="clear: both;">&nbsp;</div>
		</div>
		<!-- end #content -->
		<div id="sidebar">
			
			
			<cfswitch expression="#getSection()#">
			
				<cfcase value="admin">
					<cfset mysidebar = 'admin/sidebar' />
				</cfcase>
			
				<cfdefaultcase>
					<cfset mySidebar = 'global/sidebar' />
				</cfdefaultcase>
			</cfswitch>
			
			<cfoutput>
				#view(mySidebar)#
			</cfoutput>
		</div>
		<!-- end #sidebar -->
		<div style="clear: both;">&nbsp;</div>
	</div>
	</div>
	</div>
	<!-- end #page -->
</div>
	<div id="footer">
		<cfoutput>
			#view('global/footer')#
		</cfoutput>
	</div>
	<!-- end #footer -->
</body>
</html>

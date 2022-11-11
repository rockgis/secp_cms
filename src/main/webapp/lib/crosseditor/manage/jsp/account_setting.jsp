<%@page contentType="text/html;charset=utf-8" %>
<%@include file = "./include/session_check.jsp"%>
<%@include file = "manager_util.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Namo CrossEditor : Admin</title>
	<script type="text/javascript">var pe_tn="pe_Ig"; </script>
	<script type="text/javascript" src="../../lib/jquery-1.7.2.min.js"> </script>
	<script type="text/javascript">var ce$=$.noConflict(true); </script>
	<script type="text/javascript" src="../manage_common.js"> </script>
	<script type="text/javascript" language="javascript" src="../../js/namo_cengine.js"> </script>
	<script type="text/javascript" language="javascript" src="../manager.js"> </script>
	<link href="../css/common.css" rel="stylesheet" type="text/css">
</head>

<body>

<%@include file = "../include/top.html"%>

<div id="pe_apL" class="pe_hW">	
	<table class="pe_rH">
	  <tr>
		<td class="pe_hW">
		
			<table id="Info">
				<tr>
					<td style="padding:0 0 0 10px;height:30px;text-align:left">
					<font style="font-size:14pt;color:#3e77c1;font-weight:bold;text-decoration:none;"><span id="pe_Fq"></span></font></td>
					<td id="InfoText"><span id="pe_xM"></span></td>
				</tr>
				<tr>
					<td colspan="2"><img id="pe_xX" src="../images/title_line.jpg" alt="" /></td>
				</tr>
			</table>
		
		</td>
	  </tr>
	  <tr>
		<td class="pe_hW">
			
				<form method="post" id="pe_aBp" action="account_proc.jsp" onsubmit="return pe_bu(this);">
				<table class="pe_nk" >
				  <tr>
					<td>

						<table class="pe_eq">
						  <tr><td class="pe_ha" colspan="3"></td></tr>
						</table>
						 
						<table class="pe_eq" >
						  <tr>
							<td class="pe_dS">&nbsp;&nbsp;&nbsp;&nbsp;<b><span id="pe_BS"></span></b></td>
							<td class="pe_fD"></td>
							<td class="pe_dW">
								<input type="hidden" name="u_id" id="u_id" value="<%=detectXSSEx(session.getAttribute("memId").toString())%>" autocomplete="off"/>
								<input type="password" name="passwd" id="passwd" value="" class="pe_mw" autocomplete="off"/>
							</td>
						  </tr>
						  <tr>
							<td class="pe_eK" colspan="3"></td>
						  </tr>
						  <tr>
							<td class="pe_dS">&nbsp;&nbsp;&nbsp;&nbsp;<b><span id="pe_Lu"></span></b></td>
							<td class="pe_fD"></td>
							<td class="pe_dW">
								<input type="password" name="newPasswd" id="newPasswd" value="" class="pe_mw" autocomplete="off"/>
							</td>
						  </tr>
						  <tr>
							<td class="pe_eK" colspan="3"></td>
						  </tr>
						  <tr>
							<td class="pe_dS">&nbsp;&nbsp;&nbsp;&nbsp;<b><span id="pe_Lz"></span></b></td>
							<td class="pe_fD"></td>
							<td class="pe_dW">
								<input type="password" name="newPasswdCheck" id="newPasswdCheck" value="" class="pe_mw" autocomplete="off"/>
							</td>
						  </tr>
						</table>
					
						<table class="pe_eq">
						  <tr><td class="pe_ha" colspan="3"></td></tr>
						</table>
								
					</td>
				  </tr>
				  <tr id="pe_JG">
					<td id="pe_Ke">
						<ul style="margin:0 auto;width:170px;">
							<li class="pe_gW">
								<input type="submit" id="pe_Ix" value="" class="pe_ge pe_gn" style="width:66px;height:26px;" />
							</li>
							<li class="pe_gW"><input type="button" id="pe_xf" value="" class="pe_ge pe_gn" style="width:66px;height:26px;"></li>
						</ul>
					</td>
				  </tr>
				</table>
				</form>
		
		</td>
	  </tr>
	</table>

</div>

<%@include file = "../include/bottom.html"%>

</body>
<script>var webPageKind='<%=detectXSSEx(session.getAttribute("webPageKind").toString())%>';topInit();pe_f(); </script>

</html>

	
	


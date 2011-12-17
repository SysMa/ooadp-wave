<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Admin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Create a new administrator.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
	<script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	    $.noConflict();
	    jQuery(document).ready(function ($) {
	        $(":submit").hide();

	        $("#aemail").bind('change',
			function () {
			    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			    if ((!emailReg.test(this.value)) || this.value == "") {
			        //alert("This isnot a email.");
			        $("#email_error").css("color", "red").html("This is not a Email address.").show();
			        $(":submit").hide();
			    } else {
			        //alert("This is a email.");
			        $("#email_error").hide();
			        $(":submit").show();
			    }
			});
	    })
	</script>
	<% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

	<% using (Html.BeginForm()) {%>
		<%: Html.ValidationSummary(true) %>

		<fieldset>
			<table>
				<tr>
					<td align="right">Administrator Name:</td>
					<td>
						<%: Html.TextBoxFor(model => model.adminname, new Dictionary<string, object>() {{"maxlength", "20"}})%>
						<%: Html.ValidationMessageFor(model => model.adminname) %>
					</td>
				</tr>
				<tr>
					<td align="right">Password:</td>
					<td>
						<%: Html.PasswordFor(model => model.apasswd, new Dictionary<string, object>() { { "maxlength", "20" } })%>
						<%: Html.ValidationMessageFor(model => model.apasswd) %>
					</td>
				</tr>
                <tr>
					<td align="right">Confirm Password:</td>
					<td>
						<%: Html.Password("ConfirmPassword", "", new Dictionary<string, object>() { { "maxlength", "20" } })%>
					</td>
				</tr>
				<tr>
					<td align="right">Email:</td>
					<td>
						<%: Html.TextBoxFor(model => model.aemail, new Dictionary<string, object>() {{"maxlength", "50"}}) %>
						<%: Html.ValidationMessageFor(model => model.aemail) %>
                        <label id="email_error"></label>
					</td>
				</tr>
				<tr>
					<td align="right"><input type="submit" value="Create" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</table>
		</fieldset>

	<% } %>

	<div>
		<%: Html.ActionLink("Back", "Index") %>
	</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
	<br />
	<br />
</asp:Content>


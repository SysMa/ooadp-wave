﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Org>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit Organization
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
	<script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		$.noConflict();
		jQuery(document).ready(function ($) {
			$("#oemail").bind('change',
		function () {
			var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			if (!emailReg.test(this.value)) {
				//alert("This isnot a email.");
				$("#error").css("color", "red");
				$("#error").html("This is not a Email address.");
				$(":submit").hide();
				return false;
			} else {
				//alert("This is a email.");
				$(":submit").show();
				return true;
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
					<td align="right">Organization Name:</td>
					<td>
						<%: Html.DisplayTextFor(model => model.orgname)%>
					</td>
				</tr>
				<tr>
					<td align="right">Avater:</td>
					<td>
						<%= Html.Image("avater_pic", ResolveUrl((String)ViewData["avater_path"]),
							"Not Found", new { style = "width:100px;height:100px" })%>
					</td>
				</tr>
				<tr>
					<td align="right">Email:</td>
					<td>
						<%: Html.TextBoxFor(model => model.oemail, new Dictionary<string, object>() {{"maxlength", "50"}}) %>
						<%: Html.ValidationMessageFor(model => model.oemail) %>
						<label id="error"></label>
					</td>
				</tr>
				<tr>
					<td align="right">Phone:</td>
					<td>
						<%: Html.TextBoxFor(model => model.ophone, 
							new Dictionary<string, object>() { { "maxlength", "15" } })%>
						<%: Html.ValidationMessageFor(model => model.ophone) %>
					</td>
				</tr>
				<tr>
					<td align="right">Address:</td>
					<td>
						<%: Html.TextBoxFor(model => model.oaddress, 
							new Dictionary<string, object>() { { "maxlength", "100" } })%>
						<%: Html.ValidationMessageFor(model => model.oaddress) %>
					</td>
				</tr>
				<tr>
					<td align="right"><input type="submit" value="Save" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</table>
			<%: Html.HiddenFor(model => model.orgname)%>
			<%: Html.HiddenFor(model => model.opasswd)%>
		</fieldset>

	<% } %>

	<div>
		<%: Html.ActionLink("Back", "Orgs") %>
	</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
	<br />
	<br />
</asp:Content>

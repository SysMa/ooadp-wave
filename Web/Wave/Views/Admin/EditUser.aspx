﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	EditUser
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
	<script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		$.noConflict();
		jQuery(document).ready(function ($) {
			$("#uemail").bind('change',
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
					<td align="right">User Name:</td>
					<td>
						<%: Html.DisplayTextFor(model => model.username)%>
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
						<%: Html.TextBoxFor(model => model.uemail, new Dictionary<string, object>() { { "maxlength", "50" } })%>
						<label id="error"></label>
					</td>
				</tr>
				<tr>
					<td align="right">Phone:</td>
					<td>
						<%: Html.TextBoxFor(model => model.uphone, 
							new Dictionary<string, object>() { { "maxlength", "15" } })%>
					</td>
				</tr>
				<tr>
					<td align="right"><input type="submit" value="Save" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</table>
			<%: Html.HiddenFor(model => model.username)%>
			<%: Html.HiddenFor(model => model.upasswd)%>
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

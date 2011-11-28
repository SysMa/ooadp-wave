<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Admin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Create a new administrator.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

	<div style="color:Red;font-size:x-large"><% Html.RenderPartial("~/Views/Shared/Message.ascx"); %></div>

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
					<td align="right">Administrator Password:</td>
					<td>
						<%: Html.PasswordFor(model => model.apasswd, new Dictionary<string, object>() { { "maxlength", "20" } })%>
						<%: Html.ValidationMessageFor(model => model.apasswd) %>
					</td>
				</tr>
				<tr>
					<td align="right">Administrator Email:</td>
					<td>
						<%: Html.TextBoxFor(model => model.aemail, new Dictionary<string, object>() {{"maxlength", "50"}}) %>
						<%: Html.ValidationMessageFor(model => model.aemail) %>
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
		<%: Html.ActionLink("Back to List", "Index") %>
	</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
	<br />
	<br />
</asp:Content>


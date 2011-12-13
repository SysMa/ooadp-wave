<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.LoginModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Find Your Password Back:
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<br /><br />
	<h2 style="font-size:x-large">Find Your Password Back:</h2>

	<% using (Html.BeginForm()) {%>
		<%: Html.ValidationSummary(true) %>

		<fieldset>
			<br /><br />
			<div>
				<label>Enter Your Account:</label><br /><br />
				<div class="editor-field">
					<%: Html.TextBoxFor(model => model.account) %>
					<%: Html.ValidationMessageFor(model => model.account) %>
				</div>
			</div>
			<br /><br />
			<div>
				<label>Type</label><br /><br />
				<%	List<SelectListItem> list = new List<SelectListItem> {
					new SelectListItem { Text = "Organization", Value = "2" },
					new SelectListItem { Text = "User", Value = "3" ,Selected = true}};
				%>
				<%= Html.DropDownListFor(model => model.type, list)%>
				<br /><br />
				<p>
					<input type="submit" value="OK" />
				</p>
			</div>
		</fieldset>
		<br />
	<% } %>

	<div>
		<%: Html.ActionLink("Back to List", "Main") %>
	</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
</asp:Content>


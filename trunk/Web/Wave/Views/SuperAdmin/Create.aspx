<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Admin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Create a new administrator.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

	<% using (Html.BeginForm()) {%>
		<%: Html.ValidationSummary(true) %>

		<fieldset>
			<legend></legend>
			
			<div class="editor-label">
				Administrator Name:
			</div>
			<div class="editor-field">
				<%: Html.TextBoxFor(model => model.adminname) %>
				<%: Html.ValidationMessageFor(model => model.adminname) %>
			</div>
			
			<div class="editor-label">
				Administrator Password:
			</div>
			<div class="editor-field">
				<%: Html.PasswordFor(model => model.apasswd) %>
				<%: Html.ValidationMessageFor(model => model.apasswd) %>
			</div>

			<div class="editor-label">
				Administrator Email:
			</div>
			<div class="editor-field">
				<%: Html.TextBoxFor(model => model.aemail) %>
				<%: Html.ValidationMessageFor(model => model.aemail) %>
			</div>
			
			<p>
				<input type="submit" value="Create" />
			</p>
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


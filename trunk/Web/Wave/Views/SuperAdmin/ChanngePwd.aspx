<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.SuperAdmin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ChanngePwd
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

	<h2>ChanngePwd</h2>

	<% using (Html.BeginForm()) {%>
		<%: Html.ValidationSummary(true) %>
		
		<fieldset>
			<legend>Fields</legend>
			
			<div class="editor-label">
				<%: Html.LabelFor(model => model.supname) %>
			</div>
			<div class="editor-field">
				<%: Html.TextBoxFor(model => model.supname) %>
				<%: Html.ValidationMessageFor(model => model.supname) %>
			</div>
			
			<div class="editor-label">
				<%: Html.LabelFor(model => model.spasswd) %>
			</div>
			<div class="editor-field">
				<%: Html.TextBoxFor(model => model.spasswd) %>
				<%: Html.ValidationMessageFor(model => model.spasswd) %>
			</div>
			
			<p>
				<input type="submit" value="Save" />
			</p>
		</fieldset>

	<% } %>

	<div>
		<%: Html.ActionLink("Back to List", "Index") %>
	</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
</asp:Content>


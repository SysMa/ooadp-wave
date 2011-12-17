<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.LoginModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Find Your Password Back:
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    
	<h2 style="font-size:x-large">Find Your Password Back:</h2>

	<% using (Html.BeginForm()) {%>
		<%: Html.ValidationSummary(true) %>

		<fieldset>
			<br />
            <table>
                <tr>
                    <td align="right">Enter Your Account:</td>
                    <td><%: Html.TextBoxFor(model => model.account) %>
					    <%: Html.ValidationMessageFor(model => model.account) %></td>
                </tr>
                <tr>
                    <td align="right">Type:</td>
                    <td>
                        <%	List<SelectListItem> list = new List<SelectListItem> {
					        new SelectListItem { Text = "Organization", Value = "2" },
					        new SelectListItem { Text = "User", Value = "3" ,Selected = true}};
				        %>
				        <%= Html.DropDownListFor(model => model.type, list)%></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="OK" /></td>
                </tr>
            </table>
		</fieldset>
		<br />
	<% } %>

	<div>
		<%: Html.ActionLink("Back", "Main") %>
	</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


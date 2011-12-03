<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreateUser
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <table>
				<tr>
					<td align="right">User Name:</td>
					<td>
						<%: Html.TextBoxFor(model => model.username, new Dictionary<string, object>() { { "maxlength", "20" } })%>
                        <%: Html.ValidationMessageFor(model => model.username) %>
					</td>
				</tr>
				<tr>
					<td align="right">Password:</td>
					<td>
						<%: Html.PasswordFor(model => model.upasswd, new Dictionary<string, object>() { { "maxlength", "20" } })%>
                        <%: Html.ValidationMessageFor(model => model.upasswd) %>
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
						<%: Html.TextBoxFor(model => model.uemail, new Dictionary<string, object>() {{"maxlength", "50"}}) %>
						<%: Html.ValidationMessageFor(model => model.uemail) %>
					</td>
				</tr>
                <tr>
					<td align="right">Phone:</td>
					<td>
						<%: Html.TextBoxFor(model => model.uphone, 
                            new Dictionary<string, object>() { { "maxlength", "15" } })%>
                        <%: Html.ValidationMessageFor(model => model.uphone) %>
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


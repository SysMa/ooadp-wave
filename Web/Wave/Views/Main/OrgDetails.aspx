<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.LoginModel>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Organization Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <% Wave.Models.Org org = ViewData["org"] as Wave.Models.Org; %>
    <fieldset>
        <table>
			<tr>
				<td align="right" style="width: 268px">Organization Name:</td>
				<td><%: org.orgname %></td>
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
				<td><%: org.oemail%></td>
			</tr>
            <tr>
				<td align="right">Phone:</td>
				<td><%: org.ophone%></td>
			</tr>
            <tr>
				<td align="right">Score:</td>
				<td><%: org.oscore%></td>
			</tr>
            <tr>
				<td align="right">Address:</td>
				<td><%: org.oaddress%></td>
			</tr>
		</table>
        
    </fieldset>
    <p>

        <%: Html.ActionLink("View it's activities", "ViewActivities", new { id = org.orgname })%> |
        <%: Html.ActionLink("Back", "Main") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
<% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

<% if (Session["waveAccount"] != null && (int)Session["waveType"] == 3)
   { %>
   <label style="font-size:x-large" >Welcome, <%= Session["waveAccount"] %></label>&nbsp&nbsp&nbsp
   <%: Html.ActionLink("My Activities", "ViewMyActivity", "User") %> |
   <%: Html.ActionLink("Modify Infomation", "ChangeInfo", "User") %> |
   <%: Html.ActionLink("Change Password", "ChangePwd", "User") %> |
   <%: Html.ActionLink("Log Out", "LogOut", "User") %>
<%}
   else
   { %>

<center>
    <form method="post" action="<%= Url.Action("Login", "Main") %>" >
        <br />
        <label>Account</label>
        <%= Html.TextBoxFor(model => model.account, new { size = 10 })%>
        
        <label>Password</label>
        <%= Html.PasswordFor(model => model.password, new { size = 10 })%>

        <label>Type</label>
        <%
    List<SelectListItem> list = new List<SelectListItem> {
            new SelectListItem { Text = "SuperAdmin", Value = "0"},
            new SelectListItem { Text = "Admin", Value = "1" },
            new SelectListItem { Text = "Organization", Value = "2" },
            new SelectListItem { Text = "User", Value = "3" ,Selected = true}};
        %>
        <%= Html.DropDownListFor(model => model.type, list)%>

        <br /><br />
        <%= Html.ActionLink("Forgot Password", "ForgotPassword")%> | 
        <%= Html.ActionLink("Join Now", "Register")%> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <button type="submit" id="user-login-button" >Log In</button>
    </form>

</center>
<%} %>
</asp:Content>


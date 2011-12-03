<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.Users>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Manage users
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <ul class="splitter">
        <li>
            <ul>
                <li class="segment-1 selected-1">
                    <a href="/Admin/Index">&nbsp&nbsp&nbsp&nbsp&nbspUsers&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                </li>
                <li class="segment-0">
                    <a href="/Admin/Orgs">&nbspOrganizations&nbsp</a>
                </li>
            </ul>
        </li>
    </ul>

    <table>
        <tr>
            <th></th>
            <th align="center">
                User Name
            </th>
            <th align="center">
                State
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("Edit", "EditUser", new { id=item.username }) %> |
                <%: Html.ActionLink("Details", "UserDetails", new { id = item.username })%> |
                <%: Html.ActionLink("Delete", "DeleteUser", new { id=item.username })%>
            </td>
            <td>
                <%: item.username %>
            </td>
            <td>
                <%: item.ustate %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Create New User", "CreateUser")%>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <label style="font-size:large" >Welcome, Administrator: <%= Session["waveAccount"] %></label>&nbsp&nbsp&nbsp
    <%: Html.ActionLink("Review Activities", "ReviewActivities") %> |
    <%: Html.ActionLink("Modify Infomation", "ChangeInfo") %> |
    <%: Html.ActionLink("Change Password", "ChangePwd") %> |
    <%: Html.ActionLink("Log Out", "LogOut") %>
</asp:Content>


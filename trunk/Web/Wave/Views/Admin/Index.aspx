<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.Users>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <ul class="splitter">
        <li>
            <ul>
                <li class="segment-1 selected-1">
                    &nbsp&nbsp&nbsp&nbsp&nbsp<%: Html.ActionLink("Users", "Index") %>&nbsp&nbsp&nbsp&nbsp&nbsp
                </li>
                <li class="segment-0">&nbsp<%: Html.ActionLink("Organizations", "Orgs") %>&nbsp
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
            <th align="center">
                Email
            </th>
            <th align="center">
                Phone
            </th>
            <th align="center">
                Score
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { id=item.username }) %> |
                <%: Html.ActionLink("Details", "Details", new { id=item.username })%> |
                <%: Html.ActionLink("Delete", "Delete", new { id=item.username })%>
            </td>
            <td>
                <%: item.username %>
            </td>
            <td>
                <%: item.ustate %>
            </td>
            <td>
                <%: item.uemail %>
            </td>
            <td>
                <%: item.uphone %>
            </td>
            <td>
                <%: String.Format("{0:F}", item.uscore) %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Create New User", "Create") %>
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


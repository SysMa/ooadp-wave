<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.Admin>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Super administrator index page.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <table>
        <tr>
            <th></th>
            <th>
                Admin Name
            </th>
            <th>
                Admin State
            </th>
            <th>
                Admin Email
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { id=item.adminname }) %> |
                <%: Html.ActionLink("Delete", "Delete", new { id=item.adminname })%>
            </td>
            <td>
                <%: item.adminname %>
            </td>
            <td>
                <%: item.astate %>
            </td>
            <td>
                <%: item.aemail %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Create New Administrator", "Create") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
<br />
    <label style="font-size:x-large" >Welcome, <%= Session["account"] %></label>&nbsp&nbsp&nbsp
    <%: Html.ActionLink("Change Password", "ChangePwd") %>
</asp:Content>


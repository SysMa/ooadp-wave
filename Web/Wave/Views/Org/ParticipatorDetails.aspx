<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.TakeActivity>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Participator Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <h2>ParticipatorDetails</h2>

    <table>
        <tr>
            <th></th>
            <th>
                username
            </th>
            <th>
                actid
            </th>
            <th>
                userscore
            </th>
            <th>
                orgscore
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
                <%: item.actid %>
            </td>
            <td>
                <%: item.userscore %>
            </td>
            <td>
                <%: item.orgscore %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
</asp:Content>


﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.Org>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Manage Organizations
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <center class="splitter">
        <%: Html.ActionLink("Users", "Index") %> | 
        <%: Html.ActionLink("Organizations", "Orgs") %>
    </center>

    <table>
        <tr>
            <th></th>
            <th>
                Organization Name
            </th>
            <th>
                State
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("Edit", "EditOrg", new { id=item.orgname }) %> |
                <%: Html.ActionLink("Details", "OrgDetails", new { id=item.orgname })%> |
                <%: Html.ActionLink("Delete", "DeleteOrg", new { id=item.orgname })%>
            </td>
            <td>
                <%: item.orgname %>
            </td>
            <td>
                <%: item.ostate %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Create New Organization", "CreateOrg") %>
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

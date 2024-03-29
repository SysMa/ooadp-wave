﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.Admin>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Super administrator index page.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <table>
        <tr>
            <th></th>
            <th align="center">
                Admin Name
            </th>
            <th align="center">
                State
            </th>
            <th align="center">
                Email
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
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>
    <label style="font-size:large" >Welcome, Super administrator: <%= Session["waveAccount"] %></label>&nbsp&nbsp&nbsp
    <%: Html.ActionLink("Change Password", "ChangePwd") %> |
    <%: Html.ActionLink("Log Out", "LogOut") %>
</asp:Content>


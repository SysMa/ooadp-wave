<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.Activity>>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div class="demo">
        <ul id="list" class="image-grid" style="height: 591px; ">
            <%  int i = 0;
                foreach (var item in Model) {
                    i++;
                    String path = "~/Content/Images/pics/Activity_" + item.actname + ".jpg";
                    if (!System.IO.File.Exists(path))
                    {
                        path = "~/Content/Images/noavater.gif";
                    }%>
                <li data-id="id-<%=i %>">
                    <%= Html.Image("activity_pic" + i, ResolveUrl(path),
                                    "No Pic", new { style = "width:100px;height:100px" })%>
                    <strong><%: Html.ActionLink(item.actname, "Details", new { id=item.actid })%></strong>
                </li>
            <% } %>
        </ul>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>
    <label style="font-size:large" >Welcome, Organization: <%= Session["waveAccount"] %></label>&nbsp&nbsp&nbsp
    <%: Html.ActionLink("Apply Activities", "ApplyActivities") %> |
    <%: Html.ActionLink("Modify Infomation", "ChangeInfo") %> |
    <%: Html.ActionLink("Change Password", "ChangePwd") %> |
    <%: Html.ActionLink("Log Out", "LogOut") %>
</asp:Content>


﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.Activity>>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Review Activities
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% if (Model.Count() == 0)
       { %>
    <center style="font-size:large" class="splitter">There is no activity remain to be reviewed!</center>
    <%}
       else
       { %>
        <div class="demo">
            <ul id="list" class="image-grid">
                <%  int i = 0;
                    int type = (int)Session["waveType"];
                    string username = (string)Session["waveAccount"];
                    foreach (var item in Model)
                    {
                        i++;
                        String path = "~/Content/Images/pics/Activity_" + item.actid + ".jpg";
                        if (!System.IO.File.Exists(Server.MapPath(path)))
                        {
                            path = "~/Content/Images/noavater.gif";
                        }%>
                    <li data-id="id-<%=i %>">
                        <a href="/Activity/ActivityDetails/<%=item.actid %>?usertype=<%=type %>&username=<%=username %>">
                            <%= Html.Image("activity_pic" + i, ResolveUrl(path),
                                "No Pic", new { style = "width:128px;height:128px" })%></a>
                        <strong><%=item.actname%></strong>
                    </li>
                <% } %>
            </ul>
        </div>
    <%} %>
    <div>
        <%: Html.ActionLink("Back", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


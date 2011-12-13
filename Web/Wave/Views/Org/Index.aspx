<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <script src="../../Scripts/main.js" type="text/javascript"></script>
    <ul class="splitter">
        <li>
            <ul>
                <li class="segment-1 selected-1">
                    <a href="#" data-value="all">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp ALL&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                </li>
                <li class="segment-0"><a href="#" data-value="holding">&nbsp&nbsp&nbsp Holding&nbsp&nbsp&nbsp</a>
                </li>
                <li class="segment-2"><a href="#" data-value="applying">&nbsp Under review&nbsp</a>
                </li>
                <li class="segment-2"><a href="#" data-value="stoped">&nbsp&nbsp&nbspStoped&nbsp&nbsp&nbsp</a>
                </li>
            </ul>
        </li>
    </ul>

    <%  Wave.Models.Activity[] holdingActs = ViewData["holding_acts"] as Wave.Models.Activity[];
        Wave.Models.Activity[] stopedActs = ViewData["stoped_acts"] as Wave.Models.Activity[];
        Wave.Models.Activity[] appliedActs = ViewData["applied_acts"] as Wave.Models.Activity[];
        if (holdingActs.Length == 0 && stopedActs.Length == 0 && appliedActs.Length == 0)
       { %>
        <center style="font-size:large">You haven't hold or apply any activities yet!</center>
    <%}
       else
       { %>
        <div class="demo">
            <ul id="list" class="image-grid" style="height: 591px; ">
                <%  int i = 0, j = 0;
                    int type = (int)Session["waveType"];
                    string username = (string)Session["waveAccount"];
                    for (;; i++)
                    {
                        if (i < holdingActs.Length)
                        {
                            j++;
                            String path = "~/Content/Images/pics/Activity_" + holdingActs[i].actid + ".jpg";
                            if (!System.IO.File.Exists(Server.MapPath(path)))
                            {
                                path = "~/Content/Images/noavater.gif";
                            }%>
                            <li data-id="id-<%= j %>" class="holding">
                                <a href="/Activity/ActivityDetails/<%=holdingActs[i].actid %>?usertype=<%=type %>&username=<%=username %>">
                                    <%= Html.Image("holding_pic" + i, ResolveUrl(path),
                                    "No Pic", new { style = "width:128px;height:128px" })%></a>
                                <strong><%=holdingActs[i].actname%></strong>
                            </li>
                        <%}
                        if (i < appliedActs.Length)
                        {
                            j++;
                            String path = "~/Content/Images/pics/Activity_" + appliedActs[i].actid + ".jpg";
                            if (!System.IO.File.Exists(Server.MapPath(path)))
                            {
                                path = "~/Content/Images/noavater.gif";
                            }%>
                            <li data-id="id-<%= j %>" class="applying">
                                <a href="/Activity/ActivityDetails/<%=appliedActs[i].actid %>?usertype=<%=type %>&username=<%=username %>">
                                    <%= Html.Image("applying_pic" + i, ResolveUrl(path),
                                    "No Pic", new { style = "width:128px;height:128px" })%></a>
                                <strong><%=appliedActs[i].actname%></strong>
                            </li>
                        <%}
                        if (i < stopedActs.Length)
                        {
                            j++;
                            String path = "~/Content/Images/pics/Activity_" + stopedActs[i].actid + ".jpg";
                            if (!System.IO.File.Exists(Server.MapPath(path)))
                            {
                                path = "~/Content/Images/noavater.gif";
                            }%>
                            <li data-id="id-<%= j %>" class="stoped">
                                <a href="/Activity/ActivityDetails/<%=stopedActs[i].actid %>?usertype=<%=type %>&username=<%=username %>">
                                    <%= Html.Image("stoped_pic" + i, ResolveUrl(path),
                                    "No Pic", new { style = "width:128px;height:128px" })%></a>
                                <strong><%=stopedActs[i].actname%></strong>
                            </li>
                        <%}
                        if (i >= holdingActs.Length && i >= stopedActs.Length && i >= appliedActs.Length)
                        {
                            break;
                        }
                    } %>
            </ul>
        </div>
    <%} %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>
    <label style="font-size:large" >Welcome, Organization: <%= Session["waveAccount"] %></label>&nbsp&nbsp&nbsp
    <%: Html.ActionLink("Apply Activities", "ApplyActivities") %> |
    <%: Html.ActionLink("Modify Infomation", "ChangeInfo") %> |
    <%: Html.ActionLink("Change Password", "ChangePwd") %> |
    <%: Html.ActionLink("Log Out", "LogOut") %>
</asp:Content>


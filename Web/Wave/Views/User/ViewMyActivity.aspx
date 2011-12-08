<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	View My Activity
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>
    <script src="../../Scripts/main.js" type="text/javascript"></script>
    <ul class="splitter">
        <li>
            <ul>
                <li class="segment-1 selected-1">
                    <a href="#" data-value="all">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp ALL&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                </li>
                <li class="segment-0"><a href="#" data-value="holding">Activities is holding</a>
                </li>
                <li class="segment-2"><a href="#" data-value="stoped">Activities has stoped</a>
                </li>
            </ul>
        </li>
    </ul>

    <%  Wave.Models.Activity[] holdingActs = ViewData["holding_acts"] as Wave.Models.Activity[];
        Wave.Models.Activity[] stopedActs = ViewData["stoped_acts"] as Wave.Models.Activity[];
        if (holdingActs.Length == 0 && stopedActs.Length == 0)
       { %>
    <center style="font-size:large">Sorry, you haven't took part in any activities yet!</center>
    <%}
       else
       { %>
        <div class="demo">
            <ul id="list" class="image-grid" style="height: 591px; ">
                <%  int i = 0, j = 0;
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
                            <a href="/Activity/ActivityDetails/<%=holdingActs[i].actid %>">
                                <%= Html.Image("activity_pic" + i, ResolveUrl(path),
                                "No Pic", new { style = "width:128px;height:128px" })%></a>
                            <strong><%=holdingActs[i].actname%></strong>
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
                            <a href="/Activity/ActivityDetails/<%=stopedActs[i].actid %>">
                                <%= Html.Image("activity_pic" + i, ResolveUrl(path),
                                "No Pic", new { style = "width:128px;height:128px" })%></a>
                            <strong><%=stopedActs[i].actname%></strong>
                        </li>
                    <%}
                    if (i >= holdingActs.Length && i >= stopedActs.Length)
                    {
                        break;
                    }
                } %>
            </ul>
        </div>
    <%} %>
    <div>
        <%: Html.ActionLink("Back", "Main", "Main") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


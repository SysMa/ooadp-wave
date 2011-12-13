<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.LoginModel>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	View Activities
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
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
        <center style="font-size:large">The organization haven't hold any activities yet!</center>
    <%}
       else
       { %>
        <div class="demo">
            <ul id="list" class="image-grid" style="height: 591px; ">
                <%  int i = 0, j = 0;
                    int type = -1;
                    string username = "1";
                    if (Session["waveType"] != null)
                    {
                        type = (int)Session["waveType"];
                    }
                    if (Session["waveAccount"] != null)
                    {
                        username = (string)Session["waveAccount"];
                    }
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
                        if (i >= holdingActs.Length && i >= stopedActs.Length)
                        {
                            break;
                        }
                    } %>
            </ul>
        </div>
    <%} %>

    <p>
        <%: Html.ActionLink("Back to main", "Main") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
<% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

<% if (Session["waveAccount"] != null && (int)Session["waveType"] == 3)
   { %>
   <label style="font-size:x-large" >Welcome, <%= Session["waveAccount"] %></label>&nbsp&nbsp&nbsp
   <%: Html.ActionLink("My Activities", "ViewMyActivity", "User") %> |
   <%: Html.ActionLink("Modify Infomation", "ChangeInfo", "User") %> |
   <%: Html.ActionLink("Change Password", "ChangePwd", "User") %> |
   <%: Html.ActionLink("Log Out", "LogOut", "User") %>
<%}
   else
   { %>

<center>
    <form method="post" action="<%= Url.Action("Login", "Main") %>" >
        <br />
        <label>Account</label>
        <%= Html.TextBoxFor(model => model.account, new { size = 10 })%>
        
        <label>Password</label>
        <%= Html.PasswordFor(model => model.password, new { size = 10 })%>

        <label>Type</label>
        <%
    List<SelectListItem> list = new List<SelectListItem> {
            new SelectListItem { Text = "SuperAdmin", Value = "0"},
            new SelectListItem { Text = "Admin", Value = "1" },
            new SelectListItem { Text = "Organization", Value = "2" },
            new SelectListItem { Text = "User", Value = "3" ,Selected = true}};
        %>
        <%= Html.DropDownListFor(model => model.type, list)%>

        <br /><br />
        <%= Html.ActionLink("Forgot Password", "ForgotPassword")%> | 
        <%= Html.ActionLink("Join Now", "Register")%> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <button type="submit" id="user-login-button" >Log In</button>
    </form>

</center>
<%} %>
</asp:Content>


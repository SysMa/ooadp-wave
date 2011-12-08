<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.LoginModel>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Wave
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

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <script src="../../Scripts/main.js" type="text/javascript"></script>
        <ul class="splitter">
            <li>
                <ul>
                    <li class="segment-1 selected-1">
                        <a href="#" data-value="all">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp ALL&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                    </li>
                    <li class="segment-0"><a href="#" data-value="act">&nbsp Activities&nbsp</a>
                    </li>
                    <li class="segment-2"><a href="#" data-value="org">Organizations</a>
                    </li>
                </ul>
            </li>
        </ul>

        <div class="demo">
            <ul id="list" class="image-grid" style="height: 591px; ">
                <%  int i = 0, j = 0;
                    Wave.Models.Activity[] actList = ViewData["actList"] as Wave.Models.Activity[];
                    Wave.Models.Org[] orgList = ViewData["orgList"] as Wave.Models.Org[];
                    for (;; i++)
                    {
                        if (i < actList.Length)
                        {
                            j++;
                            String path = "~/Content/Images/pics/Activity_" + actList[i].actname + ".jpg";
                            if (!System.IO.File.Exists(Server.MapPath(path)))
                            {
                                path = "~/Content/Images/noavater.gif";
                            }%>
                            <li data-id="id-<%= j %>" class="act">
                                <%= Html.Image("activity_pic" + i, ResolveUrl(path),
                                    "No Pic", new { style = "width:128px;height:128px" })%>
                                <strong>
                                    <%: Html.ActionLink(actList[i].actname, "ActivityDetails", new { id = actList[i].actid })%>
                                </strong>
                            </li>
                        <%}
                        if (i < orgList.Length)
                        {
                            j++;
                            String path = "~/Content/Images/pics/Org_" + orgList[i].orgname + ".jpg";
                            if (!System.IO.File.Exists(Server.MapPath(path)))
                            {
                                path = "~/Content/Images/noavater.gif";
                            }%>
                            <li data-id="id-<%= j %>" class="org">
                                <%= Html.Image("org_pic" + i, ResolveUrl(path),
                                    "No Pic", new { style = "width:128px;height:128px" })%>
                                <strong>
                                    <%: Html.ActionLink(orgList[i].orgname, "OrgDetails", new { id = orgList[i].orgname })%>
                                </strong>
                            </li>
                        <%}
                        if (i >= actList.Length && i >= orgList.Length)
                        {
                            break;
                        }
                    } %>
            </ul>
        </div>

</asp:Content>

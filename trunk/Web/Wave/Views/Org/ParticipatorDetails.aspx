<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Wave.Models.TakeActivity>>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Participator Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <center class="splitter"><h1 style="font-size:x-large">Activity: <%= (String)ViewData["activity"] %></h1>
    <h2 style="font-size:large">Participator</h2></center>

    <div class="demo">
        <ul id="list" class="image-grid">
            <%  int i = 0;
                int id = (int)ViewData["id"];
                foreach (var item in Model) {
                    String path = "~/Content/Images/pics/User_" + item.username + ".jpg";
                    if (!System.IO.File.Exists(Server.MapPath(path)))
                    {
                        path = "~/Content/Images/noavater.gif";
                    }%>
                    <li data-id="id-<%= i %>">
                        <a href="/Org/UserDetails/<%=id %>?username=<%=item.username %>">
                            <%= Html.Image("applying_pic" + i, ResolveUrl(path),
                            "No Pic", new { style = "width:128px;height:128px" })%></a>
                        <strong><%=item.username%></strong>
                    </li>
            <% } %>
        </ul>
    </div>

    <div>
        <%: Html.ActionLink("Back", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


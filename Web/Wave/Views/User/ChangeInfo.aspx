<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modify Infomation
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <script type="text/javascript" src="../../Scripts/showImg.js"></script>

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm("ChangeInfo", "User", FormMethod.Post, new { enctype = "multipart/form-data" }))
       {%>
        <%: Html.ValidationSummary(true)%>
 
        <fieldset>
            <table>
                <tr>
                    <td align="right">User Name:</td>
                    <td>
                        <%: Html.DisplayTextFor(model => model.username)%>
                    </td>
                </tr>
                <tr>
                    <td align="right">Avater:</td>
                    <td>
                        <div id="avater" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=,sizingMethod=scale);width:60px;height:60px;">
                            <%= Html.Image("avater_pic", ResolveUrl((String)ViewData["avater_path"]),
                                "Not Found", new { style = "width:60px;height:60px" })%>
                        </div>
				        <input id="avater_path" name="avater_path" type="file" multiple onchange="showAvater(this, 'avater');" value="" />
                    </td>
                </tr>
                <tr>
                    <td align="right">Email:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.uemail, new Dictionary<string, object>() { { "maxlength", "50" } })%>
                    </td>
                </tr>
                <tr>
                    <td align="right">Phone:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.uphone,
                            new Dictionary<string, object>() { { "maxlength", "15" } })%>
                    </td>
                </tr>
                <tr>
                    <td align="right"><input type="submit" value="Update" /></td>
                    <td><input type="reset" value="Reset" /></td>
                </tr>
            </table>
            <%: Html.HiddenFor(model => model.username)%>
            <%: Html.HiddenFor(model => model.upasswd)%>
          
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back", "Main", "Main") %>
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


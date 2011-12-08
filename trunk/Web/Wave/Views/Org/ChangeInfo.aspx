<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Org>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Change Information
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <script type="text/javascript" src="../../Scripts/showImg.js"></script>

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm("ChangeInfo", "Org", FormMethod.Post, new { enctype = "multipart/form-data", id = "form" }))
       {%>
        <%: Html.ValidationSummary(true)%>
 
        <fieldset>
            <table>
                <tr>
                    <td align="right">Organization Name:</td>
                    <td>
                        <%: Html.DisplayTextFor(model => model.orgname)%>
                    </td>
                </tr>
                <tr>
                    <td align="right">Avater:</td>
                    <td>
                        <div id="avater" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=,sizingMethod=scale);width:100px;height:100px;">
                            <%= Html.Image("avater_pic", ResolveUrl((String)ViewData["avater_path"]),
                                "Not Found", new { style = "width:100px;height:100px" })%>
                        </div>
                        <span id="uploadImg">
                            <input type="button" value="Select Avater" style="width: 100px" />
                            <input id="avater_path" name="avater_path" type="file" multiple onchange="showAvater(this, 'avater');" size="1" />
                        </span>  
                    </td>
                </tr>
                <tr>
                    <td align="right">Email:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.oemail, new Dictionary<string, object>() { { "maxlength", "50" } })%>
                    </td>
                </tr>
                <tr>
                    <td align="right">Phone:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.ophone,
                            new Dictionary<string, object>() { { "maxlength", "15" } })%>
                    </td>
                </tr>
                <tr>
                    <td align="right">Address:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.oaddress,
                            new Dictionary<string, object>() { { "maxlength", "100" } })%>
                    </td>
                </tr>
                <tr>
                    <td align="right"><input type="submit" value="Update" /></td>
                    <td><input type="reset" value="Reset" /></td>
                </tr>
            </table>
            <%: Html.HiddenFor(model => model.orgname)%>
            <%: Html.HiddenFor(model => model.opasswd)%>
          
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


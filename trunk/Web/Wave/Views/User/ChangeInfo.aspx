<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modify Infomation
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <script src="../../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>

    <script type = "text/javascript">
        $(window).load(
    function () {
        $("#<%=FileUpload.ClientID%>").fileUpload({
            'uploader': '../../Scripts/uploader.swf',
            'buttonText': 'Browse Files',
            'script': '../../Content/Images/pics/Upload.ashx',
            'folder': '/Pics',
            'fileDesc': 'Image Files',
            'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
            'multi': false,
            'auto': true,
            'onComplete': function (event, queueID, fileObj, response, data) {
                document.getElementById("show").src = '../../Content/Images/pics/';
            }
        });
    });
    </script> 

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
 
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
                    <form id="form1" runat="server">
                        <div>
                            <img id="show" src="../../Content/Images/party/img01.jpg" alt="woow" />
                            <br />
                            <asp:FileUpload ID="FileUpload" runat="server" />
                        </div>
                    </form>
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


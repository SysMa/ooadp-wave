<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modify Infomation
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<%--<<<<<<< .mine
    <script type="text/javascript">
        function select() {
            var a = document.getElementById("avater_path");
            a.click();
            var b = document.getElementById("select");
        }
    </script>
=======--%>
<%--    <script src="../../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>

    <script type = "text/javascript">
        $(window).load(
    function () {
        $("#<%=FileUpload.ClientID%>").fileUpload({
            'uploader': '../../Scripts/uploader.swf',
            'buttonText': 'Select Avater',
            'script': '../../Content/Images/pics/Upload.ashx',
            'folder': '/Content/temp',
            'fileDesc': 'Image Files',
            'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
            'multi': false,
            'auto': true,
            'onComplete': function (event, queueID, fileObj, response, data) {
                document.getElementById("avater_pic").src = '../../Content/Images/pics/User_<%=Session["waveAccount"] %>.jpg';
            }
        });
    });
    </script>--%>

    <script type="text/javascript">
        function $(o)
        {
            return document.getElementById(o);
        }
        function CheckImgCss(o,img)
        {
            if (!/\.((jpg)|(bmp)|(gif)|(png))$/ig.test(o.value))
            {
                alert('只能上传jpg,bmp,gif,png格式图片!');
                o.outerHTML = o.outerHTML;
            }
            else {
                if ($("avater_pic") !== null) {
                    $(img).removeChild($("avater_pic"));
                }
                
                $(img).filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src=o.value;
            }
        }
    </script>

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
                        <input type="file" name="avater_path" id="avater_path" onchange="CheckImgCss(this, 'avater');" />
                        

                    <%--<td>
                    <form id="form1" runat="server">
                        <div>
                            <%= Html.Image("avater_pic", ResolveUrl((String)ViewData["avater_path"]),
                                "Not Found", new { style = "width:60px;height:60px" })%>
                            <asp:FileUpload ID="FileUpload" runat="server" />
                        </div>
                    </form>--%>
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


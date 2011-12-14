<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Admin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Change Information
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(":submit").hide();

            $("#aemail").bind('change',
            function () {
                var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
                if (!emailReg.test(this.value)) {
                    //alert("This isnot a email.");
                    $("#error").css("color", "red");
                    $("#error").html("This is not a Email address.");
                    $(":submit").hide();
                    return false;
                } else {
                    //alert("This is a email.");
                    $(":submit").show();
                    return true;
                }
            });
        })
    </script>
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <table>
                <tr>
                    <td align="right">Administrator Name:</td>
                    <td>
                        <%: Html.DisplayTextFor(model => model.adminname)%>
                    </td>
                </tr>
                <tr>
                    <td align="right">Email:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.aemail, new Dictionary<string, object>() { { "maxlength", "50" } })%><label id="error"></label>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2"><input type="submit" value="Save" /></td>
                </tr>
            </table>
            <%: Html.HiddenFor(model => model.adminname)%>
            <%: Html.HiddenFor(model => model.apasswd)%>
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


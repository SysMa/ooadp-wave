<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.ChangePwdModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Channge Password
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <br />
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>
    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <table>
                <tr>
                    <td align="right">Original Password:</td>
                    <td>
                        <%: Html.PasswordFor(model => model.original, new Dictionary<string, object>() { { "maxlength", "20" } })%>
                        <%: Html.ValidationMessageFor(model => model.original) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Administrator Password:</td>
                    <td>
                        <%: Html.PasswordFor(model => model.password, new Dictionary<string, object>() { { "maxlength", "20" } })%>
                        <%: Html.ValidationMessageFor(model => model.password) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Confirm Password:</td>
                    <td>
                        <%: Html.PasswordFor(model => model.confirmPwd, new Dictionary<string, object>() { { "maxlength", "20" } })%>
                        <%: Html.ValidationMessageFor(model => model.confirmPwd) %>
                    </td>
                </tr>
                <tr>
                    <td align="right"><input type="submit" value="Update" /></td>
                    <td><input type="reset" value="Reset" /></td>
                </tr>
            </table>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
</asp:Content>


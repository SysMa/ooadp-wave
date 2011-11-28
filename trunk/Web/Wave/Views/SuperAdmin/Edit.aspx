<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Admin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit an administrator.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <div style="color:Red;font-size:x-large"><% Html.RenderPartial("~/Views/Shared/Message.ascx"); %></div>

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
                    <td align="right">Administrator Email:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.aemail, new Dictionary<string, object>() { { "maxlength", "50" } })%>
                        <%: Html.ValidationMessageFor(model => model.aemail) %>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2"><input type="submit" value="Save" /></td>
                </tr>
            </table>
            <%: Html.TextBoxFor(model => model.adminname, new Dictionary<string, object>(){{ "style", "visibility:hidden;" }})%>
            <%: Html.TextBoxFor(model => model.apasswd, new Dictionary<string, object>(){{ "style", "visibility:hidden;" }})%>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


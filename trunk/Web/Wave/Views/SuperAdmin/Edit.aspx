<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Admin>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit an administrator.
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend></legend>
            
            <div class="editor-label">
                Administrator Name: <%: Html.DisplayTextFor(model => model.adminname)%>
                <%: Html.TextBoxFor(model => model.adminname, new Dictionary<string, object>(){{ "style", "visibility:hidden;" }})%>
                <%: Html.TextBoxFor(model => model.apasswd, new Dictionary<string, object>(){{ "style", "visibility:hidden;" }})%>
            </div>
            
            <div class="editor-label">
                Administrator Email:
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.aemail) %>
                <%: Html.ValidationMessageFor(model => model.aemail) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
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


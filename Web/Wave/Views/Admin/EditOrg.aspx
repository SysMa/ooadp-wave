<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Org>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit Organization
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>
        
        <fieldset>
            <table>
				<tr>
					<td align="right">Organization Name:</td>
					<td>
						<%: Html.DisplayTextFor(model => model.orgname)%>
					</td>
				</tr>
				<tr>
					<td align="right">Email:</td>
					<td>
						<%: Html.TextBoxFor(model => model.oemail, new Dictionary<string, object>() {{"maxlength", "50"}}) %>
						<%: Html.ValidationMessageFor(model => model.oemail) %>
					</td>
				</tr>
                <tr>
					<td align="right">Phone:</td>
					<td>
						<%: Html.TextBoxFor(model => model.ophone, 
                            new Dictionary<string, object>() { { "maxlength", "15" } })%>
                        <%: Html.ValidationMessageFor(model => model.ophone) %>
					</td>
				</tr>
                <tr>
					<td align="right">Address:</td>
					<td>
						<%: Html.TextBoxFor(model => model.oaddress, 
                            new Dictionary<string, object>() { { "maxlength", "100" } })%>
                        <%: Html.ValidationMessageFor(model => model.oaddress) %>
					</td>
				</tr>
				<tr>
					<td align="right"><input type="submit" value="Save" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</table>
            <%: Html.HiddenFor(model => model.orgname)%>
            <%: Html.HiddenFor(model => model.opasswd)%>
        </fieldset>

    <% } %>

    <div>
        <%: Html.ActionLink("Back", "Orgs") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


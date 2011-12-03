<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Org>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Delete Organization
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <h3>Are you sure you want to delete this?</h3>
    <fieldset>
        <table>
			<tr>
				<td align="right" style="width: 268px">Organization Name:</td>
				<td><%: Model.orgname %></td>
			</tr>
            <tr>
				<td align="right">State:</td>
				<td><%: Model.ostate %></td>
			</tr>
			<tr>
				<td align="right">Email:</td>
				<td><%: Model.oemail %></td>
			</tr>
            <tr>
				<td align="right">Phone:</td>
				<td><%: Model.ophone %></td>
			</tr>
            <tr>
				<td align="right">Score:</td>
				<td><%: Model.oscore %></td>
			</tr>
            <tr>
				<td align="right">Address:</td>
				<td><%: Model.oaddress %></td>
			</tr>
            <tr>
                <td align="right">
                    <% using (Html.BeginForm()) { %>
		                <input type="submit" value="Delete" />
                    <% } %>
                </td>
                <td></td>
            </tr>
		</table>     
    </fieldset>
    <div>
        <%: Html.ActionLink("Back", "Orgs") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


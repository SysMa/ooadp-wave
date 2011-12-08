<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Org>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Org Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <fieldset>
        <table>
			<tr>
				<td align="right" style="width: 268px">Organization Name:</td>
				<td><%: Model.orgname %></td>
			</tr>
            <tr>
                <td align="right">Avater:</td>
                <td>
                    <%= Html.Image("avater_pic", ResolveUrl((String)ViewData["avater_path"]),
                        "Not Found", new { style = "width:100px;height:100px" })%>
                </td>
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
		</table>
        
    </fieldset>
    <p>

        <%: Html.ActionLink("Edit", "EditOrg", new { id=Model.orgname }) %> |
        <%: Html.ActionLink("Back", "Orgs") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


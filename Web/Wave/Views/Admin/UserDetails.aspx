<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	User Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <fieldset>
        <table>
			<tr>
				<td align="right" style="width: 268px">User Name:</td>
				<td><%: Model.username %></td>
			</tr>
            <tr>
				<td align="right" style="width: 268px">State:</td>
				<td><%: Model.ustate %></td>
			</tr>
			<tr>
				<td align="right" style="width: 268px">Email:</td>
				<td><%: Model.uemail %></td>
			</tr>
            <tr>
				<td align="right" style="width: 268px">Phone:</td>
				<td><%: Model.uphone %></td>
			</tr>
            <tr>
				<td align="right" style="width: 268px">Score:</td>
				<td><%: Model.uscore %></td>
			</tr>
		</table>
    </fieldset>
    <p>

        <%: Html.ActionLink("Edit", "EditUser", new { id=Model.username }) %> |
        <%: Html.ActionLink("Back", "Index") %>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


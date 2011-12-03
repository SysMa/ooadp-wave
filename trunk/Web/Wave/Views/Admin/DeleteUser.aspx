<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Delete User
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <h3>Are you sure you want to delete this?</h3>
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
        <%: Html.ActionLink("Back", "Index") %>
    </div>
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


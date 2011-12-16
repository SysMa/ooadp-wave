<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Users>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	User Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <fieldset>
        <table>
			<tr>
				<td align="right" style="width: 373px">User Name:</td>
				<td><%: Model.username %></td>
			</tr>
            <tr>
                <td align="right" style="width: 373px">Avater:</td>
                <td>
                    <%= Html.Image("avater_pic", ResolveUrl((String)ViewData["avater_path"]),
                        "Not Found", new { style = "width:100px;height:100px" })%>
                </td>
            </tr>
			<tr>
				<td align="right" style="width: 373px">Email:</td>
				<td><%: Model.uemail %></td>
			</tr>
            <tr>
				<td align="right" style="width: 373px">Phone:</td>
				<td><%: Model.uphone %></td>
			</tr>
            <tr>
				<td align="right" style="width: 373px">Score:</td>
				<td><form method="post" action="<%= Url.Action("Rate", "Org", new { id=ViewData["id"],username=Model.username }) %>" >
                        <%: Model.uscore %>&nbsp&nbsp&nbsp&nbsp
                        <%
                            int state = (int)ViewData["act_state"];
                            bool[] selected = (bool[])ViewData["selected"];
                            if (state == 2)
                            {
                                List<SelectListItem> list = new List<SelectListItem> {
                                    new SelectListItem { Text = "1", Value = "1", Selected = selected[0] },
                                    new SelectListItem { Text = "2", Value = "2", Selected = selected[1] },
                                    new SelectListItem { Text = "3", Value = "3", Selected = selected[2] },
                                    new SelectListItem { Text = "4", Value = "4", Selected = selected[3] },
                                    new SelectListItem { Text = "5", Value = "5", Selected = selected[4]}};
                        %>
                          
                                    <%= Html.DropDownList("rate", list) %>
                                    <input type="submit" value="Rate" />
                        <%  } %>
                    </form>
                </td>
			</tr>
		</table>
    </fieldset>
    <p>
        <%: Html.ActionLink("Back", "ParticipatorDetails", new { id=ViewData["id"] })%>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


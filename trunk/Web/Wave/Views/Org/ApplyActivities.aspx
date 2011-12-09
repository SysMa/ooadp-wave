<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Activity>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Apply Activity
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<script type="text/javascript" src="../../Scripts/showImg.js"></script>

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <table>
                <tr>
                    <td align="right">Activity Name:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.actname) %>
                        <%: Html.ValidationMessageFor(model => model.actname) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Activity Picture:</td>
                    <td>
                        <div id="avater" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=,sizingMethod=scale);width:100px;height:100px;">
                            <%= Html.Image("avater_pic", ResolveUrl("~/Content/Images/noavater.gif"),
                                "Please select pic", new { style = "width:100px;height:100px" })%>
                        </div>
                        <span id="uploadImg">
                            <input type="button" value="Select Picture" style="width: 100px" />
                            <input id="avater_path" name="avater_path" type="file" multiple onchange="showAvater(this, 'avater');" size="1" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="right">Max User Number:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.maxuser) %>
                        <%: Html.ValidationMessageFor(model => model.maxuser) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Start Time:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.starttime, new Dictionary<string, object>(){ {"class", "starttime"} })%>
                        <%: Html.ValidationMessageFor(model => model.actname) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">End Time:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.endtime, new Dictionary<string, object>() { { "class", "endtime" } })%>
                        <%: Html.ValidationMessageFor(model => model.actname) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Slogan:</td>
                    <td>
                        <%: Html.TextAreaFor(model => model.slogan, 
                            new Dictionary<string, object>() {{"Cols", "50"}, {"Rows", "2"}})%>
                        <%: Html.ValidationMessageFor(model => model.actname) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Description:</td>
                    <td>
                        <%: Html.TextAreaFor(model => model.acttext,
                            new Dictionary<string, object> { { "Cols", "50" }, { "Rows", "4" } })%>
                        <%: Html.ValidationMessageFor(model => model.acttext) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Page Template:</td>
                    <td>
                        <input type="button" value="Preview" />
                    </td>
                </tr>
                <tr>
                    <td align="right"><input type="submit" value="Apply" /></td>
                    <td><input type="reset" value="Reset" /></td>
                </tr>
            </table>
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


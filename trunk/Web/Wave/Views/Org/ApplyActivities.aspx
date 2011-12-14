<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Activity>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Apply Activity
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<script type="text/javascript" src="../../Scripts/showImg.js"></script>
<script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../Scripts/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="../../Scripts/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="../../Scripts/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../../Scripts/jquery-ui-sliderAccess.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#starttime').datetimepicker({
            onClose: function (dateText, inst) {
                var endDateTextBox = $('#endtime');
                if (endDateTextBox.val() != '') {
                    var testStartDate = new Date(dateText);
                    var testEndDate = new Date(endDateTextBox.val());
                    if (testStartDate > testEndDate)
                        endDateTextBox.val(dateText);
                }
                else {
                    endDateTextBox.val(dateText);
                }
            },
            onSelect: function (selectedDateTime) {
                var start = $(this).datetimepicker('getDate');
                $('#endtime').datetimepicker('option', 'minDate', new Date(start.getTime()));
            }
        });
        $('#endtime').datetimepicker({
            onClose: function (dateText, inst) {
                var startDateTextBox = $('#starttime');
                if (startDateTextBox.val() != '') {
                    var testStartDate = new Date(startDateTextBox.val());
                    var testEndDate = new Date(dateText);
                    if (testStartDate > testEndDate)
                        startDateTextBox.val(dateText);
                }
                else {
                    startDateTextBox.val(dateText);
                }
            },
            onSelect: function (selectedDateTime) {
                var end = $(this).datetimepicker('getDate');
                $('#starttime').datetimepicker('option', 'maxDate', new Date(end.getTime()));
            }
        });
    });
</script>

    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm("ApplyActivities", "Org", FormMethod.Post, new { enctype = "multipart/form-data", id = "form" }))
       {%>
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
                    <td align="right">Activity Logo:</td>
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
                        <%: Html.TextBoxFor(model => model.starttime, new Dictionary<string, object>() { { "readonly", "readonly" } })%>
                        <%: Html.ValidationMessageFor(model => model.actname) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">End Time:</td>
                    <td>
                        <%: Html.TextBoxFor(model => model.endtime, new Dictionary<string, object>() { { "readonly", "readonly" } })%>
                        <%: Html.ValidationMessageFor(model => model.actname) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Slogan:</td>
                    <td>
                        <%: Html.TextAreaFor(model => model.slogan,
                            new Dictionary<string, object>() { { "Cols", "40" }, { "Rows", "2" }, { "style", "resize:vertical" } })%>
                        <%: Html.ValidationMessageFor(model => model.actname) %>
                    </td>
                </tr>
                <tr>
                    <td align="right">Description:</td>
                    <td>
                        <%: Html.TextAreaFor(model => model.acttext,
                            new Dictionary<string, object>() { { "Cols", "40" }, { "Rows", "4" }, { "style", "resize:vertical" } })%>
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
        <%= Html.HiddenFor(model => model.pageid, new Dictionary<string, object>() { { "value", ViewData["pageid"] } }) %>

    <% } %>

    <div>
        <%: Html.ActionLink("Back", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
    <br />
    <br />
</asp:Content>


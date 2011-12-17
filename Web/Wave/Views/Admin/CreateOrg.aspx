<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Org>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreateOrg
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
	<script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	    $.noConflict();
	    jQuery(document).ready(function ($) {
	        $(":submit").hide();

	        $("#oemail").bind('change',
			function () {
			    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			    if ((!emailReg.test(this.value)) || this.value == "") {
			        //alert("This isnot a email.");
			        $("#email_error").css("color", "red").html("This is not a Email address.").show();
			        $(":submit").hide();
			    } else {
			        //alert("This is a email.");
			        $("#email_error").hide();
			        if ($("#phone_error").is(":hidden") && ($("#ophone").val() != "")) {
			            $(":submit").show();
			        }
			    }
			});

	        $("#ophone").bind('change',
			function () {
			    if ($("#ophone").val().match(/(130|131|132|133|134|135|136|137|138|139|158|150|151|152|155|189|188|187|182|186)\d{8}/) == null) {
			        $("#phone_error").css("color", "red").html("Please Check your telephone number.").show();
			        $(":submit").hide();
			    }
			    else {
			        $("#phone_error").hide();
			        if ($("#email_error").is(":hidden") && ($("#oemail").val() != "")) {
			            $(":submit").show();
			        }
			    }
			});
	    })
	</script>
    <% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <table>
				<tr>
					<td align="right">Org Name:</td>
					<td>
						<%: Html.TextBoxFor(model => model.orgname, new Dictionary<string, object>() { { "maxlength", "20" } })%>
                        <%: Html.ValidationMessageFor(model => model.orgname) %>
					</td>
				</tr>
				<tr>
					<td align="right">Password:</td>
					<td>
						<%: Html.PasswordFor(model => model.opasswd, new Dictionary<string, object>() { { "maxlength", "20" } })%>
                        <%: Html.ValidationMessageFor(model => model.opasswd) %>
					</td>
				</tr>
                <tr>
					<td align="right">Confirm Password:</td>
					<td>
						<%: Html.Password("ConfirmPassword", "", new Dictionary<string, object>() { { "maxlength", "20" } })%>
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
					<td align="right"><input type="submit" value="Create" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
				<tr>
					<td align="right">Email:</td>
					<td>
						<%: Html.TextBoxFor(model => model.oemail, new Dictionary<string, object>() {{"maxlength", "50"}}) %>
						<%: Html.ValidationMessageFor(model => model.oemail) %>
                        <label id="email_error"></label>
					</td>
				</tr>
                <tr>
					<td align="right">Phone:</td>
					<td>
						<%: Html.TextBoxFor(model => model.ophone, 
                            new Dictionary<string, object>() { { "maxlength", "15" } })%>
                        <%: Html.ValidationMessageFor(model => model.ophone) %>
                        <label id="phone_error"></label>
					</td>
				</tr>
			</table>
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


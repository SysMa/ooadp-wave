<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Org>" %>
<%@ Import Namespace="Wave.Helpers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Change Information
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
	<script type="text/javascript" src="../../Scripts/showImg.js"></script>
	<script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		$.noConflict();
		jQuery(document).ready(function ($) {
		    $("#oemail").bind('change',
			function () {
			    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			    if ((!emailReg.test(this.value)) || this.value == null) {
			        //alert("This isnot a email.");
			        $("#email_error").css("color", "red").html("This is not a Email address.").show();
			        $(":submit").hide();
			    } else {
			        //alert("This is a email.");
			        $("#email_error").hide();
			        if ($("#phone_error").is(":hidden")) {
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
			        if ($("#email_error").is(":hidden")) {
			            $(":submit").show();
			        }
			    }
			});
		})
	</script>

	<% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>

	<% using (Html.BeginForm("ChangeInfo", "Org", FormMethod.Post, new { enctype = "multipart/form-data", id = "form" }))
	   {%>
		<%: Html.ValidationSummary(true)%>
 
		<fieldset>
			<table>
				<tr>
					<td align="right" style="width: 425px">Organization Name:</td>
					<td>
						<%: Html.DisplayTextFor(model => model.orgname)%>
					</td>
				</tr>
				<tr>
					<td align="right" style="width: 425px">Avater:</td>
					<td>
						<div id="avater" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=,sizingMethod=scale);width:100px;height:100px;">
							<%= Html.Image("avater_pic", ResolveUrl((String)ViewData["avater_path"]),
								"Not Found", new { style = "width:100px;height:100px" })%>
						</div>
						<span id="uploadImg">
							<input type="button" value="Select Avater" style="width: 100px" />
							<input id="avater_path" name="avater_path" type="file" multiple onchange="showAvater(this, 'avater');" size="1" />
						</span>  
					</td>
				</tr>
				<tr>
					<td align="right" style="width: 425px">Email:</td>
					<td>
						<%: Html.TextBoxFor(model => model.oemail, new Dictionary<string, object>() { { "maxlength", "50" } })%><label id="email_error"></label>
					</td>
				</tr>
				<tr>
					<td align="right" style="width: 425px">Phone:</td>
					<td>
						<%: Html.TextBoxFor(model => model.ophone,
							new Dictionary<string, object>() { { "maxlength", "15" } })%>
                        <label id="phone_error"></label>
					</td>
				</tr>
				<tr>
					<td align="right" style="width: 425px">Address:</td>
					<td>
						<%: Html.TextBoxFor(model => model.oaddress,
							new Dictionary<string, object>() { { "maxlength", "100" } })%>
					</td>
				</tr>
				<tr>
					<td align="right" style="width: 425px"><input type="submit" value="Update" /></td>
					<td><input type="reset" value="Reset" /></td>
				</tr>
			</table>
			<%: Html.HiddenFor(model => model.orgname)%>
			<%: Html.HiddenFor(model => model.opasswd)%>
		  
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


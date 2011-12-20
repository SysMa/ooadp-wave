<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Activity>" %>
<%@ Import Namespace="Wave.Helpers" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title><%: Model.actname %></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../Scripts/jquery.slidertron-0.1.js"></script>
	<script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
	<link href="../../Content/CSS/style2.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../../Content/CSS/uploadify.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		@import url("../../Content/CSS/slidertron.css");
	</style>
    <script type = "text/javascript">
        $(window).load(
            function () {
                $("#<%=FileUpload.ClientID%>").fileUpload({
                    'uploader': '../../Scripts/uploader.swf',
                    'buttonText': 'Upload Pictures',
                    'script': '../../Helper/Upload.ashx',
                    'folder': '&actid=<%=Model.actid %>',
                    'fileDesc': 'Image Files',
                    'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                    'multi': true,
                    'auto': true,
                    'buttonImg': '../../Content/Images/button2.png',
                    'width': 200,
                    'height': 35,
                    'onComplete': function (event, queueID, fileObj, response, data) {

                    }
                });
            });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("li#act").hide();
            $("li#peo").show();
            $("h2#acth").css("cursor", "pointer");
            $("h2#peoh").css("cursor", "pointer");

            $("h2#acth").click(function () {
                if ($("li#peo").is(":hidden")) {
                    $("li#peo").show();
                } else {
                    $("li#peo").hide();
                }

                if ($("li#act").is(":hidden")) {
                    $("li#act").show();
                } else {
                    $("li#act").hide();
                }
            });

            $("h2#peoh").click(function () {
                if ($("li#act").is(":hidden")) {
                    $("li#act").show();
                } else {
                    $("li#act").hide();
                }

                if ($("li#peo").is(":hidden")) {
                    $("li#peo").show();
                } else {
                    $("li#peo").hide();
                }
            });
        });
    </script>
</head>
<body>
	<% String visitor = ViewData["visitor"] as String;
       String url = ViewData["returnUrl"] as String; %>
    <div id="header">
        <div id="logo">
            <h1 class="title" style="margin-top:10px; font-size:38px; text-transform:capitalize"><%: Model.actname %></h1>
        </div>
    </div>

    <hr />

<div id="wrapper">
	<div id="two-columns">
		<div class="col1">
			<div id="foobar">
				<div class="navigation"> <a href="#" class="first">[ &lt;&lt; ]</a> &nbsp; <a href="#" class="previous">[ &lt; ]</a> &nbsp; <a href="#" class="next">[ &gt; ]</a> &nbsp; <a href="#" class="last">[ &gt;&gt; ]</a> </div>
				<div class="viewer" style="height:385px;">
                    <div class="reel" style="color:Black">          
                        <%  String[] actpics = ViewData["actpics"] as String[];
                            int[] picstates = ViewData["picstates"] as int[];
                            for (int i = 0; i < actpics.Length; i++)
                            {
                                String actpath = "../../Content/Images/ActivityImages/Activity_"
                                            + Model.actid + "/" + actpics[i]; %>
                                <div class="slide">
                                    <img src="<%=actpath %>"  height="385px" width="670px" alt="" />
                                </div>
                        <%  }
                            if (actpics.Length == 0)
                            {%>
                                <div class="slide">
                                    <img src="" alt="No pictures" />
                                </div>
                        <%  } %>    
                    </div>
                </div>
			</div>
			<script type="text/javascript">

				$('#foobar').slidertron({
					viewerSelector: '.viewer',
					reelSelector: '.viewer .reel',
					slidesSelector: '.viewer .reel .slide',
					navPreviousSelector: '.previous',
					navNextSelector: '.next',
					navFirstSelector: '.first',
					navLastSelector: '.last'
				});
						
			</script>
		</div>
        <div class="col2">
			<blockquote>
                <table style="table-layout:fixed; word-wrap:break-word;">
                    <tr><td>&#8220;&nbsp;<%: Model.slogan %>&nbsp;&#8221;</td></tr>
                </table>
            </blockquote>
		</div>
	</div>
</div>
<div id="page">
	<div id="page-bgtop">
		<div id="content">
			<div class="post">
                <div class="entry">
                    <table style="width: 569px; table-layout:fixed; word-wrap:break-word;">
                        <tr>
                            <td align="center">
                            <%  String path = "~/Content/Images/pics/Activity_" + Model.actid + ".jpg";
                                if (!System.IO.File.Exists(Server.MapPath(path)))
                                {
                                    path = "~/Content/Images/noavater.gif";
                                } %>
                                <%= Html.Image("logo_pic", ResolveUrl(path),
                                "No Pic", new { style = "width:100px;height:100px" })%>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size:large">&nbsp&nbsp&nbsp&nbsp<%: Model.acttext %></td>
                        </tr>
                        <tr>
                            <td style="font-size:large">
                                <span style="color:GREEN">Duration:</span>
                                &nbsp<%: Model.starttime %> - <%: Model.endtime %>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-size:large">
                                <span style="color:GREEN">CurrentNumber/MaxNumber:</span>
                                &nbsp<%: Model.usenum %>/<%: Model.maxuser %>
                            </td>
                        </tr>
                        <%  if (visitor != "org")
                            {
                                String orgController = "Admin";
                                String orgAction = "OrgDetails";
                                if (visitor != "admin")
                                {
                                    orgController = "Main";
                                    orgAction = "OrgDetails";
                                }
                                %>
                                <tr>
                                    <td style="font-size:large">
                                        <span style="color:GREEN">Organization:</span>
                                        &nbsp<%= Html.ActionLink(Model.orgname, orgAction, orgController, new { id = Model.orgname }, null)%>
                                    </td>
                                </tr>
                        <%      if (visitor == "user")
                                {
                                    String iftake = ViewData["take"] as String;
                                    if (iftake == null && Model.actstate == 1)
                                    {%>
                                        <tr>
                                            <% if (Model.usenum < Model.maxuser)
                                                { %>
                                                    <td align="center" style="font-size:xx-large">
                                                    <%= Html.ActionLink("Join us", "JoinActivity", "User", new { id = Model.actid, url = url }, null)%></td>
                                            <% }
                                                else
                                                { %>
                                                    <td style="font-size:x-large; color:Red;">Sorry, you can't join the activity,  because the number of participator has reached the maximum number.</td>
                                            <% } %>
                                        </tr>
                        <%          }
                                    else if (iftake != null && Model.actstate == 2)
                                    {%>
                                        <tr>
                                            <td style="font-size:large">
                                                <form method="post" action="<%= Url.Action("Rate", "User", new { id=Model.actid, username=ViewData["username"], url=url }) %>" >
                                                    <span style="color:GREEN">Rate for the Organization:</span>
                                                    &nbsp&nbsp&nbsp&nbsp
                                                    <%
                                                        bool[] selected = (bool[])ViewData["selected"];
                                                        List<SelectListItem> list = new List<SelectListItem> {
                                                            new SelectListItem { Text = "1", Value = "1", Selected = selected[0] },
                                                            new SelectListItem { Text = "2", Value = "2", Selected = selected[1] },
                                                            new SelectListItem { Text = "3", Value = "3", Selected = selected[2] },
                                                            new SelectListItem { Text = "4", Value = "4", Selected = selected[3] },
                                                            new SelectListItem { Text = "5", Value = "5", Selected = selected[4]}};
                                                    %>
                          
                                                        <%= Html.DropDownList("rate", list) %>
                                                        <input type="submit" value="Rate" />
                                                </form>
                                            </td>
                                        </tr>
                        <%                
                                    }
                                }
                            } %>
                    </table>
                </div>
			</div>		
		</div>

		<div id="sidebar">
			<%  if (visitor == "user" || visitor == "guest")
                    {
                        Wave.Models.TakeActivity[] part = ViewData["part"] as Wave.Models.TakeActivity[];
                        Wave.Models.Activity[] acts = ViewData["oAct"] as Wave.Models.Activity[];
                        String type = ViewData["type"] as String;
                        String username = ViewData["username"] as String;
                        %>
                        <ul>
                            <li id="act">
                                <h2 id="acth" style="font-size:x-large">Other Activities:</h2>
                                <ul>
                                    <%
                                        for (int i = 0; i < acts.Length && i < 10; i++)
                                        {
                                            String imgpath = "~/Content/Images/pics/Activity_" + acts[i].actid + ".jpg";
                                            if (!System.IO.File.Exists(Server.MapPath(imgpath)))
                                            {
                                                imgpath = "~/Content/Images/noavater.gif";
                                            }
                                    %>
                                            <li style="padding-left:40px;padding-top:10px;">
                                                <a href="/Activity/ActivityDetails/<%=acts[i].actid %>?usertype=<%=type %>&username=<%=username %>&url=<%=url %>">
                                                <%= Html.Image("activity_pic" + i, ResolveUrl(imgpath),
                                                    "No Pic", new { style = "width:80px;height:80px" })%></a>
                                                <br />
                                                <strong style="font-size:large"><%=acts[i].actname%></strong>
                                            </li>
                                    <%  } %>
                                </ul>
                            </li>
                        </ul>
                        <ul>
                            <li id="peo">
                                <h2 id="peoh" style="font-size:x-large">Other Participator:</h2>
                                <ul>
                                    <%
                                        for (int i = 0; i < part.Length && i < 10; i++)
                                        {
                                            String imgpath = "~/Content/Images/pics/User_" + part[i].username + ".jpg";
                                            if (!System.IO.File.Exists(Server.MapPath(imgpath)))
                                            {
                                                imgpath = "~/Content/Images/noavater.gif";
                                            }
                                    %>
                                            <li style="padding-left:40px;padding-top:10px;">
                                                <%= Html.Image("part" + i, ResolveUrl(imgpath), 
                                                    "No Pic", new { style = "width:80px;height:80px" })%>
                                                <br />
                                                <strong style="font-size:large"><%=part[i].username%></strong>
                                            </li>
                                    <%  } %>
                                </ul>
                            </li>
                        </ul>
                    <%}
                    else if (visitor == "admin")
                    { %>
                        <h2 style="font-size:x-large">
                        <% if (ViewData["review"] == null)
                           {%>
                            <%= Html.ActionLink("Pass The Activity", "PassActivity", "Admin", new { id = Model.actid, url = url }, null)%>
                        <%}
                           else
                           { %>
                           You have passed the activity.
                           <%} %>    
                        </h2>
                  <%}
                    else
                    {
                        String state = ViewData["state"] as String;
                        if (state == "apply")
                        {%>
                            <h2 style="font-size:x-large; height:90px">
                                Your activity is still under review. 
                            </h2>
                            <h2 style="font-size:large">
                                <%= Html.ActionLink("Delete The Activity?", "DeleteActivity", "Org", new { id = Model.actid, url = url }, null)%>  
                            </h2>
                  <%    }
                        else
                        {
                            Wave.Models.TakeActivity[] part = ViewData["part"] as Wave.Models.TakeActivity[];%>
                            <form id="form1" runat="server">
                                <h2 style="padding-left:0px; padding-top:0px; padding-bottom:10px; margin-left:-12px;">
                                    <asp:FileUpload ID="FileUpload" runat="server" />
                                </h2>
                            </form>
                            <h2 style="font-size:x-large">
                                <%= Html.ActionLink("Pick Some", "Pick", "Org", new { id = Model.actid, url = url }, null)%>
                            </h2>
                            <h2 style="font-size:x-large">Participator: 
                                <%  if (part.Length > 0)
                                    { %>
                                    <span style="font-size:large; position: relative; right: -40px;">
                                        <%= Html.ActionLink("More", "ParticipatorDetails", "Org", new { id = Model.actid }, null)%>  
                                    </span>
                                <%  } %>
                            </h2>
                            <ul>
                                <%
                                    for (int i = 0; i < part.Length && i < 10; i++)
                                    {
                                        String imgpath = "~/Content/Images/pics/User_" + part[i].username + ".jpg";
                                        if (!System.IO.File.Exists(Server.MapPath(imgpath)))
                                        {
                                            imgpath = "~/Content/Images/noavater.gif";
                                        }
                                %>
                                        <li style="padding-left:40px;padding-top:10px;">
                                            <%= Html.Image("part" + i, ResolveUrl(imgpath),
                                                "No Pic", new { style = "width:80px;height:80px" })%>
                                            <br />
                                            <strong style="font-size:large"><%=part[i].username%></strong>
                                        </li>
                                <%  } %>
                            </ul>
                            
                  <%   }
                    } %>
	    </div>
        <div style="clear: both;">&nbsp;</div>
    </div>
</div>
<div id="footer">
    <center>
        <br /><br />
        <h2 style="color:white"><a href="<%=url %>">Back</a></h2>
    </center>
</div>
</body>
</html>

<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Activity>" %>
<%@ Import Namespace="Wave.Helpers" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title></title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../Scripts/jquery.slidertron-0.1.js"></script>
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <link href="../../Content/CSS/style1.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../../Content/CSS/uploadify.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        @import url("../../Content/CSS/slidertron.css");
    </style>
    
    <script type = "text/javascript">
        $(window).load(
    function () {
        $("#<%=FileUpload.ClientID%>").fileUpload({
            'uploader': '../../Scripts/uploader.swf',
            'buttonText': 'Browse Files',
            'script': '../../Content/Images/Upload.ashx',
            'folder': '&actid=<%=Model.actid %>',
            'fileDesc': 'Image Files',
            'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
            'multi': true,
            'auto': true,
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
    <div id="logo">
        <h1></h1>
        <p></p>
    </div>
    <!-- end #logo -->
    <div id="header">
        <div id="menu">
            <h1 class="title" style="margin-top:10px">&nbsp&nbsp<%: Model.actname %></h1>
        </div>
    </div>
    <!-- end #header -->
    <hr />

    <div id="slideshow">
        <!-- start -->
        <div id="foobar">
            <div id="col1"><a href="#" class="previous">&nbsp;</a></div>
            <div id="col2">
                <div class="viewer">
                    <div class="reel">
                        <div class="slide">
                        <!--
                            <img src="../../Content/Images/Style1/img04.jpg" width="726" height="335" alt="" /> 
                            <span>Image 1</span>
                        -->
                        </div>
                    </div>
                </div>
            </div>
            <div id="col3"><a href="#" class="next">&nbsp;</a></div>
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
        <!-- end -->
    </div>
    <div id="page">
        <div id="page-bgtop">
            <div id="content">
                <div class="post">
                    <h2 class="title">Slogan: &nbsp&nbsp<%: Model.slogan %></h2>
                    <div class="entry">
                        <table style="width: 569px; table-layout:fixed; word-wrap:break-word;">
                            <tr>
                                <td>
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
            <!-- end #content -->
       
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
                                <div>
                                    <asp:FileUpload ID="FileUpload" runat="server" />
                                </div>
                            </form>
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
            <!-- end #sidebar -->
            <div style="clear: both;">&nbsp;</div>
        </div>
        <!-- end #page -->
    </div>
    <div id="footer">
    <center>
        <br /><br />
        <h2 style="color:white"><a href="<%=url %>">Back</a></h2>
    </center>
    </div>
<!-- end #footer -->
</body>
</html>

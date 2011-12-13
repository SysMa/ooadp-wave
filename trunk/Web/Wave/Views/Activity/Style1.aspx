<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Wave.Models.Activity>" %>
<%@ Import Namespace="Wave.Helpers" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Throughout  by Free CSS Templates</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <script type="text/javascript" src="../../Scripts/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../Scripts/jquery.slidertron-0.1.js"></script>
    <link href="../../Content/CSS/style1.css" rel="stylesheet" type="text/css" media="screen" />
    <style type="text/css">
        @import "../../Content/CSS/slidertron.css"
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("ul#hide").hide();
            $("ul#show").show();

            $("ul#show").click(function () {
                if ($("#hide").is(":hidden")) {
                    $("#hide").show();
                } else {
                    $("#hide").hide();
                }

                if ($("#show").is(":hidden")) {
                    $("#show").show();
                } else {
                    $("#show").hide();
                }
            });

            $("ul#hide").click(function () {
                if ($("#hide").is(":hidden")) {
                    $("#hide").show();
                } else {
                    $("#hide").hide();
                }

                if ($("#show").is(":hidden")) {
                    $("#show").show();
                } else {
                    $("#show").hide();
                }
            });
        });
    </script>
</head>
<body>
<!-- end #header-wrapper -->
<div id="logo">
    <h1><a href="#"></a></h1>
    <p><em></em></p>
</div>
<div id="header">
    <div id="menu">
        <ul>
            <li></li>
        </ul>
    </div>
</div>
<!-- end #header -->
<hr />
<!-- end #logo -->
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
                <h2 class="title">Activity Name:</h2>
                
                <div class="entry">
                    <p>
                    <img src="../../Content/Images/Style1/img11.jpg" width="560" height="270" alt="" />
                    des
                    </p>
                </div>
            </div>
        </div>
        <!-- end #content -->
        <div id="sidebar">
            <ul id="show">
                <li>
                    <h2>Other Activities:</h2>
                    <ul>
                        <li>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul id="hide">
                <li>
                    <h2>They are your partners:</h2>
                    <ul>
                        <li>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- end #sidebar -->
        <div style="clear: both;">&nbsp;</div>
    </div>
    <!-- end #page -->
</div>
<div id="footer">
<center>
    <br /><br /><h2 style="color:white">Back to Wave</h2>
</center>
</div>
<!-- end #footer -->
</body>
</html>

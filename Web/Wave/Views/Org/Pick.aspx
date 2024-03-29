﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <title>Wave | Choose the Best Style for Your Page</title>
        <link rel="stylesheet" href="../../Content/CSS/basic.css" type="text/css" />
        <style type="text/css">
            @import url("../../Content/CSS/galleriffic-2.css");
        </style>

        <script type="text/javascript" src="../../Scripts/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="../../Scripts/jquery.galleriffic.js"></script>
        <script src="../../Scripts/MicrosoftAjax.js" type="text/javascript"></script>
        <script src="../../Scripts/MicrosoftMvcAjax.js" type="text/javascript"></script>
        <script type="text/javascript" src="../../Scripts/jquery.opacityrollover.js"></script>
        <!-- We only want the thunbnails to display when javascript is disabled -->
        <script type="text/javascript">
            document.write('<style>.noscript { display: none; }</style>');
        </script>
        <script type="text/javascript">
            function disappear(id) {
                var a = document.getElementById("show" + id);
                document.getElementById("show").removeChild(a);
                document.getElementById("slideshow").innerHTML = "";
            }
        </script>
    </head>
    <body>
        <div id="page">
            <div id="container">
                <h1 style="color:#46C5EC">Wave</h1>
                <h2 style="color:#46C5EC">Choose the Best Style for Your Page</h2>

                <!-- Start Advanced Gallery Html Containers -->
                <div id="gallery" class="content">
                    <div id="controls" class="controls"></div>
                    <div class="slideshow-container">
                        <div id="loading" class="loader"></div>
                        <div id="slideshow" class="slideshow"></div>
                    </div>
                    <div id="caption" class="caption-container"></div>
                </div>
                <div id="thumbs" class="navigation">
                    <ul class="thumbs noscript">
                    <% Wave.Models.Images[] actpics = ViewData["imgs"] as Wave.Models.Images[];
                       for (int i = 0; i < actpics.Length; i++)
                       {
                           String imgpath = "../../Content/Images/ActivityImages/Activity_" + ViewData["actid"] + "/" + actpics[i].pic;
                    %>
                        <li id="<%=i %>">
                            <a class="thumb" name="pic<%=i %>" href="<%=imgpath %>" title="pic<%=i %>" style="width:125px; height:125px">
                                <img src="<%=imgpath %>" alt="Title #0" style="width:125px; height:125px" />
                            </a>
                            <div class="caption" id="show"> 
                            <div class="download" id="show<%=i %>" style="font-size:xx-large">
                                <% if (actpics[i].picstate == 0)
                                   {  %>
                                   <%= Ajax.ActionLink("Choose it.", "Toogle", "Org", new { actid = actpics[i].actid, pic = actpics[i].pic, url = Url, listid = i }, new AjaxOptions { UpdateTargetId = "show"+ i }) %>
                                    <% }
                                   else
                                   { %>
                                   <%= Ajax.ActionLink("Remove it.", "Toogle", "Org", new { actid = actpics[i].actid, pic = actpics[i].pic, url = Url, listid = i }, new AjaxOptions { UpdateTargetId = "show" + i })%>
                                    <% } %>
                                   | <%= Ajax.ActionLink("Delete it.", "DeletePic", "Org", new { actid = actpics[i].actid, pic = actpics[i].pic, url = Url, listid = i }, new AjaxOptions { UpdateTargetId = i.ToString(), OnSuccess = "function(){disappear('" + i + "')}" })%>
                            </div>
                            </div>
                        </li>
                        <%} %>
                    </ul>
                </div>
                <div style="clear: both;"></div>
                <div style="font-size:xx-large;">
                    <a href="<%=ViewData["url"] %>">Back</a>
                </div>
            </div>
        </div>
        <div id="footer">&copy;</div>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                // We only want these styles applied when javascript is enabled
                $('div.navigation').css({ 'width': '300px', 'float': 'left' });
                $('div.content').css('display', 'block');

                // Initially set opacity on thumbs and add
                // additional styling for hover effect on thumbs
                var onMouseOutOpacity = 0.67;
                $('#thumbs ul.thumbs li').opacityrollover({
                    mouseOutOpacity: onMouseOutOpacity,
                    mouseOverOpacity: 1.0,
                    fadeSpeed: 'fast',
                    exemptionSelector: '.selected'
                });

                // Initialize Advanced Galleriffic Gallery
                var gallery = $('#thumbs').galleriffic({
                    delay: 2500,
                    numThumbs: 15,
                    preloadAhead: 10,
                    enableTopPager: true,
                    enableBottomPager: true,
                    maxPagesToShow: 7,
                    imageContainerSel: '#slideshow',
                    controlsContainerSel: '#controls',
                    captionContainerSel: '#caption',
                    loadingContainerSel: '#loading',
                    renderSSControls: true,
                    renderNavControls: true,
                    prevLinkText: '&lsaquo; Previous Model',
                    nextLinkText: 'Next Model &rsaquo;',
                    nextPageLinkText: 'Next &rsaquo;',
                    prevPageLinkText: '&lsaquo; Prev',
                    enableHistory: false,
                    autoStart: false,
                    syncTransitions: true,
                    defaultTransitionDuration: 900,
                    onSlideChange: function (prevIndex, nextIndex) {
                        // 'this' refers to the gallery, which is an extension of $('#thumbs')
                        this.find('ul.thumbs').children()
                            .eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
                            .eq(nextIndex).fadeTo('fast', 1.0);
                    },
                    onPageTransitionOut: function (callback) {
                        this.fadeTo('fast', 0.0, callback);
                    },
                    onPageTransitionIn: function () {
                        this.fadeTo('fast', 1.0);
                    }
                });
            });
        </script>
    </body>
</html>
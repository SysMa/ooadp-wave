<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage<Wave.Models.LoginModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Wave
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Login" runat="server">
<% Html.RenderPartial("~/Views/Shared/Message.ascx"); %>
<center>
    <form method="post" action="<%= Url.Action("Login", "Main") %>" >
        <br />
        <label>Account</label>
        <%= Html.TextBoxFor(model => model.account, new { size = 10 })%>
            
        <label>Password</label>
        <%= Html.PasswordFor(model => model.password, new { size = 10 })%>

        <label>Type</label>
        <%
            List<SelectListItem> list = new List<SelectListItem> {
            new SelectListItem { Text = "SuperAdmin", Value = "0"},
            new SelectListItem { Text = "Admin", Value = "1" },
            new SelectListItem { Text = "Organization", Value = "2" },
            new SelectListItem { Text = "User", Value = "3" ,Selected = true}};
        %>
        <%= Html.DropDownListFor(model => model.type, list) %>

        <br /><br />
        <%= Html.ActionLink("Forgot Password", "ForgotPassword") %> | 
        <%= Html.ActionLink("Join Now", "Register") %> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <button type="submit" id="user-login-button" >Log In</button>
    </form>

</center>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

        <!-- this isn’t part of the plugin, just a control for demo -->
        <ul class="splitter">
            <li>
                <ul>
                    <li class="segment-1 selected-1">
                        <a href="#" data-value="all">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp ALL&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                    </li>
                    <li class="segment-0"><a href="#" data-value="app">&nbsp Activities&nbsp</a>
                    </li>
                    <li class="segment-2"><a href="#" data-value="util">Organizations</a>
                    </li>
                </ul>
            </li>
        </ul>

        <div class="demo">
          <!-- read the documentation to understand what’s going on here -->
          <ul id="list" class="image-grid" style="height: 591px; "><li data-id="id-1" class="util">
              <img src="./jQuery Quicksand plugin_files/activity-monitor.png" width="128" height="128" alt="">
              <strong>Activity Monitor</strong>
              <span>348 KB</span>
            </li><li data-id="id-2" class="app">
              <img src="./jQuery Quicksand plugin_files/address-book.png" width="128" height="128" alt="">
              <strong>Address Book</strong><span>1904 KB</span>
            </li><li data-id="id-3" class="app">
              <img src="./jQuery Quicksand plugin_files/finder.png" width="128" height="128" alt="">
              <strong>Finder</strong>
              <span>1337 KB</span>
            </li><li data-id="id-4" class="app">
              <img src="./jQuery Quicksand plugin_files/front-row.png" width="128" height="128" alt="">
              <strong>Front Row</strong>
              <span>401 KB</span>
            </li><li data-id="id-5" class="app">
              <img src="./jQuery Quicksand plugin_files/google-pokemon.png" width="128" height="128" alt="">
              <strong>Google Pokémon</strong>
              <span>12875 KB</span>
            </li><li data-id="id-6" class="app">
              <img src="./jQuery Quicksand plugin_files/ical.png" width="128" height="128" alt="">
              <strong>iCal</strong>
              <span>5273 KB</span>
            </li><li data-id="id-7" class="app">
              <img src="./jQuery Quicksand plugin_files/ichat.png" width="128" height="128" alt="">
              <strong>iChat</strong>
              <span>5437 KB</span>
            </li><li data-id="id-8" class="app">
              <img src="./jQuery Quicksand plugin_files/interface-builder.png" width="128" height="128" alt="">
              <strong>Interface Builder</strong>
              <span>2764 KB</span>
            </li><li data-id="id-9" class="app">
              <img src="./jQuery Quicksand plugin_files/ituna.png" width="128" height="128" alt="">
              <strong>iTuna</strong>
              <span>17612 KB</span>
            </li><li data-id="id-10" class="util">
              <img src="./jQuery Quicksand plugin_files/keychain-access.png" width="128" height="128" alt="">
              <strong>Keychain Access</strong>
              <span>972 KB</span>
            </li><li data-id="id-11" class="util">
              <img src="./jQuery Quicksand plugin_files/network-utility.png" width="128" height="128" alt="">
              <strong>Network Utility</strong>
              <span>245 KB</span>
            </li><li data-id="id-12" class="util">
              <img src="./jQuery Quicksand plugin_files/sync.png" width="128" height="128" alt="">
              <strong>Sync</strong>
              <span>3788 KB</span>
            </li><li data-id="id-13" class="app">
              <img src="./jQuery Quicksand plugin_files/textedit.png" width="128" height="128" alt="">
              <strong>TextEdit</strong>
              <span>1669 KB</span>
            </li>
          </ul>
        </div>

</asp:Content>

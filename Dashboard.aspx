<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DailyNeuzz.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <title>Dashboard - DailyNeuzz</title>
    <style>
        * {
    margin: 0;.post-card {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }
    
    .post-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }
    padding: 0;
    box-sizing: border-box;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
}

body {
    background-color: #f5f5f5;
}
/* Header styles */
header {
    background-color: white;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
}

.header-content {
    max-width: 1280px;
    margin: 0 auto;
    padding: 1rem;
    display: grid;
    grid-template-columns: auto auto auto;
    align-items: center;
    gap: 2rem;
}

.header-left {
    display: flex;
    align-items: center;
}

.header-center {
    display: flex;
    justify-content: center;
    flex: 1;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    justify-content: flex-end;
}

.header-logo {
    font-size: 1.5rem;
    font-weight: 600;
    color: rgb(31, 41, 55);
    text-decoration: none;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 1.5rem;
}

.nav-link {
    color: rgb(75, 85, 99);
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s;
}

.nav-link:hover {
    color: rgb(31, 41, 55);
}

.nav-link.active {
    color: rgb(31, 41, 55);
    font-weight: 600;
}

/* Search box styles */
.search-box {
    position: relative;
    width: 100%;
    max-width: 500px;
}

.search-input {
    width: 100%;
    padding: 0.5rem 2.5rem 0.5rem 1rem;
    border-radius: 0.5rem;
    border: 1px solid rgb(229, 231, 235);
    background-color: rgb(249, 250, 251);
}

.search-icon {
    position: absolute;
    right: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    color: rgb(156, 163, 175);
}

/* Profile dropdown styles */
.profile-dropdown {
    position: relative;
}

.profile-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    background-color: rgb(243, 244, 246);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    border: 2px solid rgb(229, 231, 235);
}

.profile-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.profile-placeholder {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.profile-placeholder svg {
    width: 24px;
    height: 24px;
    color: rgb(156, 163, 175);
}

.dropdown-menu {
    position: absolute;
    top: 100%;
    right: 0;
    width: 240px;
    background-color: white;
    border: 1px solid rgb(229, 231, 235);
    border-radius: 0.5rem;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    margin-top: 0.5rem;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    transition: all 0.2s;
}

.profile-dropdown:hover .dropdown-menu {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.user-info {
    padding: 0.75rem 1rem;
    border-bottom: 1px solid rgb(229, 231, 235);
    color: rgb(55, 65, 81);
    font-size: 0.875rem;
}

.dropdown-item {
    display: block;
    padding: 0.75rem 1rem;
    color: rgb(55, 65, 81);
    text-decoration: none;
    transition: background-color 0.2s;
}

.dropdown-item:hover {
    background-color: rgb(243, 244, 246);
}

.login-btn {
    display: inline-block;
    padding: 0.5rem 1rem;
    background-color: #000;
    color: white;
    text-decoration: none;
    border-radius: 0.375rem;
    font-weight: 500;
    transition: background-color 0.2s;
}

.login-btn:hover {
    background-color: rgb(67, 56, 202);
}

/* Sidebar Styles */
.sidebar {
    position: fixed;
    left: 0;
    top: 70px;
    bottom: 0;
    width: 250px;
    background-color: #B0C4DE;
    padding: 2rem 1rem;
}

.sidebar-menu {
    list-style: none;
}

    .sidebar-menu li {
        margin-bottom: 1rem;
    }

    .sidebar-menu a {
        text-decoration: none;
        color: #666;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem;
        border-radius: 5px;
    }

        .sidebar-menu a:hover {
            background-color: #e9ecef;
        }

/* Main Content Styles */
.main-content {
    margin-left: 250px;
    margin-top: 70px;
    padding: 2rem;
}

.stats-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
    margin-bottom: 2rem;
}

.stat-card {
    background-color: white;
    border-radius: 10px;
    padding: 1.5rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.stat-title {
    font-size: 0.875rem;
    color: #666;
    margin-bottom: 0.5rem;
}

.stat-value {
    font-size: 2rem;
    font-weight: bold;
    color: #333;
}

.stat-period {
    font-size: 0.75rem;
    color: #999;
}

/* Tables Styles */
.table-container {
    background-color: white;
    border-radius: 10px;
    padding: 1.5rem;
    margin-top: 2rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.table {
    width: 100%;
    border-collapse: collapse;
}

    .table th, .table td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #eee;
    }

    .table th {
        font-weight: 600;
        color: #666;
    }

.see-all-btn {
    background-color: #000;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 5px;
    text-decoration: none;
    font-size: 0.875rem;
}

.category-tag {
    background-color: #f0f0f0;
    padding: 0.25rem 0.5rem;
    border-radius: 15px;
    font-size: 0.75rem;
    color: #666;
}

    </style>
</head>
<body>
       <form id="form1" runat="server">
      <!-- Header -->
 <header>
     <div class="header-content">
         <div class="header-left">
             <a href="Home.aspx" class="header-logo">DailyNeuzz</a>
         </div>

         <div class="header-center">
             <div class="search-box">
                 <input type="text" class="search-input" placeholder="Search..." />
                 <svg xmlns="http://www.w3.org/2000/svg" class="search-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                     <circle cx="11" cy="11" r="8"></circle>
                     <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                 </svg>
             </div>
         </div>
         
         <div class="header-right">
             <nav class="nav-links">
                 <a href="Home.aspx" class="nav-link">Home</a>
                 <a href="About.aspx" class="nav-link">About</a>
                 <a href="NewsArticles.aspx" class="nav-link">News Articles</a>
             </nav>

             <% if (Session["UserEmail"] == null) { %>
                 <!-- User is not logged in -->
                 <a href="SignIn.aspx" class="login-btn">Login</a>
             <% } else { %>
                 <!-- User is logged in -->
                 <div class="profile-dropdown">
                     <div class="profile-icon">
                         <asp:Image ID="imgProfile" runat="server" CssClass="profile-image" Visible="false" />
                         <div id="headerProfilePlaceholder" runat="server" class="profile-placeholder">
                             <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                 <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                 <circle cx="12" cy="7" r="4"></circle>
                             </svg>
                         </div>
                     </div>
                     <div class="dropdown-menu">
                         <div class="user-info">
                             <asp:Literal ID="litUserEmail" runat="server"></asp:Literal>
                         </div>
                         <a href="Profile.aspx" class="dropdown-item">Profile</a>
                         <asp:LinkButton ID="LinkButton1" runat="server" OnClick="Logout_Click" CssClass="dropdown-item">Logout</asp:LinkButton>
                     </div>
                 </div>
             <% } %>
         </div>
     </div>
 </header>

        <div class="sidebar">
            <ul class="sidebar-menu">
                <li><asp:LinkButton ID="lnkDashboard" runat="server" OnClick="lnkDashboard_Click"><i class="fas fa-home"></i> Dashboard</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkProfile" runat="server" OnClick="lnkProfile_Click"><i class="fas fa-user"></i> Profile</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkCreatePost" runat="server" OnClick="lnkCreatePost_Click"><i class="fas fa-plus"></i> Create Post</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkArticles" runat="server" OnClick="lnkArticles_Click"><i class="fas fa-newspaper"></i> Your Articles</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkUsers" runat="server" OnClick="lnkUsers_Click"><i class="fas fa-users"></i> All Users</asp:LinkButton></li>
                <li><asp:LinkButton ID="lnkComments" runat="server" OnClick="lnkComments_Click"><i class="fas fa-comments"></i> All Comments</asp:LinkButton></li>
                <li>
                <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </asp:LinkButton>
</li>

            </ul>
        </div>

        <div class="main-content">
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-title">All Users</div>
                    <asp:Label ID="lblTotalUsers" runat="server" CssClass="stat-value">4</asp:Label>
                    <div class="stat-period">Last month: 4</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Total Comments</div>
                    <asp:Label ID="lblTotalComments" runat="server" CssClass="stat-value">2</asp:Label>
                    <div class="stat-period">Last month: 2</div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Total Posts</div>
                    <asp:Label ID="lblTotalPosts" runat="server" CssClass="stat-value">11</asp:Label>
                    <div class="stat-period">Last month: 11</div>
                </div>
            </div>

            <asp:GridView ID="gvRecentUsers" runat="server" AutoGenerateColumns="False" CssClass="table">
                <Columns>
                    <asp:ImageField DataImageUrlField="UserImage" HeaderText="User Image" ControlStyle-Width="40" ControlStyle-Height="40" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                </Columns>
            </asp:GridView>

            <asp:GridView ID="gvRecentPosts" runat="server" AutoGenerateColumns="False" CssClass="table">
                <Columns>
                    <asp:ImageField DataImageUrlField="PostImage" HeaderText="Post Image" ControlStyle-Width="40" ControlStyle-Height="40" />
                    <asp:BoundField DataField="Title" HeaderText="Post Title" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                </Columns>
            </asp:GridView>
        </div>
    </form>

    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
</body>
</html>
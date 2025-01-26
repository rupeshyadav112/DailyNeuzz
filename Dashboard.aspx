<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DailyNeuzz.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <title>Dashboard - DailyNeuzz</title>
    <style>
        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
}

body {
    background-color: #f5f5f5;
}
/* Header Styles */
header {
    background-color: var(--background-color);
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: var(--header-height);
    position: relative;
}

#profile-section {
    position: relative;
    margin-left: 20px;
}

.profile-dropdown {
    position: relative;
    cursor: pointer;
    display: flex;
    align-items: center;
}

.profile-image {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
}

.dropdown-menu {
    display: none;
    position: absolute;
    top: 100%;
    right: 0;
    background-color: var(--background-color);
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    border-radius: 4px;
    padding: 10px;
    min-width: 200px;
    z-index: 1000;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
    color: var(--secondary-color);
    text-decoration: none;
}

/* Search Bar Styles */
.search-bar {
    display: flex;
    align-items: center;
    background-color: #f1f3f4;
    border-radius: 24px;
    padding: 6px 12px;
    margin: 0 20px;
    flex-grow: 1;
    max-width: 300px;
}

.search-icon {
    width: 20px;
    height: 20px;
    margin-right: 8px;
    color: #5f6368;
}

.search-bar input {
    border: none;
    background: transparent;
    font-size: 1rem;
    width: 100%;
    outline: none;
}

/* Navigation Styles */
nav ul {
    display: flex;
    list-style-type: none;
}

    nav ul li {
        margin-left: 20px;
    }

        nav ul li a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

            nav ul li a:hover {
                color: var(--primary-color);
            }

/* Login Button Styles */
.login-btn {
    background-color: var(--primary-color);
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
    text-decoration: none;
    transition: background-color 0.3s ease;
}

    .login-btn:hover {
        background-color: #2980b9;
    }

/* Profile Dropdown Styles */

.profile-dropdown:hover .dropdown-menu {
    display: block;
}

.dropdown-menu a {
    display: block;
    padding: 5px 0;
    color: var(--secondary-color);
    text-decoration: none;
}

    .dropdown-menu a:hover {
        color: var(--primary-color);
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
     <header>
    <div class="container">
        <div class="header-content">
            <a href="/" class="logo">DailyNeuzz</a>

            <div class="search-bar">
                <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
                <input type="text" placeholder="Search..." />
            </div>

            <nav>
                <ul>
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="About.aspx">About</a></li>
                    <li><a href="NewsArticles.aspx">News Articles</a></li>
                    <li id="profile-section">
                        <% if (Session["UserEmail"] == null) { %>
                            <!-- User is not logged in -->
                            <a href="SignIn.aspx" class="login-btn">Login</a>
                        <% } else { %>
                            <!-- User is logged in -->
                            <div class="profile-dropdown">
                                <asp:Image ID="imgProfile" runat="server" CssClass="profile-image" />
                                <div class="dropdown-menu">
                                    <asp:Literal ID="litUserEmail" runat="server"></asp:Literal>
                                    <a href="Profile.aspx">Profile</a>
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="Logout_Click">Logout</asp:LinkButton>
                                </div>
                            </div>
                        <% } %>
                    </li>
                </ul>
            </nav>
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
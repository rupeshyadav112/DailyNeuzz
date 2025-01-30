﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsArticles.aspx.cs" Inherits="DailyNeuzz.NewsArticles" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>News Articles - DailyNeuzz</title>
    <link rel="stylesheet" href="Home.css">
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: rgb(249, 250, 251);
            color: rgb(55, 65, 81);
            line-height: 1.5;
            padding-top: 73px;
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
            background-color: rgb(79, 70, 229);
            color: white;
            text-decoration: none;
            border-radius: 0.375rem;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .login-btn:hover {
            background-color: rgb(67, 56, 202);
        }

        /* Main Layout */
        .main-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 2rem;
        }

        /* Sidebar Filters */
        .filters {
            background: white;
            padding: 1.5rem;
            border-radius: 0.5rem;
            border: 1px solid #e5e7eb;
            height: fit-content;
            margin-top: 1rem;
        }

        .filters h2 {
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .filter-group {
            margin-bottom: 1.5rem;
        }

        .filter-group label {
            display: block;
            font-size: 0.875rem;
            color: #6b7280;
            margin-bottom: 0.5rem;
        }

        .filter-group input,
        .filter-group select {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            margin-bottom: 1rem;
        }

        .apply-filters {
            width: 100%;
            padding: 0.75rem;
            background: #ef4444;
            color: white;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
        }

        .apply-filters:hover {
            background: #dc2626;
        }

 <!-- Update the Articles Grid CSS section in your style tag -->
/* Articles Grid Styles */
.articles-container {
    margin-top: 0.5rem;
}
      .articles-container h1 {
    font-size: 1.5rem;
    margin-bottom: 1.5rem;
    color: #111827;
    margin-top: 0;
    padding-top: 1rem;
}

.articles-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
}

.article-card {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease;
}

.article-card:hover {
    transform: translateY(-4px);
}

.article-image {
    width: 100%;
    height: 200px; /* Fixed height for consistent look */
    object-fit: cover;
    display: block;
}

.article-content {
    padding: 1rem;
}

.article-category {
    font-size: 0.875rem;
    color: #666;
    text-transform: uppercase;
    margin-bottom: 0.5rem;
}

.article-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1a1a1a;
    margin-bottom: 1rem;
    line-height: 1.4;
}

.read-article {
    display: block;
    width: 100%;
    padding: 0.75rem;
    background: #2d3748;
    color: white;
    text-align: center;
    text-decoration: none;
    border-radius: 6px;
    transition: background-color 0.2s ease;
}

.read-article:hover {
    background: #1a202c;
}

        /* Footer */
        footer {
            background: #1f2937;
            color: white;
            padding: 4rem 2rem;
            margin-top: 4rem;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 4rem;
        }

        .footer-section h3 {
            font-size: 1.25rem;
            margin-bottom: 1rem;
            color: #f3f4f6;
        }

        .footer-section p,
        .footer-section address {
            color: #9ca3af;
            font-style: normal;
            line-height: 1.6;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 0.5rem;
        }

        .footer-links a {
            color: #9ca3af;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            .main-container {
                grid-template-columns: 1fr;
            }

            .search-box {
                display: none;
            }

            .articles-grid {
                grid-template-columns: 1fr;
            }

            .footer-content {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        
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
                        <a href="NewsArticles.aspx" class="nav-link active">News Articles</a>
                    </nav>

                    <div class="profile-dropdown">
                        <a href="Profile.aspx" class="profile-icon">
                            <asp:Image ID="headerProfileImg" runat="server" Visible="false" />
                            <div class="profile-placeholder">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" id="headerProfilePlaceholder" runat="server">
                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </div>
                        </a>
                        <div class="dropdown-menu">
                            <div class="user-info">
                                <asp:Label ID="headerUsername" runat="server" Text="Username"></asp:Label>
                            </div>
                            <a href="Profile.aspx" class="dropdown-item">Profile</a>
                            <a href="Logout.aspx" class="dropdown-item">Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <main class="main-container">
           <aside class="filters">
        <h2>Filters</h2>
        <div class="filter-group">
            <label for="txtSearchTerm">Search Term:</label>
            <asp:TextBox ID="txtSearchTerm" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="filter-group">
            <label for="ddlSortBy">Sort By</label>
            <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-control">
                <asp:ListItem Value="">Select an option</asp:ListItem>
                <asp:ListItem Value="date">Date</asp:ListItem>
                <asp:ListItem Value="popularity">Popularity</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="filter-group">
            <label for="ddlCategory">Category:</label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                <asp:ListItem Value="">Select a Category</asp:ListItem>
                <asp:ListItem Value="worldnews">World News</asp:ListItem>
                <asp:ListItem Value="localnews">Local News</asp:ListItem>
                <asp:ListItem Value="sportsnews">Sports</asp:ListItem>
                <asp:ListItem Value="entertainment">Entertainment</asp:ListItem>
                <asp:ListItem Value="technology">Technology</asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Button ID="btnApplyFilters" runat="server" Text="Apply Filter" CssClass="apply-filters" OnClick="btnApplyFilters_Click" />
    </aside>


            <!-- Total articles here -->
            <section class="articles-container">
                <h1>News Articles</h1>
                <div class="articles-grid">
                   <!-- Update Repeater Section -->
<asp:Repeater ID="rptArticles" runat="server">
    <ItemTemplate>
        <article class="article-card">
            <asp:Image 
                ID="imgArticle" 
                runat="server" 
                ImageUrl='<%# Eval("ImagePath") != DBNull.Value ? ResolveUrl(Eval("ImagePath").ToString()) : ResolveUrl("~/images/default.jpg") %>' 
                CssClass="article-image" 
                AlternateText='<%# Eval("Title") %>' />
            
            <div class="article-content">
                <h2 class="article-title"><%# Eval("Title") %></h2>
                <p class="article-category"><%# Eval("Category") %></p>
                <p class="article-date"><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy") %></p>
                <a href='<%# $"ReadArticles.aspx?id={Eval("PostID")}" %>' class="read-article">Read Full Article</a>
            </div>
        </article>
    </ItemTemplate>
</asp:Repeater>
                </div>
            </section>
        </main>

        <footer>
            <div class="footer-content">
                <div class="footer-section">
                    <h3>About Us</h3>
                    <p>We are committed to delivering the best service and information. Our mission is to enrich lives through exceptional digital experiences.</p>
                </div>
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="/">Home</a></li>
                        <li><a href="/about">About Us</a></li>
                        <li><a href="/news-articles">News Articles</a></li>
                        <li><a href="/contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>Contact Us</h3>
                    <address>
                        1234 Street Name, City, Country<br>
                        Email: ryadav943@gmail.com<br>
                        Phone: +91234 567890
                    </address>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>

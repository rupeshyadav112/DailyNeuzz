<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="DailyNeuzz.Home" %>

<!DOCTYPE html>
<meta name="description" content="Your trusted source for the latest headlines, in-depth analysis, and breaking news every morning.">
<meta name="viewport" content="width=device-width, initial-scale=1">
<html xmlns="http://www.w3.org/1999/xhtml">
   
<head runat="server">
    <title>DailyNeuzz</title>
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

        /* View More button styling */
        .view-more-container {
            text-align: center;
            margin-top: 40px;
        }
        .view-more-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
            padding: 12px 24px;
            background-color: #4F46E5;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .view-more-btn:hover {
            background-color: #4338CA;
            transform: translateY(2px);
        }
        .view-more-btn svg {
            width: 20px;
            height: 20px;
            transition: transform 0.3s ease;
        }
        .view-more-btn:hover svg {
            transform: translateY(3px);
        }
            /* Recent Posts Section */
        .recent-posts {
            padding: 4rem 0;
            background-color: #f9fafb;
        }

        .recent-posts h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 3rem;
        }

        .recent-posts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .post-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }

        .post-card:hover {
            transform: translateY(-4px);
        }

        .post-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .post-content {
            padding: 1.5rem;
        }

        .post-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .post-category {
            font-size: 0.875rem;
            color: #6b7280;
            text-transform: uppercase;
            margin-bottom: 1rem;
        }

        .post-description {
            color: #4b5563;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .post-footer {
            padding: 1rem 1.5rem;
            border-top: 1px solid #e5e7eb;
        }

        .button {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            text-decoration: none;
            transition: all 0.2s;
        }

        .button-secondary {
            background-color: var(--secondary-color);
            color: white;
        }

        .button-secondary:hover {
            background-color: #4338ca;
        }

        .button-full {
            width: 100%;
            text-align: center;
        }
    </style>
    <script>
        function searchFunction() {
            // Get the search input value
            var input = document.getElementById("searchInput").value.toLowerCase();

            // Get all the post cards
            var posts = document.querySelectorAll(".post-card");

            // Loop through all posts and hide those that don't match the search query
            posts.forEach(function (post) {
                var title = post.querySelector(".post-title").innerText.toLowerCase();
                var category = post.querySelector(".post-category").innerText.toLowerCase();

                if (title.includes(input) || category.includes(input)) {
                    post.style.display = "block"; // Show the post
                } else {
                    post.style.display = "none"; // Hide the post
                }
            });
        }
    </script>
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
        <input type="text" id="searchInput" class="search-input" placeholder="Search..." onkeyup="searchFunction()" />
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
                                <asp:LinkButton ID="lnkLogout" runat="server" OnClick="Logout_Click" CssClass="dropdown-item">Logout</asp:LinkButton>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </header>

        <main>
  <section class="hero" style="text-align: left;">
    <div class="container" style="text-align: left;">
        <h1><span style="color: blue;">Welcome to</span> <span style="color: red;">DailyNeuzz</span></h1>
        <p style="text-align: left !important;">Your trusted source for the latest headlines, in-depth analysis, and breaking news every morning</p>
        <p><i>Stay informed, stay ahead!</i></p>
        <a href="NewsArticles.aspx" class="button button-primary" style="background-color: yellow; color: black;">View all posts
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width: 20px; height: 20px; vertical-align: middle; margin-left: 5px; transform: rotate(270deg);">
                <line x1="12" y1="5" x2="12" y2="19"></line>
                <polyline points="19 12 12 19 5 12"></polyline>
            </svg>
        </a>
    </div>
</section>

        <!-- Features Section -->
        <section class="features">
            <div class="container">
                <h2>Why You'll Love Daily Neuzz</h2>
                <div class="features-grid">
                    <div class="card">
                       <img src="image/Book.png" alt="Icon">

                        <h3>Diverse Content</h3>
                        <p>Explore news on a variety of topics, from technology to lifestyle.</p>
                    </div>
                    <div class="card">
                       <img src="image/global.png" alt="Icon">
                        <h3>Community Driven</h3>
                        <p>Connect with writers and readers who share your interests.</p>
                    </div>
                    <div class="card">
                       <img src="image/rocket.png" alt="Icon">
                        <h3>Easy to Use</h3>
                        <p>A seamless platform for sharing and discovering great content.</p>
                    </div>
                </div>
            </div>
        </section>
        <!-- CTA-->
       <section class="cta">
    <div class="container cta-content">
        <div class="cta-text">
            <h2>Want to know more about today's TOP 10 news?</h2>
            <p>Checkout these top news articles</p>
            <a href="/news" class="button button-primary button-large">Stay Updated with Daily News: Your Go-To Resources</a>
        </div>
        <div class="cta-image">
            <img src="image/news.jpeg" alt="News Image">
        </div>
    </div>
</section>



     <!-- Recent Posts Section -->
            <section class="recent-posts">
                <div class="container">
                    <h2 style="text-align: left;">Recent Posts</h2>
                    <div class="recent-posts-grid">
                        <asp:Repeater ID="rptRecentPosts" runat="server">
                            <ItemTemplate>
                                <article class="post-card">
                                <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("Title") %>' />
                                    <div class="post-content">
                                        <h3 class="post-title"><%# Eval("Title") %></h3>
                                        <p class="post-category"><%# Eval("Category") %></p>
                                        <%--<p class="post-description"><%# Eval("Content") %></p>--%>
                                    </div>
                                    <div class="post-footer">
                                        <a href='<%# $"ReadArticles.aspx?id={Eval("PostID")}" %>' class="button button-secondary button-full">Read Article</a>
                                    </div>
                                </article>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="view-more-container">
                        <a href="NewsArticles.aspx" class="view-more-btn">
                            View More
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="12" y1="5" x2="12" y2="19"></line>
                                <polyline points="19 12 12 19 5 12"></polyline>
                            </svg>
                        </a>
                    </div>
                </div>
            </section>

    </main>

    <footer>
        <div class="container">
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
                        <li><a href="/news">News Articles</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>Contact Us</h3>
                    <address>
                        1234 Street Name, City, Country<br>
                        Email: ryadav943@gmail.com<br>
                        Phone: +91234567890
                    </address>
                </div>
            </div>
        </div>
    </footer>
    </form>
</body>
</html>
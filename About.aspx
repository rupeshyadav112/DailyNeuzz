<%@ Page Language="C#" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="DailyNeuzz.About" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About - DailyNeuzz</title>
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

        /* Hero Section */
        .hero {
            padding: 4rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }

        .hero-content h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #1f2937;
        }

        .hero-content p {
            color: #6b7280;
            font-size: 1.125rem;
        }

        .hero-image {
            width: 100%;
            border-radius: 8px;
            overflow: hidden;
        }

        .hero-image img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }

        /* Team Section */
        .team-section {
            padding: 4rem 2rem;
            background: #f9fafb;
            text-align: center;
        }

        .team-section h2 {
            font-size: 2rem;
            margin-bottom: 3rem;
            color: #1f2937;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            max-width: 900px;
            margin: 0 auto;
        }

        .team-member {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .team-member-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: #e5e7eb;
            margin-bottom: 1rem;
            overflow: hidden;
        }

        .team-member-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .team-member h3 {
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }

        .team-member p {
            color: #6b7280;
        }

        /* Footer */
        footer {
            background: #1f2937;
            color: white;
            padding: 4rem 2rem;
        }

        .footer-content {
            max-width: 1200px;
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

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-links a {
            color: #9ca3af;
            text-decoration: none;
        }

        .footer-bottom {
            text-align: center;
            margin-top: 4rem;
            padding-top: 2rem;
            border-top: 1px solid #374151;
            color: #9ca3af;
        }

        @media (max-width: 768px) {
            .hero {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .team-grid {
                grid-template-columns: 1fr;
            }

            .footer-content {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .search-container {
                display: none;
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
                        <a href="About.aspx" class="nav-link active">About</a>
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
                                <asp:LinkButton ID="lnkLogout" runat="server" OnClick="Logout_Click" CssClass="dropdown-item" Text="Logout"></asp:LinkButton>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </header>

        <main>
        <section class="hero">
            <div class="hero-content">
                <h1>Who We Are</h1>
                <p>Something new which i required in project</p>
            </div>
            <div class="hero-image">
                <img src="image/news2.jpg" alt="Typewriter with News text">
            </div>
        </section>

        <section class="team-section">
            <h2>Meet Our Team</h2>
            <div class="team-grid">
                <div class="team-member">
                    <div class="team-member-avatar">
                        <img src="image/news2.jpg?height=120&width=120" alt="Rupesh Yadav">
                    </div>
                    <h3>Rupesh Yadav</h3>
                    <p>CEO</p>
                </div>
                <div class="team-member">
                    <div class="team-member-avatar">
                        <img src="image/news2.jpg?height=120&width=120" alt="Arjun Mahato">
                    </div>
                    <h3>Arjun Mahato</h3>
                    <p>CTO</p>
                </div>
                <div class="team-member">
                    <div class="team-member-avatar">
                        <img src="image/news2.jpg?height=120&width=120" alt="Krishna Yadav">
                    </div>
                    <h3>Krishna Yadav</h3>
                    <p>CEO</p>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <p>We are committed to delivering the best news service and information. Our mission is to enrich lives through exceptional digital experiences.</p>
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
                    Email: yadav943@gmail.com<br>
                    Phone: +91234 567890
                </address>
                <div class="social-links">
                    <a href="#">Facebook</a>
                    <a href="#">Twitter</a>
                    <a href="#">Instagram</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p> 2024 DailyNeuzz. All rights reserved.</p>
        </div>
    </footer>
        </form>
</body>
</html>

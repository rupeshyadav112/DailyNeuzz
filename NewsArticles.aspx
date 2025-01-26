<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsArticles.aspx.cs" Inherits="DailyNeuzz.NewsArticles" %>

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

        /* Articles Grid */
        .articles-container h1 {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            color: #111827;
            margin-top: 1rem;
        }

        .articles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }

        .article-card {
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
            border: 1px solid #e5e7eb;
        }

        .article-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .article-content {
            padding: 1.5rem;
        }

        .article-title {
            font-size: 1.125rem;
            margin-bottom: 0.5rem;
            color: #111827;
        }

        .article-category {
            font-size: 0.875rem;
            color: #6b7280;
            margin-bottom: 1rem;
        }

        .read-article {
            display: block;
            width: 100%;
            padding: 0.75rem;
            text-align: center;
            background: #f3f4f6;
            color: #111827;
            text-decoration: none;
            border-radius: 0.375rem;
            transition: background-color 0.2s;
        }

        .read-article:hover {
            background: #e5e7eb;
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
                            <a href="Settings.aspx" class="dropdown-item">Settings</a>
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
                    <label for="search-term">Search Term:</label>
                    <input type="text" id="search-term">
                </div>
                <div class="filter-group">
                    <label for="sort-by">Sort By</label>
                    <select id="sort-by">
                        <option value="">Select an option</option>
                        <option value="date">Date</option>
                        <option value="popularity">Popularity</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="category">Category:</label>
                    <select id="category">
                        <option value="">Select a Category</option>
                        <option value="worldnews">World News</option>
                        <option value="localnews">Local News</option>
                        <option value="sportsnews">Sports News</option>
                    </select>
                </div>
                <asp:Button ID="Button1" runat="server" Text="Apply Filter" class="apply-filters" OnClick="Button1_Click" />
            </aside>

            <section class="articles-container">
                <h1>News Articles</h1>
                <div class="articles-grid">
                    <article class="article-card">
                        <img src="image/mountain.jpeg" alt="Mountain lake reflection" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">Discover Serenity: Top Hidden Travel Gems</h2>
                            <p class="article-category">worldnews</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
                    <article class="article-card">
                        <img src="image/Article1.jpeg?height=200&width=400" alt="Mountain valley" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">City Park Revamp Project Brings New Life</h2>
                            <p class="article-category">localnews</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
                    <article class="article-card">
                        <img src="image/Messi.jpeg?height=200&width=400" alt="Soccer player" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">Lionel Messi's Magical Hat-Trick</h2>
                            <p class="article-category">sportsnews</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
                    <article class="article-card">
                        <img src="image/Article2.jpg?height=200&width=400" alt="Aerial view of houses" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">Breakthrough Climate Agreement</h2>
                            <p class="article-category">worldnews</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
                    <article class="article-card">
                        <img src="image/sport.jpg?height=200&width=400" alt="Empty road with mountains" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">Television</h2>
                            <p class="article-category">entertainment</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
                    <article class="article-card">
                        <img src="image/sport.jpg?height=200&width=400" alt="Space shuttle launch" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">India's Chare Curasce What's Next</h2>
                            <p class="article-category">science</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
                    <article class="article-card">
                        <img src="image/sport.jpg?height=200&width=400" alt="Robot hand touching human hand" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">The Dalal AI in tha Israeli-Palestin</h2>
                            <p class="article-category">technology</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
                    <article class="article-card">
                        <img src="image/sport.jpg?height=200&width=400" alt="Industrial scene" class="article-image">
                        <div class="article-content">
                            <h2 class="article-title">Climate ChannelVar Talakwque frn</h2>
                            <p class="article-category">environment</p>
                            <a href="#" class="read-article">Read Article</a>
                        </div>
                    </article>
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

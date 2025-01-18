<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="DailyNeuzz.Home" %>

<!DOCTYPE html>
<meta name="description" content="Your trusted source for the latest headlines, in-depth analysis, and breaking news every morning.">
<meta name="viewport" content="width=device-width, initial-scale=1">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DailyNeuzz</title>
     <style>
         /* Header Styles */
header {
    position: fixed; /* Navbar ko fix karne ke liye */
    top: 0; /* Screen ke bilkul top par */
    width: 100%; /* Puri width cover kare */
    background-color: white; /* Background color fix */
    z-index: 1000; /* Navbar ko sabse upar rakhne ke liye */
    border-bottom: 1px solid #e5e7eb;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Halki shadow effect ke liye */
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 4rem;
    padding: 0 1rem; /* Padding fix */
}

body {
    padding-top: 4rem; /* Header ki height ke hisaab se adjustment */
}

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: system-ui, -apple-system, sans-serif;
            line-height: 1.5;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        /* Header Styles */
        header {
            border-bottom: 1px solid #e5e7eb;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 4rem;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
            color: #111827;
        }

        .search-bar {
            flex: 1;
            max-width: 20rem;
            margin: 0 1rem;
            position: relative;
        }

        .search-bar input {
            width: 100%;
            padding: 0.5rem 0.75rem 0.5rem 2rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
        }

        .search-icon {
            position: absolute;
            left: 0.5rem;
            top: 50%;
            transform: translateY(-50%);
            width: 1rem;
            height: 1rem;
            color: #6b7280;
        }

        nav ul {
            display: flex;
            list-style-type: none;
            gap: 1.5rem;
        }

        nav a {
            text-decoration: none;
            color: #111827;
            font-size: 0.875rem;
            font-weight: 500;
        }

        nav a:hover {
            text-decoration: underline;
        }

        /* Main Content Styles */
        main {
            flex: 1;
        }

        /* Hero Section */
        .hero {
            padding: 3rem 0 6rem;
            background-color: #f9fafb;
            text-align: center;
        }

        .hero h1 {
            font-size: 2.25rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        .hero p {
            font-size: 1.25rem;
            color: #6b7280;
            max-width: 42rem;
            margin: 0 auto 2rem;
        }

        /* Features Section */
        .features {
            padding: 4rem 0;
        }

        .features h2 {
            font-size: 1.875rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 3rem;
        }

        .features-grid {
            display: grid;
            gap: 2rem;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        }

        .card {
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 1.5rem;
            background: white;
        }

        .card-icon {
            width: 3rem;
            height: 3rem;
            margin-bottom: 1rem;
        }

        .card h3 {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .card p {
            color: #6b7280;
        }

        /* Recent Posts Section */
        .recent-posts {
            padding: 4rem 0;
            background-color: #f9fafb;
        }

        .recent-posts h2 {
            font-size: 1.875rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 3rem;
        }

        .posts-grid {
            display: grid;
            gap: 1.5rem;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        }

        .post-card {
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            background: white;
            overflow: hidden;
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
            font-size: 1.125rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .post-category {
            font-size: 0.875rem;
            color: #6b7280;
        }

        .post-footer {
            padding: 1rem 1.5rem;
            border-top: 1px solid #e5e7eb;
        }

        /* CTA Section */
        .cta {
            padding: 4rem 0;
            text-align: center;
        }

        .cta h2 {
            font-size: 1.875rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        /* Footer Styles */
        footer {
    background-color: black; /* Background color set to black */
    color: white; /* Text color set to white */
    border-top: 1px solid #e5e7eb; /* Optional: Keep the top border if needed */
    padding: 2rem 0; /* Add spacing for content */
}

.footer-content {
    display: grid;
    gap: 2rem;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}

.footer-section h3 {
    font-size: 1rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: white; /* Ensure heading text is white */
}

.footer-section p,
.footer-section address {
    font-size: 0.875rem;
    color: #d1d5db; /* Light grey text for better readability */
}

.footer-links a {
    color: #d1d5db; /* Light grey for links */
    text-decoration: none;
}

.footer-links a:hover {
    text-decoration: underline;
}

.footer-bottom {
    margin-top: 2rem;
    text-align: center;
    font-size: 0.875rem;
    color: #d1d5db; /* Light grey for footer bottom text */
}


        /* Buttons */
        .button {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .button-primary {
            background-color: #2563eb;
            color: white;
        }

        .button-primary:hover {
            background-color: #1d4ed8;
        }

        .button-secondary {
            background-color: #f3f4f6;
            color: #111827;
        }

        .button-secondary:hover {
            background-color: #e5e7eb;
        }

        .button-large {
            padding: 0.75rem 1.5rem;
            font-size: 1.125rem;
        }

        .button-full {
            display: block;
            width: 100%;
            text-align: center;
        }

        @media (min-width: 768px) {
            .hero h1 {
                font-size: 3.75rem;
            }
            .cta {
    padding: 3rem 0;
    text-align: center;
    background-color: #fffbea; /* Light yellow background */
    border-radius: 0.5rem; /* Add rounded corners */
}

.cta-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem; /* Adjust spacing between text and image */
    flex-wrap: wrap; /* Ensure responsiveness */
}

.cta-text {
    flex: 1;
    text-align: left;
    padding: 1rem;
}

.cta-text h2 {
    font-size: 2rem;
    margin-bottom: 0.5rem;
    color: #333; /* Darker text color */
}

.cta-text p {
    font-size: 1.2rem;
    color: #555; /* Slightly lighter text color */
    margin-bottom: 1rem;
}

.cta-text .button {
    display: inline-block;
    padding: 0.8rem 1.5rem;
    background-color: #0066ff; /* Blue button */
    color: white;
    text-decoration: none;
    border-radius: 0.3rem;
    font-size: 1rem;
}

.cta-image {
    flex: 1;
    text-align: right;
}

.cta-image img {
    max-width: 100%;
    height: auto;
    border-radius: 0.5rem; /* Rounded corners for the image */
}


         img {
            
             align-items: center;
             width: 150px;
             height: 150px;
         }
         /*card ka css*/
          .features-grid {
            display: flex;
            gap: 30px;
        }

        .card {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            width: 350px;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 15px;
            background-color: #fff;
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.08);
        }

        .card img {
            width: 120px;
            height: 120px;
            margin-bottom: 20px;
        }

        .card h3 {
            font-size: 22px;
            margin: 15px 0;
        }

        .card p {
            font-size: 16px;
            color: #555;
        }
        /*news photo css*/
         .cta-image {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .cta-image img {
            width: 400px;
            height: auto;
            border-radius: 10px;
        }
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
                        <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    <input type="text" placeholder="Search...">
                </div>
                <nav>
                    <ul>
                        <li><a href="/">Home</a></li>
                        <li><a href="/about">About</a></li>
                        <li><a href="/news">News Articles</a></li>
                        <li>
    <a href="SignIn.aspx">
        <img src="profile.jpg" alt="Profile" class="profile-image">
    </a>
</li>
                        
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <main>
  <section class="hero" style="text-align: left;">
    <div class="container" style="text-align: left;">
        <h1><span style="color: blue;">Welcome to</span> <span style="color: red;">DailyNeuzz</span></h1>
        <p style="text-align: left !important;">Your trusted source for the latest headlines, in-depth analysis, and breaking news every morning</p>
        <p><i>Stay informed, stay ahead!</i></p>
        <a href="/news" class="button button-primary" style="background-color: yellow; color: black;">View all posts →</a>
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
                <h2>Recent Posts</h2>
                <div class="posts-grid">
                    <article class="post-card">
                        <img src="image/Article1.jpeg?height=200&width=400" alt="Discover Serenity: Top Hidden Travel Gems">
                        <div class="post-content">
                            <h3 class="post-title">Discover Serenity: Top Hidden Travel Gems</h3>
                            <p class="post-category">worldnews</p>
                        </div>
                        <div class="post-footer">
                            <a href="/articles/1" class="button button-secondary button-full">Read Article</a>
                        </div>
                    </article>
                    <article class="post-card">
                        <img src="image/Article2.jpg?height=200&width=400" alt="City Park Revamp Project Brings New Life">
                        <div class="post-content">
                            <h3 class="post-title">City Park Revamp Project Brings New Life</h3>
                            <p class="post-category">localnews</p>
                        </div>
                        <div class="post-footer">
                            <a href="/articles/2" class="button button-secondary button-full">Read Article</a>
                        </div>
                    </article>
                    <article class="post-card">
                        <img src="image/Messi.jpeg?height=200&width=400" alt="Lionel Messi's Magical Hat-Trick">
                        <div class="post-content">
                            <h3 class="post-title">Lionel Messi's Magical Hat-Trick</h3>
                            <p class="post-category">sportsnews</p>
                        </div>
                        <div class="post-footer">
                            <a href="/articles/3" class="button button-secondary button-full">Read Article</a>
                        </div>
                    </article>
                    <article class="post-card">
                        <img src="image/mountain.jpeg?height=200&width=400" alt="Breakthrough Climate Agreement">
                        <div class="post-content">
                            <h3 class="post-title">Breakthrough Climate Agreement</h3>
                            <p class="post-category">worldnews</p>
                        </div>
                        <div class="post-footer">
                            <a href="/articles/4" class="button button-secondary button-full">Read Article</a>
                        </div>
                    </article>
                    <article class="post-card">
                    <img src="image/sport.jpg?height=200&width=400" alt="Breakthrough Climate Agreement">
                    <div class="post-content">
                        <h3 class="post-title">Sports Fiesta</h3>
                        <p class="post-category">worldnews</p>
                    </div>
                    <div class="post-footer">
                        <a href="/articles/4" class="button button-secondary button-full">Read Article</a>
                    </div>
                </article>
                    <article class="post-card">
                    <img src="image/Ai.jpg?height=200&width=400" alt="Breakthrough Climate Agreement">
                    <div class="post-content">
                        <h3 class="post-title">AI Technology</h3>
                        <p class="post-category">worldnews</p>
                    </div>
                    <div class="post-footer">
                        <a href="/articles/4" class="button button-secondary button-full">Read Article</a>
                    </div>
                </article>
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

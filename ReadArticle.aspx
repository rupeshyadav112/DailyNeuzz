<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReadArticle.aspx.cs" Inherits="DailyNeuzz.ReadArticle" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Read Article - <asp:Literal ID="ltlTitle" runat="server" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        :root {
            --blue-accent: #007BFF;
            --dark-text: #333;
            --light-grey: #F8F9FA;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: var(--dark-text);
            background-color: #fff;
        }

        /* Header Styles */
        .header {
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 1rem;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: bold;
            font-size: 1.5rem;
            text-decoration: none;
            color: var(--dark-text);
        }

        .search-container {
            flex: 1;
            max-width: 500px;
            margin: 0 2rem;
        }

        .search-box {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }

        /* Article Content */
        .article-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .article-header {
            margin-bottom: 2rem;
        }

        .article-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .article-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .author-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .author-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .article-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .article-content {
            font-family: Georgia, serif;
            font-size: 1.1rem;
            line-height: 1.8;
            color: #2c2c2c;
        }

        .article-content p {
            margin-bottom: 1.5rem;
        }

        .article-content h2 {
            font-size: 1.8rem;
            margin: 2rem 0 1rem;
        }

        /* Related Articles */
        .related-articles {
            margin: 4rem 0;
            padding-top: 2rem;
            border-top: 1px solid #eee;
        }

        .related-articles h3 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .related-articles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .related-article-card {
            text-decoration: none;
            color: inherit;
        }

        .related-article-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .related-article-title {
            font-size: 1.1rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        /* Comment Section */
        .comment-section {
            margin: 4rem 0;
            padding-top: 2rem;
            border-top: 1px solid #eee;
        }

        .comment-input {
            width: 100%;
            padding: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 1rem;
            font-family: inherit;
            resize: vertical;
        }

        .submit-btn {
            background: var(--blue-accent);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
        }

        .submit-btn:hover {
            background: #0056b3;
        }

        .comments-list {
            margin-top: 2rem;
        }

        .comment {
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .comment-author {
            font-weight: bold;
        }

        .comment-date {
            color: #666;
            font-size: 0.9rem;
        }

        /* Footer */
        .footer {
            background: var(--light-grey);
            padding: 2rem 1rem;
            margin-top: 4rem;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
        }

        .footer-section h4 {
            font-size: 1.1rem;
            margin-bottom: 1rem;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 0.5rem;
        }

        .footer-links a {
            color: var(--dark-text);
            text-decoration: none;
        }

        .footer-bottom {
            text-align: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #ddd;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                gap: 1rem;
            }

            .search-container {
                margin: 1rem 0;
                max-width: 100%;
            }

            .article-title {
                font-size: 2rem;
            }

            .article-meta {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="header">
            <div class="header-container">
                <a href="/" class="logo">
                    <img src="rocket-icon.png" alt="Logo" width="32" height="32" />
                    SpaceNews
                </a>
                <div class="search-container">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search articles..." />
                </div>
                <asp:LinkButton ID="btnProfile" runat="server" CssClass="profile-btn">
                    <img src="user-icon.png" alt="Profile" width="24" height="24" />
                </asp:LinkButton>
            </div>
        </header>

        <main class="article-container">
            <article>
                <header class="article-header">
                    <h1 class="article-title">
                        <asp:Literal ID="ltlArticleTitle" runat="server" />
                    </h1>
                    <div class="article-meta">
                        <div class="author-info">
                            <asp:Image ID="imgAuthorAvatar" runat="server" CssClass="author-avatar" />
                            <span>By <asp:Literal ID="ltlAuthorName" runat="server" /></span>
                        </div>
                        <span>Published on <asp:Literal ID="ltlPublishDate" runat="server" /></span>
                    </div>
                    <asp:Image ID="imgArticle" runat="server" CssClass="article-image" />
                </header>

                <div class="article-content">
                    <asp:Literal ID="ltlArticleContent" runat="server" />
                </div>
            </article>

            <section class="related-articles">
                <h3>Related Articles</h3>
                <asp:Repeater ID="rptRelatedArticles" runat="server">
                    <HeaderTemplate>
                        <div class="related-articles-grid">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <a href='<%# $"ReadArticle.aspx?id={Eval("ArticleId")}" %>' class="related-article-card">
                            <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Title") %>' class="related-article-image" />
                            <h4 class="related-article-title"><%# Eval("Title") %></h4>
                            <p><%# Eval("Excerpt") %></p>
                        </a>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </section>

            <section class="comment-section">
                <h3>Comments</h3>
                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="4" 
                    CssClass="comment-input" placeholder="Share your thoughts..." />
                <asp:Button ID="btnSubmitComment" runat="server" Text="Post Comment" 
                    CssClass="submit-btn" OnClick="btnSubmitComment_Click" />

                <asp:Repeater ID="rptComments" runat="server">
                    <HeaderTemplate>
                        <div class="comments-list">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="comment">
                            <div class="comment-header">
                                <span class="comment-author"><%# Eval("UserName") %></span>
                                <span class="comment-date"><%# Eval("CommentDate", "{0:MMM dd, yyyy}") %></span>
                            </div>
                            <p><%# Eval("CommentText") %></p>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </section>
        </main>

        <footer class="footer">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>About Us</h4>
                    <p>Your trusted source for space exploration news and updates.</p>
                </div>
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <ul class="footer-links">
                        <li><asp:HyperLink runat="server" NavigateUrl="~/about">About</asp:HyperLink></li>
                        <li><asp:HyperLink runat="server" NavigateUrl="~/contact">Contact</asp:HyperLink></li>
                        <li><asp:HyperLink runat="server" NavigateUrl="~/privacy">Privacy Policy</asp:HyperLink></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Follow Us</h4>
                    <ul class="footer-links">
                        <li><a href="#">Twitter</a></li>
                        <li><a href="#">Facebook</a></li>
                        <li><a href="#">LinkedIn</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 SpaceNews. All rights reserved.</p>
            </div>
        </footer>
    </form>
</body>
</html>

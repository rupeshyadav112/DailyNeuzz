<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReadArticles.aspx.cs" Inherits="DailyNeuzz.ReadArticles" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Read Articles</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
    <style>
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
        .article-container {
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .article-image {
            width: 100%;
            max-height: 500px;
            object-fit: cover;
        }
        .article-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .article-meta {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 20px;
        }
        .article-content {
            font-size: 1.1rem;
            line-height: 1.8;
            margin-bottom: 30px;
        }
        .news-section {
            background-color: #fff;
            border: 1px solid #e1e4e8;
            border-radius: 8px;
            padding: 20px;
            margin: 20px auto;
            max-width: 900px;
        }
        .news-section h2 {
            font-size: 1.5rem;
            text-align: center;
            margin-bottom: 10px;
            color: #333;
        }
        .news-section p {
            text-align: center;
            color: #666;
            margin-bottom: 15px;
            font-size: 0.9rem;
        }
        .news-section .btn-update {
            background-color: #1a73e8;
            color: white;
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-weight: 500;
            font-size: 0.9rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .news-section .btn-update:hover {
            background-color: #1557b0;
        }
        .news-content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100%;
        }
        .news-image-container {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
        }
        .news-image {
            max-width: 100%;
            height: auto;
            max-height: 200px;
            object-fit: contain;
        }
        
        /* Comment Section Styles */
        .comment-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
        }
        .signed-in-section {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 14px;
            margin-bottom: 16px;
        }
        .user-icon {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: #e1e4e8;
        }
        .comment-container {
            border: 1px solid #e1e4e8;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 24px;
            background-color: #fff;
        }
        .comment-input {
            width: 100%;
            min-height: 100px;
            border: 1px solid #e1e4e8;
            border-radius: 4px;
            padding: 12px;
            margin-bottom: 8px;
            resize: none;
            font-size: 14px;
        }
        .comment-input:focus {
            outline: none;
            border-color: #0366d6;
        }
        .comment-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }
        .char-count {
            color: #666;
            font-size: 14px;
        }
        .submit-btn {
            background-color: #24292e;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            font-size: 14px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #000;
        }
        .comments-heading {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 16px;
            color: #24292e;
        }
        .comment-list {
            margin-top: 20px;
        }
        .comment-item {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 1px solid #e1e4e8;
        }
        .comment-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #e1e4e8;
        }
        .comment-content {
            flex: 1;
        }
        .comment-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 4px;
        }
        .comment-username {
            color: #24292e;
            font-weight: 600;
            font-size: 14px;
        }
        .comment-time {
            color: #666;
            font-size: 14px;
        }
        .comment-text {
            margin: 8px 0;
            font-size: 14px;
            color: #24292e;
        }
        .like-button {
            display: flex;
            align-items: center;
            gap: 4px;
            color: #666;
            background: none;
            border: none;
            padding: 4px 8px;
            font-size: 14px;
            cursor: pointer;
            margin-top: 4px;
        }
        .like-button:hover {
            color: #0366d6;
        }
        .like-count {
            color: #666;
        }

        /* Recent Articles Updated Styles */
        .recent-articles {
            padding: 40px 0;
            background-color: #fff;
        }

        .recent-articles h3 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #333;
        }

        .articles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .article-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .article-card:hover {
            transform: translateY(-5px);
        }

        .article-image {
            width: 100%;
            height: 200px;
            overflow: hidden;
        }

        .article-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .article-info {
            padding: 20px;
        }

        .article-info h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #333;
            line-height: 1.4;
        }

        .article-category {
            font-size: 14px;
            color: #666;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .article-date {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
        }

        .read-more {
            display: block;
            background-color: #2d3748;
            color: white;
            text-align: center;
            padding: 12px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        .read-more:hover {
            background-color: #1a202c;
            color: white;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            .articles-grid {
                grid-template-columns: 1fr;
            }
            
            .article-card {
                max-width: 400px;
                margin: 0 auto;
            }
        }
        /* Recent Published Articles Styles */
        .recent-articles {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
            border: 1px solid #e1e4e8;
        }
        .recent-articles h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: #24292e;
        }
        .article-card {
            border: 1px solid #e1e4e8;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: transform 0.2s ease;
        }
        .article-card:hover {
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .article-card h4 {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }
        .article-card p {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 10px;
        }
        .article-card .meta {
            font-size: 0.8rem;
            color: #666;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .news-section {
                padding: 15px;
            }
            .news-section h2 {
                font-size: 1.2rem;
            }
            .news-image-container {
                padding: 10px;
            }
            .news-image {
                max-height: 150px;
            }
            .comment-container {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
     <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="Logout_Click" CssClass="dropdown-item">Logout</asp:LinkButton>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</header>
        <div class="container-fluid p-0">
            <div class="article-container">
                <div class="container">
                    <h1 class="article-title"><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1>
                    
                    <asp:Image ID="imgArticle" runat="server" CssClass="article-image" />
                    
                    <div class="article-meta">
                        <i class="far fa-calendar-alt"></i> <asp:Literal ID="ltlCreatedAt" runat="server"></asp:Literal>
                        &nbsp;&nbsp;
                        <i class="far fa-folder"></i> <asp:Literal ID="ltlCategory" runat="server"></asp:Literal>
                    </div>
                    
                    <div class="article-content">
                        <asp:Literal ID="ltlContent" runat="server"></asp:Literal>
                    </div>

                    <!-- News Section -->
                    <div class="news-section">
                        <!-- Your existing news section content -->
                    </div>

                    <!-- Comments Section -->
                    <div class="comment-section">
                        <div class="signed-in-section">
                            <span>Signed in as:</span>
                            <i class="fas fa-user user-icon"></i>
                            <span>@rupesh yadav</span>
                        </div>

                        <div class="comment-container">
                            <asp:TextBox ID="txtComment" runat="server" 
                                TextMode="MultiLine" 
                                CssClass="comment-input" 
                                placeholder="Add a comment"
                                onkeyup="updateCharCount(this)">
                            </asp:TextBox>
                            <div class="comment-footer">
                                <span class="char-count">
                                    <span id="charCount">200</span> characters remaining
                                </span>
                                <asp:Button ID="btnSubmit" runat="server" 
                                    Text="Submit" 
                                    CssClass="submit-btn"
                                    OnClick="btnAddComment_Click" />
                            </div>
                        </div>

                        <div class="comment-list">
                            <h3 class="comments-heading">Comments</h3>

                            <asp:Repeater ID="rptComments" runat="server" OnItemCommand="rptComments_ItemCommand">
                                <ItemTemplate>
                                    <div class="comment-item">
                                        <img src='<%# GetUserAvatar(Eval("UserID")) %>' 
                                             alt="" 
                                             class="comment-avatar" />
                                        <div class="comment-content">
                                            <div class="comment-header">
                                                <span class="comment-username">@<%# Eval("UserName") %></span>
                                                <span class="comment-time"><%# GetTimeAgo(Eval("CreatedAt")) %></span>
                                            </div>
                                            <p class="comment-text"><%# Eval("CommentText") %></p>
                                            <button type="button" class="like-button">
                                                <i class="far fa-thumbs-up"></i>
                                                <span class="like-count">1 like</span>
                                            </button>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!-- Recent Published Articles Section -->
                    <div class="recent-articles">
                        <h3>Recent Published Articles</h3>
                        <div class="articles-grid">
                            <asp:Repeater ID="rptRecentArticles" runat="server">
                                <ItemTemplate>
                                    <div class="article-card">
                                        <div class="article-image">
                                        <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("Title") %>' />                                        </div>
                                        <div class="article-info">
                                            <h4><%# Eval("Title") %></h4>
                                            <div class="article-category"><%# Eval("Category") %></div>
                                            <div class="article-date"><%# FormatDate(Eval("CreatedAt")) %></div>
                                            <a href='ReadArticles.aspx?id=<%# Eval("PostID") %>' class="read-more">Read Full Article</a>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function updateCharCount(textarea) {
            var maxLength = 200;
            var currentLength = textarea.value.length;
            var remaining = maxLength - currentLength;

            if (currentLength > maxLength) {
                textarea.value = textarea.value.substring(0, maxLength);
                remaining = 0;
            }

            document.getElementById('charCount').innerHTML = remaining;
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

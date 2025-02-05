<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReadArticles.aspx.cs" Inherits="DailyNeuzz.ReadArticles" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Read Articles</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
    <style>
/* Base styles */
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    background-color: #f9fafb;
    color: #374151;
    line-height: 1.5;
    margin: 0;
    padding-top: 73px;
}

/* Header styles - Kept exactly the same */
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

/* Main content styles */
.main-content {
    max-width: 1280px;
    margin: 2rem auto;
    padding: 0 1rem;
}

.article-container {
    background-color: white;
    border-radius: 1rem;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.article-hero {
    height: 24rem;
    overflow: hidden;
}

.article-hero-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.article-content-wrapper {
    max-width: 48rem;
    margin: 0 auto;
    padding: 3rem 1.5rem;
}

.article-title {
    font-size: 2.25rem;
    font-weight: 700;
    color: #111827;
    margin-bottom: 1.5rem;
    line-height: 1.2;
}

.article-meta {
    display: flex;
    align-items: center;
    gap: 1rem;
    color: #6b7280;
    font-size: 0.875rem;
    margin-bottom: 2rem;
}

.meta-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.article-content {
    font-size: 1.125rem;
    line-height: 1.75;
    color: #374151;
}

/* Comments section styles */
.comments-section {
    margin-top: 4rem;
    padding-top: 2rem;
    border-top: 1px solid #e5e7eb;
}

.comments-title {
    font-size: 1.5rem;
    font-weight: 600;
    color: #111827;
    margin-bottom: 2rem;
}

.comment-form {
    background-color: #f9fafb;
    border-radius: 0.75rem;
    padding: 1.5rem;
    margin-bottom: 2rem;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
    color: #4b5563;
    font-size: 0.875rem;
}

.comment-input {
    width: 100%;
    min-height: 6rem;
    padding: 0.75rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    resize: vertical;
    margin-bottom: 1rem;
}

.comment-form-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.char-counter {
    color: #6b7280;
    font-size: 0.875rem;
}

.submit-button {
    background-color: #4f46e5;
    color: white;
    padding: 0.625rem 1.25rem;
    border-radius: 0.375rem;
    border: none;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
}

.submit-button:hover {
    background-color: #4338ca;
}

/* Comments list styles */
.comments-list {
    margin-top: 2rem;
}

.comment-item {
    display: flex;
    gap: 1rem;
    padding: 1.5rem 0;
    border-bottom: 1px solid #e5e7eb;
}

.comment-avatar {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 9999px;
    overflow: hidden;
    flex-shrink: 0;
}

.comment-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.comment-content {
    flex: 1;
}

.comment-header {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 0.5rem;
}

.comment-author {
    font-weight: 600;
    color: #111827;
}

.comment-time {
    color: #6b7280;
    font-size: 0.875rem;
}

.comment-text {
    color: #374151;
    margin-bottom: 0.75rem;
}

.comment-actions {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.like-button {
    display: flex;
    align-items: center;
    gap: 0.375rem;
    color: #6b7280;
    background: none;
    border: none;
    padding: 0.25rem 0.5rem;
    font-size: 0.875rem;
    cursor: pointer;
    transition: color 0.2s;
}

.like-button:hover {
    color: #4f46e5;
}

/* Recent articles section styles */
.recent-articles {
    margin-top: 4rem;
}

.section-title {
    font-size: 1.875rem;
    font-weight: 700;
    color: #111827;
    margin-bottom: 2rem;
}

.articles-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
}

.article-card {
    background-color: white;
    border-radius: 0.75rem;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s, box-shadow 0.2s;
}

.article-card:hover {
    transform: translateY(-0.25rem);
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.card-image {
    height: 12rem;
    overflow: hidden;
}

.card-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.card-content {
    padding: 1.5rem;
}

.card-category {
    color: #6b7280;
    font-size: 0.875rem;
    font-weight: 500;
    margin-bottom: 0.75rem;
}

.card-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #111827;
    margin-bottom: 0.75rem;
    line-height: 1.4;
}

.card-meta {
    color: #6b7280;
    font-size: 0.875rem;
    margin-bottom: 1rem;
}

.read-more {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    background-color: #374151;
    color: white;
    font-size: 1rem;
    font-weight: bold;
    border-radius: 0.5rem;
    text-align: center;
    text-decoration: none;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.read-more::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.2);
    transition: all 0.4s;
}

.read-more:hover::before {
    left: 100%;
}

.read-more:hover {
    background-color: #4338ca;
    transform: translateY(-3px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}


/* Newsletter CTA styles */
.newsletter-cta {
    margin-top: 4rem;
    background: linear-gradient(to right, #4f46e5, #6366f1);
    border-radius: 1rem;
    overflow: hidden;
}

.cta-content {
    display: flex;
    align-items: center;
    padding: 3rem;
    gap: 3rem;
}

.cta-text {
    flex: 1;
    color: white;
}

.cta-text h2 {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 1rem;
}

.cta-text p {
    font-size: 1.125rem;
    margin-bottom: 2rem;
    opacity: 0.9;
}

.cta-form {
    display: flex;
    gap: 1rem;
}

.email-input {
    flex: 1;
    padding: 0.75rem 1rem;
    border: none;
    border-radius: 0.375rem;
    font-size: 1rem;
}

.subscribe-button {
    background-color: #111827;
    color: white;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 0.375rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
}

.subscribe-button:hover {
    background-color: #1f2937;
}

.cta-image {
    flex: 1;
    display: flex;
    justify-content: center;
}

.cta-image img {
    max-width: 100%;
    height: auto;
    border-radius: 0.75rem;
}

/* Responsive styles */
@media (max-width: 768px) {
    .header-content {
        grid-template-columns: auto 1fr;
    }
    
    .header-center {
        display: none;
    }
    
    .nav-links {
        display: none;
    }
    
    .article-hero {
        height: 16rem;
    }
    
    .article-title {
        font-size: 1.875rem;
    }
    
    .cta-content {
        flex-direction: column;
        padding: 2rem;
    }
    
    .cta-form {
        flex-direction: column;
    }
    
    .articles-grid {
        grid-template-columns: 1fr;
    }
}
    </style>
   <script>
       function searchArticles() {
           // Get the search input value
           const searchQuery = document.getElementById("searchInput").value.toLowerCase();

           // Get all article cards
           const articlesGrid = document.getElementById("articlesGrid");
           const articles = articlesGrid.getElementsByClassName("article-card");

           // Loop through all articles and hide those that don't match the search query
           for (let i = 0; i < articles.length; i++) {
               const article = articles[i];
               const title = article.querySelector(".card-title").innerText.toLowerCase();
               const category = article.querySelector(".card-category").innerText.toLowerCase();

               // Check if the title or category contains the search query
               if (title.includes(searchQuery) || category.includes(searchQuery)) {
                   article.style.display = "block"; // Show the article
               } else {
                   article.style.display = "none"; // Hide the article
               }
           }
       }
   </script>
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
                         <input type="text" id="searchInput" class="search-input" placeholder="Search..." onkeyup="searchArticles()" />
                        <i class="fas fa-search search-icon"></i>
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

        <!-- Main Content -->
        <main class="main-content">
            <article class="article-container">
                <div class="article-hero">
                    <asp:Image ID="imgArticle" runat="server" CssClass="article-hero-image" />
                </div>
                
                <div class="article-content-wrapper">
                    <div class="article-header">
                        <h1 class="article-title">
                            <asp:Literal ID="ltlTitle" runat="server"></asp:Literal>
                        </h1>
                        
                        <div class="article-meta">
                            <span class="meta-item">
                                <i class="far fa-calendar-alt"></i>
                                <asp:Literal ID="ltlCreatedAt" runat="server"></asp:Literal>
                            </span>
                            <span class="meta-separator">•</span>
                            <span class="meta-item">
                                <i class="far fa-folder"></i>
                                <asp:Literal ID="ltlCategory" runat="server"></asp:Literal>
                            </span>
                        </div>
                    </div>

                    <div class="article-content">
                        <asp:Literal ID="ltlContent" runat="server"></asp:Literal>
                    </div>

                    <!-- Comments Section -->
                    <div class="comments-section">
                        <h2 class="comments-title">Comments</h2>
                        
                        <div class="comment-form">
                            <div class="user-info">
                                <i class="fas fa-user"></i>
                                <span>Commenting as <asp:Literal ID="ltlCommentUser" runat="server"></asp:Literal></span>
                            </div>
                            
                            <asp:TextBox ID="txtComment" runat="server" 
                                TextMode="MultiLine" 
                                CssClass="comment-input" 
                                placeholder="Write your comment..."
                                onkeyup="updateCharCount(this)">
                            </asp:TextBox>
                            
                            <div class="comment-form-footer">
                                <span class="char-counter">
                                    <span id="charCount">200</span> characters remaining
                                </span>
                                <asp:Button ID="btnSubmit" runat="server" 
                                    Text="Post Comment" 
                                    CssClass="submit-button"
                                    OnClick="btnAddComment_Click" />
                            </div>
                        </div>

                        <div class="comments-list">
                            <asp:Repeater ID="rptComments" runat="server" OnItemCommand="rptComments_ItemCommand">
                                <ItemTemplate>
                                    <div class="comment-item">
                                        <div class="comment-avatar">
                                            <img src='<%# GetUserAvatar(Eval("UserID")) %>' alt="User avatar" />
                                        </div>
                                        <div class="comment-content">
                                            <div class="comment-header">
                                                <span class="comment-author"><%# Eval("UserName") %></span>
                                                <span class="comment-time"><%# GetTimeAgo(Eval("CreatedAt")) %></span>
                                            </div>
                                            <p class="comment-text"><%# Eval("CommentText") %></p>
                                            <div class="comment-actions">
                                                <button type="button" class="like-button">
                                                    <i class="far fa-thumbs-up"></i>
                                                    <span>Like</span>
                                                </button>
                                                <span class="likes-count"><%# Eval("LikesCount") %></span>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </article>

            <!-- Recent Articles -->
            <!-- Recent Articles Section -->
<section class="recent-articles">
    <h2 class="section-title">Recent Articles</h2>
    <div class="articles-grid" id="articlesGrid">
        <asp:Repeater ID="rptRecentArticles" runat="server">
            <ItemTemplate>
                <div class="article-card">
                    <div class="card-image">
     
                        <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("Title") %>' />
                    </div>
                    <div class="card-content">
                        <h3 class="card-title"><%# Eval("Title") %></h3>
                        <div class="card-category"><%# Eval("Category") %></div>
                        <div class="card-meta">
                            <time><%# FormatDate(Eval("CreatedAt")) %></time>
                        </div>
                        <a href='ReadArticles.aspx?id=<%# Eval("PostID") %>' class="read-more">
                            Read Full Article
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</section>

            <!-- Newsletter CTA -->
            <section class="newsletter-cta">
                <div class="cta-content">
                    <div class="cta-text">
                        <h2>Stay Updated with Daily News</h2>
                        <p>Get the latest updates and insights delivered right to your inbox.</p>
                        <div class="cta-form">
                            <input type="email" placeholder="Enter your email" class="email-input" />
                            <button type="button" class="subscribe-button">Subscribe</button>
                        </div>
                    </div>
                    <div class="cta-image">
                        <img src="https://images.unsplash.com/photo-1585829365295-ab7cd400c167?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80" 
                             alt="Newsletter illustration" />
                    </div>
                </div>
            </section>
        </main>
    </form>

    <script>
        function updateCharCount(textarea) {
            const maxLength = 200;
            const currentLength = textarea.value.length;
            const remaining = maxLength - currentLength;

            if (currentLength > maxLength) {
                textarea.value = textarea.value.substring(0, maxLength);
                remaining = 0;
            }

            document.getElementById('charCount').textContent = remaining;
        }
        function toggleReplyForm(commentId) {
            const replyForm = document.getElementById('reply-form-' + commentId);
            if (replyForm) {
                replyForm.style.display = replyForm.style.display === 'none' ? 'block' : 'none';
            }
        }

        function editComment(commentId) {
            // Get the comment text element
            const commentText = document.querySelector(`#comment-${commentId} .comment-text`);
            const originalText = commentText.textContent;

            // Create edit form
            const editForm = document.createElement('div');
            editForm.innerHTML = `
                <textarea class="edit-input">${originalText}</textarea>
                <div class="edit-actions">
                    <button type="button" onclick="saveComment(${commentId})">Save</button>
                    <button type="button" onclick="cancelEdit(${commentId}, '${originalText}')">Cancel</button>
                </div>
            `;

            // Replace comment text with edit form
            commentText.replaceWith(editForm);
        }

        function deleteComment(commentId) {
            if (confirm('Are you sure you want to delete this comment?')) {
                // Make an AJAX call to delete the comment
                // You'll need to implement the server-side handler
                fetch(`DeleteComment.aspx?commentId=${commentId}`, {
                    method: 'POST',
                    credentials: 'include'
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Remove the comment from the DOM
                            const commentElement = document.querySelector(`#comment-${commentId}`);
                            commentElement.remove();
                        } else {
                            alert('Failed to delete comment');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while deleting the comment');
                    });
            }
        }
    </script>
</body>
</html> 
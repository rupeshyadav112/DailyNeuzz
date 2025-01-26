<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReadArticles.aspx.cs" Inherits="DailyNeuzz.ReadArticles" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Read Article</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .article-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .article-title {
            font-size: 48px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .article-meta {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            color: #666;
            font-size: 14px;
        }

        .category-badge {
            background-color: #e9ecef;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 500;
        }

        .featured-image {
            width: 100%;
            max-height: 600px;
            object-fit: cover;
            border-radius: 12px;
            margin-bottom: 40px;
        }

        .article-content {
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.8;
            color: #333;
            font-size: 18px;
        }

        .interaction-section {
            max-width: 800px;
            margin: 40px auto;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-primary {
            background-color: #0d6efd;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid #dee2e6;
            color: #666;
        }

        .btn-outline:hover {
            background-color: #f8f9fa;
        }

        .comments-section {
            max-width: 800px;
            margin: 0 auto;
        }

        .comment-form {
            margin-bottom: 30px;
        }

        .comment-input {
            width: 100%;
            padding: 15px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 10px;
            font-family: inherit;
            font-size: 16px;
            resize: vertical;
        }

        .comment-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .comment {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .comment-author {
            font-weight: 600;
            color: #1a1a1a;
        }

        .comment-date {
            color: #666;
            font-size: 14px;
        }

        .comment-actions {
            margin-top: 10px;
        }

        .comment-actions a {
            color: #666;
            text-decoration: none;
            font-size: 14px;
            margin-right: 15px;
        }

        .comment-actions a:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <div class="container">
            <article class="article-header">
                <h1 class="article-title">
                    <asp:Label ID="lblTitle" runat="server"></asp:Label>
                </h1>
                <div class="article-meta">
                    <span class="category-badge">
                        <asp:Label ID="lblCategory" runat="server"></asp:Label>
                    </span>
                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                </div>
            </article>

            <asp:Image ID="imgFeatured" runat="server" CssClass="featured-image" />
            
            <div class="article-content">
                <asp:Literal ID="litContent" runat="server"></asp:Literal>
            </div>

            <div class="interaction-section">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnLike" runat="server" 
                                  Text="Like" 
                                  OnClick="btnLike_Click" 
                                  CssClass="btn btn-primary" />
                        <asp:Label ID="lblLikes" runat="server"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <asp:Button ID="btnShare" runat="server" 
                          Text="Share Article" 
                          CssClass="btn btn-outline" />
            </div>

            <div class="comments-section">
                <h2>Comments</h2>
                <asp:Panel ID="pnlAddComment" runat="server" CssClass="comment-form">
                    <asp:TextBox ID="txtComment" runat="server" 
                               TextMode="MultiLine" 
                               Rows="4" 
                               placeholder="Write a comment..."
                               CssClass="comment-input">
                    </asp:TextBox>
                    <asp:Button ID="btnComment" runat="server" 
                              Text="Post Comment" 
                              OnClick="btnComment_Click"
                              CssClass="btn btn-primary" />
                </asp:Panel>

                <div class="comment-list">
                    <asp:Repeater ID="rptComments" runat="server" OnItemCommand="rptComments_ItemCommand">
                        <ItemTemplate>
                            <div class="comment">
                                <div class="comment-header">
                                    <span class="comment-author"><%# Eval("UserName") %></span>
                                    <span class="comment-date"><%# Eval("CommentDate", "{0:dd MMM yyyy}") %></span>
                                </div>
                                <p><%# Eval("CommentText") %></p>
                                
                                <asp:Panel ID="pnlCommentActions" runat="server" 
                                         CssClass="comment-actions"
                                         Visible='<%# Convert.ToString(Eval("UserID")) == ((DailyNeuzz.ReadArticles)Page).GetCurrentUserId() %>'>
                                    <asp:LinkButton ID="btnDelete" runat="server" 
                                                  CommandName="DeleteComment" 
                                                  CommandArgument='<%# Eval("CommentID") %>'>Delete</asp:LinkButton>
                                </asp:Panel>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
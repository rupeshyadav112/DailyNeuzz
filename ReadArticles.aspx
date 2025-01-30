<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReadArticles.aspx.cs" Inherits="DailyNeuzz.ReadArticles" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Article Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
        }
        .article-container {
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .news-section {
            background-color: #fff;
            border: 1px solid #e1e4e8;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
        }
        .news-section h2 {
            font-size: 24px;
            text-align: center;
            margin-bottom: 10px;
        }
        .news-section p {
            text-align: center;
            color: #666;
            margin-bottom: 15px;
        }
        .news-section .btn-update {
            background-color: #1a73e8;
            color: white;
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-weight: 500;
        }
        .news-image {
            max-width: 300px;
            float: right;
        }
        .comment-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e1e4e8;
        }
        .signed-in-as {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .user-avatar {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            margin-right: 8px;
        }
        .comment-box {
            border: 1px solid #e1e4e8;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
        }
        .comment-input {
            width: 100%;
            min-height: 100px;
            border: 1px solid #e1e4e8;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 10px;
            resize: none;
        }
        .char-count {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .submit-btn {
            background-color: #24292e;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            float: right;
        }
        .comment-item {
            display: flex;
            margin-bottom: 20px;
        }
        .comment-content {
            margin-left: 12px;
            flex: 1;
        }
        .comment-header {
            display: flex;
            align-items: center;
            margin-bottom: 4px;
        }
        .comment-username {
            font-weight: 600;
            margin-right: 8px;
        }
        .comment-time {
            color: #666;
            font-size: 14px;
        }
        .like-button {
            color: #666;
            background: none;
            border: none;
            padding: 4px 8px;
            margin-top: 8px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <div class="container-fluid p-0">
            <div class="article-container">
                <div class="container">
                    <h1 class="article-title mb-3"><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1>
                    
                    <asp:Image ID="imgArticle" runat="server" CssClass="article-image mb-4" />
                    
                    <div class="article-meta mb-4">
                        <i class="far fa-calendar-alt"></i> <asp:Literal ID="ltlCreatedAt" runat="server"></asp:Literal>
                        &nbsp;&nbsp;
                        <i class="far fa-folder"></i> <asp:Literal ID="ltlCategory" runat="server"></asp:Literal>
                    </div>
                    
                    <div class="article-content mb-5">
                        <asp:Literal ID="ltlContent" runat="server"></asp:Literal>
                    </div>

                    <!-- News Section -->
                    <div class="news-section">
                        <div class="row">
                            <div class="col-md-8">
                                <h2>Want to know more about today'sTOP 10 news?</h2>
                                <p>Checkout these top news articles</p>
                                <button type="button" class="btn-update">Stay Updated with Daily News: Your Go-To Resources</button>
                            </div>
                            <div class="col-md-4">
                                <img src="<%= ResolveUrl("~/images/news-illustration.png") %>" alt="News Illustration" class="news-image" />
                            </div>
                        </div>
                    </div>

                    <!-- Comments Section -->
                    <div class="comment-section mt-4">
                        <div class="signed-in-as">
                            <span>Signed in as:</span>
                            <img src="<%= ResolveUrl("~/images/avatar.png") %>" alt="" class="user-avatar" />
                            <asp:Literal ID="ltlUsername" runat="server"></asp:Literal>
                        </div>

                        <asp:Panel ID="pnlAddComment" runat="server">
                            <div class="comment-box">
                                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" 
                                    CssClass="comment-input" placeholder="Add a comment"
                                    onkeyup="updateCharCount(this)"></asp:TextBox>
                                <div class="char-count">
                                    <span id="charCount">200</span> characters remaining
                                </div>
                                <asp:Button ID="btnAddComment" runat="server" Text="Submit" 
                                    CssClass="submit-btn" OnClick="btnAddComment_Click" />
                                <div class="clearfix"></div>
                            </div>
                        </asp:Panel>

                        <h3 class="mb-4">Comments</h3>
                        <asp:Repeater ID="rptComments" runat="server" OnItemCommand="rptComments_ItemCommand">
                            <ItemTemplate>
                                <div class="comment-item">
                                    <img src='<%# GetUserAvatar(Eval("UserID")) %>' alt="" class="user-avatar" />
                                    <div class="comment-content">
                                        <div class="comment-header">
                                            <span class="comment-username">@<%# Eval("UserName") %></span>
                                            <span class="comment-time"><%# GetTimeAgo(Eval("CreatedAt")) %></span>
                                        </div>
                                        <p><%# Eval("CommentText") %></p>
                                        <button type="button" class="like-button">
                                            <i class="far fa-thumbs-up"></i> Like
                                        </button>
                                        
                                        <asp:Panel ID="pnlEdit" runat="server" Visible='<%# IsCommentAuthor(Eval("UserID")) %>'>
                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" 
                                                CommandName="Edit" CommandArgument='<%# Eval("CommentID") %>'
                                                CssClass="btn btn-sm btn-link" />
                                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" 
                                                CommandName="Delete" CommandArgument='<%# Eval("CommentID") %>'
                                                CssClass="btn btn-sm btn-link text-danger" 
                                                OnClientClick="return confirm('Are you sure you want to delete this comment?');" />
                                        </asp:Panel>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
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
            document.getElementById('charCount').innerHTML = remaining;
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Publish.aspx.cs" Inherits="DailyNeuzz.Publish" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <link rel="stylesheet" href="Publish.css">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <header>
        <div class="header-content">
            <h1>DailyNeuzz</h1>
            
            <div class="header-right">
                <div class="search-box">
                    <input type="text" placeholder="Search..">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="search-icon">
                        <circle cx="11" cy="11" r="8"></circle>
                        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                    </svg>
                </div>
                
                <nav>
                    <a href="#">Home</a>
                    <a href="#">About</a>
                    <a href="#">News Articles</a>
                </nav>
                
                <div class="profile-image">
                    <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=50&h=50&fit=crop" alt="Profile" class="avatar">
                </div>
            </div>
        </div>
    </header>

    <main class="create-post-container">
        <h2>Create a post</h2>
        
        <form class="post-form">
            <div class="form-group">
                <input type="text" placeholder="Title" class="title-input">
            </div>

            <div class="form-row">
                <div class="file-upload">
                    <input type="file" id="file-input" class="file-input">
                    <label for="file-input" class="file-label">Choose File</label>
                    <span class="file-name">No file chosen</span>
                </div>
                <button type="button" class="upload-btn">Upload Image</button>
            </div>

            <div class="editor-toolbar">
                <select class="format-select">
                    <option>Normal</option>
                    <option>Heading 1</option>
                    <option>Heading 2</option>
                </select>
                <button type="button" class="toolbar-btn bold">B</button>
                <button type="button" class="toolbar-btn italic">I</button>
                <button type="button" class="toolbar-btn underline">U</button>
                <button type="button" class="toolbar-btn link">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path>
                        <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path>
                    </svg>
                </button>
                <button type="button" class="toolbar-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 10H3M21 6H3M21 14H3M21 18H3"/>
                    </svg>
                </button>
                <button type="button" class="toolbar-btn">✱</button>
            </div>

            <textarea placeholder="Write something here..." class="content-editor"></textarea>

            <button type="submit" class="publish-btn">Publish Your Article</button>
        </form>
    </main>
    </form>
</body>
</html>

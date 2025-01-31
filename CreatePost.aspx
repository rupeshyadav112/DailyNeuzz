<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreatePost.aspx.cs" Inherits="CreatePost" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Post - DailyNeuzz</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
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
    </style>
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
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
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="Logout_Click" CssClass="dropdown-item">Logout</asp:LinkButton>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</header>

        <!-- Main Content with proper spacing for fixed navbar -->
        <div class="container mx-auto px-4 pt-24 pb-8">
            <!-- Create Post Form -->
            <div class="max-w-3xl mx-auto">
                <h1 class="text-2xl font-semibold text-center mb-8">Create a post</h1>
                
                <div class="space-y-6">
                    <!-- Title Input -->
                    <div>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Title" />
                    </div>

                    <!-- Category Dropdown -->
                    <div>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="w-64 px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <asp:ListItem Text="Select a Category" Value="" />
                            <asp:ListItem Text="Technology" Value="technology" />
                            <asp:ListItem Text="Sports" Value="sports" />
                            <asp:ListItem Text="Entertainment" Value="entertainment" />
                        </asp:DropDownList>
                    </div>

                    <!-- Image Upload -->
                    <div class="flex items-center space-x-4">
                        <asp:FileUpload ID="fileUpload" runat="server" CssClass="hidden" />
                        <asp:TextBox ID="txtFileName" runat="server" CssClass="flex-grow px-4 py-2 border rounded-lg bg-gray-50" ReadOnly="true" Text="Choose File No file chosen" />
                        <asp:Button ID="btnUpload" runat="server" Text="Upload Image" CssClass="px-4 py-2 bg-gray-800 text-white rounded-lg hover:bg-gray-700" OnClientClick="document.getElementById('fileUpload').click(); return false;" />
                    </div>

                    <!-- Rich Text Editor -->
                    <div class="border rounded-lg">
                        <div class="border-b p-2 flex items-center space-x-4">
                            <asp:DropDownList ID="ddlFontStyle" runat="server" CssClass="px-3 py-1 border rounded">
                                <asp:ListItem Text="Normal" Value="normal" />
                                <asp:ListItem Text="Heading 1" Value="h1" />
                                <asp:ListItem Text="Heading 2" Value="h2" />
                            </asp:DropDownList>
                            <asp:LinkButton runat="server" CssClass="p-1 hover:bg-gray-100 rounded"><i class="fas fa-bold"></i></asp:LinkButton>
                            <asp:LinkButton runat="server" CssClass="p-1 hover:bg-gray-100 rounded"><i class="fas fa-italic"></i></asp:LinkButton>
                            <asp:LinkButton runat="server" CssClass="p-1 hover:bg-gray-100 rounded"><i class="fas fa-underline"></i></asp:LinkButton>
                            <asp:LinkButton runat="server" CssClass="p-1 hover:bg-gray-100 rounded"><i class="fas fa-link"></i></asp:LinkButton>
                            <asp:LinkButton runat="server" CssClass="p-1 hover:bg-gray-100 rounded"><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                            <asp:LinkButton runat="server" CssClass="p-1 hover:bg-gray-100 rounded"><i class="fas fa-star"></i></asp:LinkButton>
                        </div>
                        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="10" 
                            CssClass="w-full p-4 focus:outline-none" placeholder="Write something here.." />
                    </div>

                    <!-- Submit Button -->
                    <asp:Button ID="btnPublish" runat="server" Text="Publish Your Article" OnClick="btnPublish_Click"
                        CssClass="w-full py-3 bg-green-500 text-white rounded-lg hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2" />
                </div>
            </div>
        </div>
    </form>

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

    <script type="text/javascript">
        document.getElementById('fileUpload').onchange = function () {
            var fileName = this.value.split('\\').pop();
            document.getElementById('txtFileName').value = fileName || 'Choose File No file chosen';
        };

        function toggleMobileMenu() {
            var menu = document.getElementById('mobileMenu');
            menu.classList.toggle('hidden');
        }
    </script>
</body>
</html>
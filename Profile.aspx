<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="DailyNeuzz.Profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile - DailyNeuzz</title>
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
/*        header {
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

        .profile-icon img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-icon svg {
            width: 24px;
            height: 24px;
            color: rgb(156, 163, 175);
        }*/

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


        /* Search box styles */
        .search-box {
            position: relative;
        }

        .search-input {
            padding: 0.5rem 2.5rem 0.5rem 1rem;
            border-radius: 0.5rem;
            border: none;
            background-color: rgb(243, 244, 246);
            width: 250px;
        }

        .search-icon {
            position: absolute;
            right: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: rgb(156, 163, 175);
        }

        /* Main layout */
        .main-container {
            display: flex;
            min-height: calc(100vh - 73px);
        }

        /* Sidebar styles */
        .sidebar {
            width: 256px;
            background-color: white;
            border-right: 1px solid rgb(229, 231, 235);
            position: fixed;
            top: 73px;
            bottom: 0;
            padding: 1.5rem;
        }

        .sidebar-menu {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
            border-radius: 0.5rem;
            color: rgb(75, 85, 99);
            text-decoration: none;
            transition: all 0.2s;
        }

        .sidebar-link:hover, .sidebar-link.active {
            background-color: rgb(243, 244, 246);
            color: rgb(31, 41, 55);
        }

        .sidebar-link svg {
            width: 20px;
            height: 20px;
        }

        /* Main content */
        .main-content {
            flex: 1;
            margin-left: 256px;
            padding: 2rem;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .profile-container {
            background-color: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        /* Message panel styles */
        .message-panel {
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 8px;
            display: none;
        }

        .success-message {
            background-color: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .error-message {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        /* Profile form styles */
        .profile-upload {
            width: 150px;
            height: 150px;
            margin: 0 auto 2rem;
            position: relative;
            cursor: pointer;
            border-radius: 50%;
            overflow: hidden;
            background-color: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #e5e7eb;
        }

        .profile-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #9ca3af;
        }

        .upload-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.2s;
        }

        .profile-upload:hover .upload-overlay {
            opacity: 1;
        }

        .upload-icon {
            color: white;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #374151;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            font-size: 1rem;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
        }

        .right-actions {
            display: flex;
            gap: 1rem;
        }

        .update-btn {
            background-color: #3b82f6;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .update-btn:hover {
            background-color: #2563eb;
        }

        .delete-btn {
            background-color: #ef4444;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .delete-btn:hover {
            background-color: #dc2626;
        }

        .signout-btn {
            background-color: #9ca3af;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .signout-btn:hover {
            background-color: #6b7280;
        }

        #fileUpload {
            display: none;
        }
    </style>
</head>
<body>
   <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        
        <!-- हेडर -->
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
                         <asp:Image ID="Image1" runat="server" CssClass="profile-image" Visible="false" />
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

        <!-- मुख्य कंटेनर -->
        <div class="main-container">
            <!-- साइडबार -->
            <aside class="sidebar">
                <nav class="sidebar-menu">
                    <a href="Profile.aspx" class="sidebar-link active">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        Profile
                    </a>
                    <asp:LinkButton ID="lnkLogout" runat="server" OnClick="btnSignOut_Click" CssClass="sidebar-link">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                            <polyline points="16 17 21 12 16 7"></polyline>
                            <line x1="21" y1="12" x2="9" y2="12"></line>
                        </svg>
                        Logout
                    </asp:LinkButton>
                </nav>
            </aside>

            <!-- मुख्य कंटेंट -->
            <main class="main-content">
                <div class="container">
                    <div class="profile-container">
                        <h2>Update Your Profile</h2>

                        <!-- संदेश पैनल -->
                        <div id="messagePanel" runat="server" class="message-panel" style="display: none;">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </div>
                        
                        <!-- प्रोफाइल इमेज अपलोड -->
                        <div class="profile-upload" onclick="document.getElementById('fileUpload').click();">
                            <asp:Image ID="imgProfile" runat="server" CssClass="profile-image" Visible="false" />
                            <div id="profilePlaceholder" runat="server" class="profile-placeholder" visible="true">
                                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </div>
                            <div class="upload-overlay">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="upload-icon">
                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                    <polyline points="17 8 12 3 7 8"></polyline>
                                    <line x1="12" y1="3" x2="12" y2="15"></line>
                                </svg>
                            </div>
                        </div>

                        <asp:FileUpload ID="fileUpload" runat="server" ClientIDMode="Static" onchange="handleFileSelect(this);" />
                        
                        <!-- अपलोड बटन (ऑटो-ट्रिगर) -->
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" Style="display: none;" />
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <!-- प्रोफाइल फॉर्म -->
                        <div class="form-group">
                            <label for="txtFullName">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtEmail">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">New Password (Optional)</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                        <!-- एक्शन बटन -->
                        <div class="form-actions">
                            <asp:Button ID="btnDelete" runat="server" Text="Delete Account" CssClass="delete-btn" OnClick="btnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete your account? This action cannot be undone.');" />
                            <div class="right-actions">
                                <asp:LinkButton ID="btnSignOut" runat="server" Text="Sign Out" CssClass="signout-btn" OnClick="btnSignOut_Click">Sign Out</asp:LinkButton>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="update-btn" OnClick="btnUpdate_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- इमेज प्रीव्यू स्क्रिप्ट -->
        <script type="text/javascript">
            function handleFileSelect(fileUpload) {
                if (fileUpload.files && fileUpload.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var imgProfile = document.getElementById('<%= imgProfile.ClientID %>');
                        var placeholder = document.getElementById('<%= profilePlaceholder.ClientID %>');
                        imgProfile.src = e.target.result;
                        imgProfile.style.display = 'block';
                        placeholder.style.display = 'none';
                        document.getElementById('<%= btnUpload.ClientID %>').click();
                    };
                    reader.readAsDataURL(fileUpload.files[0]);
                }
            }
        </script>
    </form>
</body>
</html>
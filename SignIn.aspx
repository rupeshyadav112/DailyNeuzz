<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="DailyNeuzz.SignIn" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title></title>
   
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            min-height: 100vh;
            padding-top: 70px;
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

        /* Container Styles */
        .signup-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            min-height: calc(100vh - 200px);
            box-sizing: border-box;
        }

        .signup-box {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 700px;
            margin: 2rem auto;
            transform: translateX(45px);
            box-sizing: border-box;
        }

        /* Header Styles */
        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .signup-box h1 {
            color: #333;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .signup-box h2 {
            color: #333;
            font-size: 1.25rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            color: #666;
            font-size: 0.875rem;
        }

        .signup-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            flex: 1;
            min-width: 250px;
            box-sizing: border-box;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.875rem;
            background-color: white;
            box-sizing: border-box;
        }

        .form-group input::placeholder {
            color: #999;
        }

        /* Button Group: Center Alignment */
        .button-group {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.75rem;
            max-width: 400px;
            margin: 0 auto;
        }

        /* Buttons */
        .signup-btn {
            width: 100%;
            padding: 0.75rem;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 0.875rem;
            cursor: pointer;
            font-weight: 500;
            margin-top: 20px;
        }

        .google-btn {
            width: 100%;
            padding: 0.75rem;
            background-color: #32CD32;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.875rem;
            cursor: pointer;
            font-weight: 500;
        }

        /* Login Link */
        .login-link {
            text-align: center;
            color: #666;
            font-size: 0.875rem;
        }

        .login-link a {
            color: #1a73e8;
            text-decoration: none;
            font-weight: 500;
        }

        /* Form focus states */
        .form-group input:focus {
            outline: none;
            border-color: #1a73e8;
            box-shadow: 0 0 0 1px #1a73e8;
        }

        /* Button hover states */
        .signup-btn:hover {
            background-color: #1557b0;
        }

        .google-btn:hover {
            background-color: #90EE90;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .signup-container .form-header h1 {
            color: #333333;
        }

        /*footer */
        footer {
            background-color: #1f2937;
            color: white;
            padding: 2rem 0;
        }

        .footer-container {
            display: flex;
            justify-content: space-between;
            padding: 0 2rem;
            max-width: 1200px;
            margin: 0 auto;
            flex-wrap: wrap;
        }

        .footer-left, .footer-middle, .footer-right {
            flex: 1;
            min-width: 200px;
        }

        .footer-left h3, .footer-middle h3, .footer-right h3 {
            color: #fff;
            font-size: 1.25rem;
            margin-bottom: 1rem;
        }

        .footer-left p, .footer-middle ul, .footer-right ul {
            color: #9ca3af;
            font-size: 0.875rem;
        }

        .footer-middle ul, .footer-right ul {
            list-style-type: none;
            padding: 0;
        }

        .footer-middle ul li, .footer-right ul li {
            margin-bottom: 0.5rem;
        }

        .footer-middle ul li a, .footer-right ul li a {
            color: #9ca3af;
            text-decoration: none;
        }

        .footer-middle ul li a:hover, .footer-right ul li a:hover {
            color: white;
        }

        .footer-bottom {
            background-color: #111827;
            color: #9ca3af;
            text-align: center;
            padding: 1rem;
        }

        .footer-bottom p {
            margin: 0;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .footer-container {
                flex-direction: column;
                align-items: center;
            }

            .footer-left, .footer-middle, .footer-right {
                margin-bottom: 1rem;
                text-align: center;
            }
        }
    </style>
</head>
<body>
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
                         <asp:LinkButton ID="lnkLogout" runat="server" OnClick="Logout_Click" CssClass="dropdown-item">Logout</asp:LinkButton>
                     </div>
                 </div>
             <% } %>
         </div>
     </div>
 </header>

        <main class="signup-container">
            <div class="form-header">
                <h1>DailyNeuzz</h1><br />
                <h2>Sign In</h2>
                <p class="subtitle">Welcome to Morning Greetings, Please provide your details</p>
            </div>
            
            <div class="signup-box">
                <div class="signup-form">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@example.com" />
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password" />
                        <asp:Label ID="lblError" runat="server" CssClass="error-label" ForeColor="Red"></asp:Label>
                    </div>
                    <div class="button-group">
                        <asp:Button ID="btnSignIn" runat="server" CssClass="signup-btn" Text="Sign In" OnClick="btnSignIn_Click" />
                        <button type="button" class="google-btn">Continue with Google</button>
                        <p class="login-link">Don't have an account? <a href="SignUp.aspx">Sign Up</a></p>
                    </div>
                </div>
            </div>
        </main>

        <footer>
            <div class="footer-container">
                <div class="footer-left">
                    <h3>About us</h3>
                    <p>Stay updated with the latest news and articles. Your go-to platform for daily insights.</p>
                </div>
                <div class="footer-middle">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="#">Home</a></li>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">News Articles</a></li>
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
            <div class="footer-bottom">
                <p> 2025 DailyNeuzz. All Rights Reserved.</p>
            </div>
        </footer>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="DailyNeuzz.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up - DailyNeuzz</title>
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

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 4rem;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            height: 70px;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
        }

        .search-bar input {
            padding: 0.75rem 1.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 400px;
            background-color: #f5f5f5;
            font-size: 1rem;
        }

        .nav-links {
            display: flex;
            gap: 3rem;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #666;
            font-size: 1.1rem;
            transition: color 0.2s;
        }

        .nav-links a:hover {
            color: #333;
        }

        .sign-in {
            background-color: #000;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1.1rem;
            transition: background-color 0.2s;
        }

        .sign-in:hover {
            background-color: #89CFF0;
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
        <nav class="navbar">
            <div class="logo">DailyNeuzz</div>
            <div class="search-bar">
                <input type="search" placeholder="Search">
            </div>
            <div class="nav-links">
                <a href="Home.aspx">Home</a>
                <a href="#">About</a>
                <a href="#">News Articles</a>
                <a href="SignIn.aspx" class="sign-in">Sign In</a>
            </div>
        </nav>

        <main class="signup-container">
            <div class="form-header">
                <h1>DailyNeuzz</h1><br />
                <h2>Create a new account</h2>
                <p class="subtitle">Welcome to Morning Greetings, Please provide your details</p>
            </div>
            
            <div class="signup-box">
                <div class="signup-form">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a username" />
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                            ErrorMessage="Username is required" Display="Dynamic" ForeColor="Red" />
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@example.com" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                            ErrorMessage="Email is required" Display="Dynamic" ForeColor="Red" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Invalid email format" Display="Dynamic" ForeColor="Red"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Create a password" />
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                            ErrorMessage="Password is required" Display="Dynamic" ForeColor="Red" />
                    </div>
                    <div class="button-group">
                        <asp:Label ID="lblError" runat="server" CssClass="error-label" ForeColor="Red"></asp:Label>
                        <asp:Button ID="btnSignUp" runat="server" CssClass="signup-btn" Text="Sign Up" OnClick="btnSignUp_Click" />
                        <button type="button" class="google-btn">Continue with Google</button>
                        <p class="login-link">Already have an account? <a href="SignIn.aspx">Sign In</a></p>
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

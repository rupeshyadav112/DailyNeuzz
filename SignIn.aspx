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
    background-color: #333;
}

/* Container Styles */
.signup-container {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 2rem;
    min-height: calc(100vh - 200px);
    box-sizing: border-box; /* सुनिश्चित करें कि padding शामिल हो */
}

/* Signup Box Styles */
.signup-box {
    background-color: white;
    padding: 2rem 3rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 1000px;
    margin-top: 2rem;
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

/* Form Styles */
.signup-form {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

/* Form Row: Ensure Proper Space */
.form-row {
    display: flex;
    gap: 2rem;
    flex-wrap: wrap; /* Wrap आइटम्स को रोकने के लिए */
    justify-content: space-between;
}

.form-group {
    flex: 1; /* सभी फील्ड को समान स्थान */
    min-width: 250px; /* न्यूनतम चौड़ाई तय करें */
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
}

.google-btn {
    width: 100%;
    padding: 0.75rem;
    background-color: #fff;
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

/* Responsive Styles */
@media (max-width: 768px) {
    .form-row {
        flex-direction: column; /* छोटे स्क्रीन पर वर्टिकल करें */
        gap: 1rem;
    }

    .signup-box {
        padding: 1.5rem;
    }
}


footer {
    background-color: #1f2937;
    color: white;
    padding: 4rem;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 4rem;
    max-width: 1440px;
    margin: 0 auto;
}

.footer-section h3 {
    margin-bottom: 1.5rem;
    font-size: 1.3rem;
}

.footer-section a {
    display: block;
    color: #9ca3af;
    text-decoration: none;
    margin-bottom: 0.75rem;
    font-size: 1.1rem;
    transition: color 0.2s;
}

.footer-section a:hover {
    color: #fff;
}

.footer-section p {
    color: #9ca3af;
    margin-bottom: 0.75rem;
    font-size: 1.1rem;
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
    background-color: #f8f9fa;
}

.login-link a:hover {
    text-decoration: underline;
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
            <a href="#">Home</a>
            <a href="#">About</a>
            <a href="#">News Articles</a>
            <button class="sign-in">Sign In</button>
        </div>
    </nav>
         
        <main class="signup-container">
        <div class="form-header">
            <h1>DailyNeuzz</h1>
            <h2>Create a new account</h2>
            <p class="subtitle">Welcome to Morning Greetings, Please provide your details</p>
        </div>
        <div class="signup-box">
            <form class="signup-form">
                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" placeholder="Username">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" placeholder="name@example.com">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" placeholder="Password">
                    </div>
                </div>
                <div class="button-group">
                    <button type="submit" class="signup-btn">Sign Up</button>
                    <button type="button" class="google-btn">Continue with Google</button>
                    <p class="login-link">Have an account? <a href="#">Sign In</a></p>
                </div>
            </form>
        </div>
    </main>
    

    <footer>
        <div class="footer-section">
            <h3>About Us</h3>
            <p>We are committed to delivering the best services and experiences. Our mission is to provide value while being the best platform.</p>
        </div>
        <div class="footer-section">
            <h3>Quick Links</h3>
            <a href="#">Home</a>
            <a href="#">About Us</a>
        </div>
        <div class="footer-section">
            <h3>Contact Us</h3>
            <p>2234 Street Name, City Country</p>
            <p>Phone: +1234 5678 900</p>
        </div>
    </footer>
    </form>
</body>
</html>

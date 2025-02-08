<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YourArticles.aspx.cs" Inherits="DailyNeuzz.YourArticles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
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
  /* Sidebar Styles */
 .sidebar {
     position: fixed;
     left: 0;
     top: 70px;
     bottom: 0;
     width: 250px;
     background-color: #B0C4DE;
     padding: 2rem 1rem;
 }

 .sidebar-menu {
     list-style: none;
 }

 .sidebar-menu li {
     margin-bottom: 1rem;
 }

 .sidebar-menu a {
     text-decoration: none;
     color: #666;
     display: flex;
     align-items: center;
     gap: 0.5rem;
     padding: 0.5rem;
     border-radius: 5px;
 }

 .sidebar-menu a:hover {
     background-color: #e9ecef;
 }
  /* Main content area styles */

.max-w-7xl {

    margin-left: 270px; /* Adjusted to account for sidebar width */

    padding: 20px;

}



/* Table styles */

.min-w-full {

    width: 100%;

    border-collapse: collapse;

    background: white;

    border-radius: 8px;

    box-shadow: 0 1px 3px rgba(0,0,0,0.1);

}



.min-w-full th {

    background: #f8f9fa;

    padding: 12px;

    text-align: left;

    font-weight: 500;

    color: #6b7280;

    border-bottom: 1px solid #e5e7eb;

}



.min-w-full td {

    padding: 12px;

    border-bottom: 1px solid #e5e7eb;

}



/* Date column */

.date-column {

    color: #6b7280;

    font-size: 0.875rem;

}



/* Category styles */

.category-tag {

    display: inline-block;

    padding: 4px 8px;

    border-radius: 4px;

    font-size: 0.875rem;

    background: #f3f4f6;

    color: #374151;

}



/* Action buttons */

.action-button {

    padding: 4px 8px;

    border-radius: 4px;

    font-size: 0.875rem;

    text-decoration: none;

    margin-right: 8px;

}



.delete-btn {

    color: red;

}



.edit-btn {

    color: green;

}



/* Post image styles */

.post-image {

    width: 60px;

    height: 45px;

    object-fit: cover;

    border-radius: 4px;

}



/* Post title wrapper */

.post-title-wrapper {

    display: flex;

    align-items: center;

    gap: 15px;

}



.post-title {

    font-weight: 500;

    color: #111827;

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
         <!-- Sidebar -->
 <div class="sidebar">
     <ul class="sidebar-menu">
         <li><asp:LinkButton ID="lnkDashboard" runat="server" OnClick="lnkDashboard_Click"><i class="fas fa-home"></i> Dashboard</asp:LinkButton></li>
         <li><asp:LinkButton ID="lnkProfile" runat="server" OnClick="lnkProfile_Click"><i class="fas fa-user"></i> Profile</asp:LinkButton></li>
         <li><asp:LinkButton ID="lnkCreatePost" runat="server" OnClick="lnkCreatePost_Click"><i class="fas fa-plus"></i> Create Post</asp:LinkButton></li>
         <li><asp:LinkButton ID="lnkArticles" runat="server" OnClick="lnkArticles_Click"><i class="fas fa-newspaper"></i> Your Articles</asp:LinkButton></li>
         <li><asp:LinkButton ID="lnkUsers" runat="server" OnClick="lnkUsers_Click"><i class="fas fa-users"></i> All Users</asp:LinkButton></li>
         <li><asp:LinkButton ID="lnkComments" runat="server" OnClick="lnkComments_Click"><i class="fas fa-comments"></i> All Comments</asp:LinkButton></li>
     </ul>
 </div>

  <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
            <div class="px-4 py-6 sm:px-0">
                <div class="overflow-x-auto">
                  <asp:GridView ID="gvPosts" runat="server" 
    CssClass="min-w-full divide-y divide-gray-200"
    AutoGenerateColumns="false"
    OnRowCommand="gvPosts_RowCommand"
    HeaderStyle-CssClass="bg-gray-50"
    RowStyle-CssClass="bg-white divide-y divide-gray-200">
    <Columns>
        <asp:BoundField DataField="CreatedAt" HeaderText="Date updated" 
            DataFormatString="{0:dd/MM/yyyy}"
            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
            HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" />
        
        <asp:TemplateField HeaderText="Post image"
            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap"
            HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
            <ItemTemplate>
                <asp:Image ID="imgPost" runat="server" 
                    ImageUrl='<%# Eval("ImagePath") %>'
                    CssClass="post-image"
                    Visible='<%# !string.IsNullOrEmpty(Eval("ImagePath").ToString()) %>'/>
            </ItemTemplate>
        </asp:TemplateField>
        
        <asp:TemplateField HeaderText="Post title"
            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-900"
            HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
            <ItemTemplate>
                <div class="post-title-wrapper">
                    <span><%# Eval("Title") %></span>
                </div>
            </ItemTemplate>
        </asp:TemplateField>
        
        <asp:BoundField DataField="Category" HeaderText="Category"
            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
            HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" />
        
        <asp:TemplateField HeaderText="Actions"
            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
            HeaderStyle-CssClass="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
            <ItemTemplate>
                <asp:LinkButton ID="btnDelete" runat="server"
                    CommandName="DeletePost"
                    CommandArgument='<%# Eval("PostID") %>'
                    CssClass="text-red-600 hover:text-red-900 mr-4"
                    OnClientClick="return confirm('Are you sure you want to delete this post?');">
                    Delete
                </asp:LinkButton>
                <asp:LinkButton ID="btnEdit" runat="server"
                    CommandName="EditPost"
                    CommandArgument='<%# Eval("PostID") %>'
                    CssClass="text-green-600 hover:text-green-900">
                    Edit
                </asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView> 
                </div>
            </div>
        </div>    

    </form>
</body>
</html>


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreatePost.aspx.cs" Inherits="CreatePost" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Post - DailyNeuzz</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
        <!-- Fixed Navigation Bar -->
        <nav class="bg-white shadow-lg fixed top-0 left-0 right-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-16">
                    <!-- Logo and Brand -->
                    <div class="flex items-center">
                        <div class="flex-shrink-0 flex items-center">
                            <span class="text-2xl font-bold text-gray-800">DailyNeuzz</span>
                        </div>
                    </div>

                    <!-- Navigation Links - Center -->
                    <div class="hidden md:flex items-center justify-center flex-1 px-8">
                        <div class="relative w-96">
                            <asp:TextBox ID="txtSearch" runat="server" 
                                CssClass="w-full px-4 py-2 rounded-lg bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500 border-gray-300" 
                                placeholder="Search articles..." />
                            <button class="absolute right-3 top-2.5">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                </svg>
                            </button>
                        </div>
                    </div>

                    <!-- Right Navigation Items -->
                    <div class="hidden md:flex items-center space-x-8">
                        <asp:HyperLink runat="server" NavigateUrl="~/Home" 
                            CssClass="text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium">
                            Home
                        </asp:HyperLink>
                        <asp:HyperLink runat="server" NavigateUrl="~/About" 
                            CssClass="text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium">
                            About
                        </asp:HyperLink>
                        <asp:HyperLink runat="server" NavigateUrl="~/NewsArticles" 
                            CssClass="text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium">
                            News Articles
                        </asp:HyperLink>
                        <!-- Profile Image -->
                        <div class="flex items-center">
                            <button type="button" class="bg-purple-600 rounded-full h-8 w-8 overflow-hidden focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500">
                                <img src="https://via.placeholder.com/32" alt="Profile" class="h-full w-full object-cover" />
                            </button>
                        </div>
                    </div>

                    <!-- Mobile menu button -->
                    <div class="flex items-center md:hidden">
                        <button type="button" onclick="toggleMobileMenu()" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500">
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Mobile menu -->
            <div class="hidden md:hidden" id="mobileMenu">
                <div class="px-2 pt-2 pb-3 space-y-1">
                    <asp:HyperLink runat="server" NavigateUrl="~/Home" 
                        CssClass="block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-gray-900 hover:bg-gray-50">
                        Home
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/About" 
                        CssClass="block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-gray-900 hover:bg-gray-50">
                        About
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/NewsArticles" 
                        CssClass="block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-gray-900 hover:bg-gray-50">
                        News Articles
                    </asp:HyperLink>
                </div>
            </div>
        </nav>

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
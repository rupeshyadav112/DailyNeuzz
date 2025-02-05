using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;

namespace DailyNeuzz
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (Session["UserID"] != null)
            {
                // User is already logged in, redirect to the return URL if available
                if (!string.IsNullOrEmpty(Request.QueryString["returnUrl"]))
                {
                    string returnUrl = HttpUtility.UrlDecode(Request.QueryString["returnUrl"]);
                    Response.Redirect(returnUrl);
                }
            }
        }

        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/SignIn.aspx");
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            // 1. Check hardcoded credentials
            if (email == "ryadav943@rku.ac.in" && password == "Admin")
            {
                Session["UserEmail"] = email;
                Session["UserId"] = 1; // Hardcoded user ID
                Session["UserName"] = "Hardcoded User";
                Response.Redirect("Dashboard.aspx");
                return;
            }

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter email and password";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = @"SELECT UserID, Username, FullName, Password, ProfileImagePath 
                     FROM Users WHERE Email = @Email"; // ProfileImagePath कॉलम जोड़ें

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedHash = reader["Password"].ToString();
                                string inputHash = HashPassword(password);

                                if (storedHash == inputHash)
                                {
                                    // Session Management
                                    Session["UserID"] = reader["UserID"];
                                    Session["UserEmail"] = email;
                                    Session["Username"] = reader["Username"];
                                    Session["FullName"] = reader["FullName"];


                                    // ProfileImagePath को Session में सेट करें
                                    Session["UserProfileImage"] = reader["ProfileImagePath"]?.ToString();

                                    // Authentication Cookie
                                    FormsAuthentication.SetAuthCookie(email, false);

                                    Response.Redirect("~/Home.aspx");
                                }
                                else
                                {
                                    lblError.Text = "Invalid credentials";
                                }
                            }
                            else
                            {
                                lblError.Text = "User not found";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Secure error handling
                lblError.Text = "Login failed. Please try again.";
                System.Diagnostics.Debug.WriteLine($"Login Error: {ex}");
            }
        }
    }
}
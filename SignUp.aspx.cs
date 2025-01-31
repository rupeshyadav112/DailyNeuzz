using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace DailyNeuzz
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Add HTML5 validation
                txtUsername.Attributes.Add("pattern", ".{3,20}");
                txtUsername.Attributes.Add("title", "Username must be 3-20 characters");
                txtEmail.Attributes.Add("type", "email");
                txtPassword.Attributes.Add("pattern", ".{8,}");
                txtPassword.Attributes.Add("title", "Password must be at least 8 characters");
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

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (ValidateUserInput())
            {
                try
                {
                    string username = txtUsername.Text.Trim();
                    string email = txtEmail.Text.Trim();
                    string password = HashPassword(txtPassword.Text);

                    using (SqlConnection conn = new SqlConnection(
                        ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                    {
                        string checkQuery = @"SELECT COUNT(*) FROM Users 
                                           WHERE Username = @Username OR Email = @Email";

                        string insertQuery = @"INSERT INTO Users 
                            (Username, Email, Password, FullName) 
                            VALUES (@Username, @Email, @Password, @FullName)";

                        // Check for existing user
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                        {
                            checkCmd.Parameters.AddWithValue("@Username", username);
                            checkCmd.Parameters.AddWithValue("@Email", email);

                            conn.Open();
                            int exists = (int)checkCmd.ExecuteScalar();

                            if (exists > 0)
                            {
                                ShowError("Username or email already exists");
                                return;
                            }
                        }

                        // Insert new user
                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                        {
                            insertCmd.Parameters.AddWithValue("@Username", username);
                            insertCmd.Parameters.AddWithValue("@Email", email);
                            insertCmd.Parameters.AddWithValue("@Password", password);
                            insertCmd.Parameters.AddWithValue("@FullName", username);

                            insertCmd.ExecuteNonQuery();
                        }
                    }

                    ShowSuccess("Registration successful! Redirecting to login...");
                    Response.Redirect("SignIn.aspx");
                }
                catch (Exception ex)
                {
                    ShowError("Registration failed. Please try again.");
                    System.Diagnostics.Debug.WriteLine($"Registration Error: {ex}");
                }
            }
        }

        private bool ValidateUserInput()
        {
            // Username validation
            if (!Regex.IsMatch(txtUsername.Text, @"^[a-zA-Z0-9]{3,20}$"))
            {
                ShowError("Invalid username (3-20 alphanumeric characters)");
                return false;
            }

            // Email validation
            if (!Regex.IsMatch(txtEmail.Text,
                @"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"))
            {
                ShowError("Invalid email format");
                return false;
            }

            // Password validation
            if (!Regex.IsMatch(txtPassword.Text,
                @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"))
            {
                ShowError("Password must contain:\n- 8+ characters\n- Uppercase\n- Lowercase\n- Number");
                return false;
            }

            return true;
        }

        private void ShowError(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(),
                "ErrorAlert", $"alert('{message}');", true);
        }

        private void ShowSuccess(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(),
                "SuccessAlert", $"alert('{message}');", true);
        }
    }
}
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace DailyNeuzz
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Add client-side validation
                txtUsername.Attributes.Add("required", "required");
                txtEmail.Attributes.Add("required", "required");
                txtPassword.Attributes.Add("required", "required");
                
                // Add custom validation using JavaScript
                string script = @"
                    function validateForm() {
                        var username = document.getElementById('" + txtUsername.ClientID + @"').value;
                        var email = document.getElementById('" + txtEmail.ClientID + @"').value;
                        var password = document.getElementById('" + txtPassword.ClientID + @"').value;
                        var isValid = true;

                        // Username validation
                        if (username.length < 3 || username.length > 20) {
                            alert('Username must be between 3 and 20 characters.');
                            isValid = false;
                        }

                        // Email validation
                        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!emailRegex.test(email)) {
                            alert('Please enter a valid email address.');
                            isValid = false;
                        }

                        // Password validation
                        if (password.length < 8) {
                            alert('Password must be at least 8 characters long.');
                            isValid = false;
                        }

                        return isValid;
                    }";

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ValidationScript", script, true);
                btnSignUp.Attributes.Add("onclick", "return validateForm();");
            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (ValidateInput())
            {
                try
                {
                    // Get data from the form
                    string username = txtUsername.Text;
                    string email = txtEmail.Text;
                    string password = txtPassword.Text;

                    // Store in the database
                    string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                    string query = "INSERT INTO Users (Username, Email, Password, FullName) VALUES (@Username, @Email, @Password, @FullName)";

                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password); // Ensure password is securely hashed in production
                        cmd.Parameters.AddWithValue("@FullName", username); // Set username as initial FullName

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }

                    // Show alert message after registration
                    string script = "alert('Registration Successful!'); window.location='SignIn.aspx';";
                    ClientScript.RegisterStartupScript(this.GetType(), "Success", script, true);
                }
                catch (Exception ex)
                {
                    // Handle errors here
                    string errorScript = "alert('Error: " + ex.Message + "');";
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", errorScript, true);
                }
            }
        }

        private bool ValidateInput()
        {
            bool isValid = true;

            // Username validation
            if (string.IsNullOrEmpty(txtUsername.Text) || txtUsername.Text.Length < 3 || txtUsername.Text.Length > 20)
            {
                isValid = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "UsernameError",
                    "alert('Username must be between 3 and 20 characters.');", true);
            }

            // Email validation
            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (string.IsNullOrEmpty(txtEmail.Text) || !Regex.IsMatch(txtEmail.Text, emailPattern))
            {
                isValid = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "EmailError",
                    "alert('Please enter a valid email address.');", true);
            }

            // Password validation
            if (string.IsNullOrEmpty(txtPassword.Text) || txtPassword.Text.Length < 8)
            {
                isValid = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "PasswordError",
                    "alert('Password must be at least 8 characters long.');", true);
            }

            return isValid;
        }
    }
}

using System;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace DailyNeuzz
{
    public partial class Profile : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // यूजर ऑथेंटिकेशन चेक करें
            if (!User.Identity.IsAuthenticated)
            {
                //Response.Redirect("~/SignIn.aspx");
                //return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
                // Check if user is logged in
                if (Session["UserEmail"] != null)
                {
                    litUserEmail.Text = Session["UserEmail"].ToString();
                    // ProfileImagePath से इमेज URL लें
                    string profileImagePath = Session["UserProfileImage"]?.ToString();
                    imgProfile.ImageUrl = ResolveUrl(!string.IsNullOrEmpty(profileImagePath)
                                                     ? profileImagePath
                                                     : "image/Avatar.png");
                }
            }
        }

        // प्रोफाइल डेटा लोड करें
        private void LoadUserProfile()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT FullName, Email, ProfileImagePath 
                               FROM Users 
                               WHERE Username = @Username";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", User.Identity.Name);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFullName.Text = reader["FullName"].ToString();
                            txtEmail.Text = reader["Email"].ToString();

                            // प्रोफाइल इमेज सेट करें
                            if (reader["ProfileImagePath"] != DBNull.Value)
                            {
                                string imagePath = reader["ProfileImagePath"].ToString();
                                imgProfile.ImageUrl = ResolveUrl(imagePath);
                                imgProfile.Visible = true;
                                profilePlaceholder.Visible = false;

                                // हेडर इमेज अपडेट करें
                                //headerProfileImg.ImageUrl = ResolveUrl(imagePath);
                                //headerProfileImg.Visible = true;
                                headerProfilePlaceholder.Visible = false;
                            }
                        }
                    }
                }
            }
        }

        // पासवर्ड हैशिंग
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        // प्रोफाइल अपडेट
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (ValidateProfile())
            {
                string query = @"UPDATE Users 
                               SET FullName = @FullName, 
                                   Email = @Email, 
                                   Password = COALESCE(@Password, Password) 
                               WHERE Username = @Username";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", User.Identity.Name);
                        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                        // पासवर्ड अपडेट (ऑप्शनल)
                        if (!string.IsNullOrEmpty(txtPassword.Text))
                        {
                            cmd.Parameters.AddWithValue("@Password", HashPassword(txtPassword.Text));
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@Password", DBNull.Value);
                        }

                        try
                        {
                            conn.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                ShowMessage("Profile updated successfully!", true);
                            }
                            else
                            {
                                ShowMessage("No changes were made.", false);
                            }
                        }
                        catch (Exception ex)
                        {
                            ShowMessage("Error: " + ex.Message, false);
                        }
                    }
                }
            }
        }

        // इमेज अपलोड
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                try
                {
                    // फ़ाइल साइज़ चेक (max 5MB)
                    if (fileUpload.PostedFile.ContentLength > 5 * 1024 * 1024)
                    {
                        ShowMessage("File size must be less than 5MB", false);
                        return;
                    }

                    // एक्सटेंशन चेक
                    string ext = Path.GetExtension(fileUpload.FileName).ToLower();
                    if (ext != ".jpg" && ext != ".png" && ext != ".jpeg")
                    {
                        ShowMessage("Only JPG/PNG files allowed", false);
                        return;
                    }

                    // अपलोड डायरेक्टरी
                    string uploadDir = Server.MapPath("~/Uploads/ProfileImages/");
                    Directory.CreateDirectory(uploadDir);

                    // फ़ाइल सेव करें
                    string fileName = Guid.NewGuid() + ext;
                    string filePath = Path.Combine(uploadDir, fileName);
                    fileUpload.SaveAs(filePath);

                    // डेटाबेस अपडेट
                    string relativePath = "~/Uploads/ProfileImages/" + fileName;
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "UPDATE Users SET ProfileImagePath = @Path WHERE Username = @Username";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Path", relativePath);
                            cmd.Parameters.AddWithValue("@Username", User.Identity.Name);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // UI अपडेट
                    imgProfile.ImageUrl = ResolveUrl(relativePath);
                    imgProfile.Visible = true;
                    profilePlaceholder.Visible = false;
                    //headerProfileImg.ImageUrl = ResolveUrl(relativePath);
                    //headerProfileImg.Visible = true;
                    headerProfilePlaceholder.Visible = false;

                    ShowMessage("Profile image updated!", true);
                }
                catch (Exception ex)
                {
                    ShowMessage("Error uploading image: " + ex.Message, false);
                }
            }
            else
            {
                ShowMessage("Please select a file to upload.", false);
            }
        }

        // प्रोफाइल वैलिडेशन
        private bool ValidateProfile()
        {
            if (string.IsNullOrEmpty(txtFullName.Text) || string.IsNullOrEmpty(txtEmail.Text))
            {
                ShowMessage("Full Name and Email are required.", false);
                return false;
            }

            if (!Regex.IsMatch(txtEmail.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ShowMessage("Invalid email format.", false);
                return false;
            }

            return true;
        }

        // संदेश दिखाएँ
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            messagePanel.Attributes["class"] = $"message-panel {(isSuccess ? "success-message" : "error-message")}";
            ClientScript.RegisterStartupScript(GetType(), "showMessage",
                @"document.getElementById('messagePanel').style.display = 'block';
                setTimeout(function() { 
                    document.getElementById('messagePanel').style.display = 'none'; 
                }, 3000);", true);
        }

        // लॉगआउट
        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Response.Redirect("~/SignIn.aspx");
        }
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Home.aspx");
        }

        // अकाउंट डिलीट
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Users WHERE Username = @Username";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", User.Identity.Name);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    btnSignOut_Click(sender, e);
                }
            }
        }
    }
}
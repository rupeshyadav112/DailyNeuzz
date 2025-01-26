using System;
using System.IO;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace DailyNeuzz
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize message panel
                var messagePanel = FindControl("messagePanel") as WebControl;
                if (messagePanel != null)
                {
                    messagePanel.Visible = true;
                    messagePanel.Attributes["style"] = "display: none;";
                }
                
                LoadProfileData();
            }
        }

        private int GetCurrentUserId()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Home.aspx");
                return 0;
            }
            return Convert.ToInt32(Session["UserId"]);
        }

        private void LoadProfileData()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Home.aspx");
                return;
            }

            int userId = GetCurrentUserId();

            // First set the values from session
            if (Session["FullName"] != null)
            {
                txtFullName.Text = Session["FullName"].ToString();
            }
            if (Session["UserEmail"] != null)
            {
                txtEmail.Text = Session["UserEmail"].ToString();
            }

            // Then get profile image from database
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT ProfileImagePath FROM Users WHERE UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string imagePath = reader["ProfileImagePath"].ToString();
                            if (!string.IsNullOrEmpty(imagePath))
                            {
                                // Set main profile image
                                imgProfile.ImageUrl = "~/Uploads/ProfileImages/" + imagePath;
                                imgProfile.Visible = true;
                                profilePlaceholder.Visible = false;

                                // Set header profile image
                                headerProfileImg.ImageUrl = "~/Uploads/ProfileImages/" + imagePath;
                                headerProfileImg.Visible = true;
                                headerProfilePlaceholder.Visible = false;
                            }
                        }
                    }
                }
            }
        }

        private bool ValidateProfileUpdate()
        {
            string email = txtEmail.Text.Trim();
            string fullName = txtFullName.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(fullName))
            {
                ShowMessage("Email and Full Name are required.", false);
                return false;
            }

            // Validate email format
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ShowMessage("Please enter a valid email address.", false);
                return false;
            }

            return true;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidateProfileUpdate())
                {
                    return;
                }

                int userId = GetCurrentUserId();
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(
                        @"UPDATE Users 
                          SET FullName = @FullName, 
                              Email = @Email
                          WHERE UserId = @UserId", conn))
                    {
                        cmd.Parameters.AddWithValue("@FullName", fullName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        cmd.ExecuteNonQuery();
                    }

                    // Update password if provided
                    if (!string.IsNullOrEmpty(txtPassword.Text))
                    {
                        using (SqlCommand cmd = new SqlCommand(
                            "UPDATE Users SET Password = @Password WHERE UserId = @UserId", conn))
                        {
                            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                // Update session values
                Session["FullName"] = fullName;
                Session["UserEmail"] = email;

                ShowMessage("Profile updated successfully!");
            }
            catch (Exception ex)
            {
                ShowMessage("Failed to update profile: " + ex.Message, false);
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(fileUpload.FileName);
                    string extension = Path.GetExtension(fileName);

                    // Validate file type
                    if (!extension.Equals(".jpg", StringComparison.OrdinalIgnoreCase) &&
                        !extension.Equals(".jpeg", StringComparison.OrdinalIgnoreCase) &&
                        !extension.Equals(".png", StringComparison.OrdinalIgnoreCase))
                    {
                        ShowMessage("Only .jpg, .jpeg, and .png files are allowed.", false);
                        return;
                    }

                    // Validate file size (5MB)
                    if (fileUpload.FileBytes.Length > 5 * 1024 * 1024)
                    {
                        ShowMessage("File size should be less than 5MB.", false);
                        return;
                    }

                    string uniqueFileName = Guid.NewGuid().ToString() + extension;
                    string uploadPath = Server.MapPath("~/Uploads/ProfileImages/");

                    // Create directory if it doesn't exist
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }

                    // Delete old profile image
                    DeleteOldProfileImage(GetCurrentUserId());

                    // Save new image
                    fileUpload.SaveAs(Path.Combine(uploadPath, uniqueFileName));

                    // Update database
                    UpdateProfileImage(uniqueFileName);

                    // Update UI for main profile image
                    imgProfile.ImageUrl = "~/Uploads/ProfileImages/" + uniqueFileName;
                    imgProfile.Visible = true;
                    profilePlaceholder.Visible = false;

                    // Update UI for header profile image
                    headerProfileImg.ImageUrl = "~/Uploads/ProfileImages/" + uniqueFileName;
                    headerProfileImg.Visible = true;
                    headerProfilePlaceholder.Visible = false;

                    ShowMessage("Profile image updated successfully!");
                }
                catch (Exception ex)
                {
                    ShowMessage("Failed to upload image: " + ex.Message, false);
                }
            }
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Home.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = GetCurrentUserId();

                // Delete profile image first
                DeleteOldProfileImage(userId);

                // Delete user from database
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM Users WHERE UserId = @UserId", conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.ExecuteNonQuery();
                    }
                }

                // Clear session and redirect
                Session.Clear();
                Response.Redirect("Home.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("Failed to delete account: " + ex.Message, false);
            }
        }

        private void DeleteOldProfileImage(int userId)
        {
            string oldImagePath = string.Empty;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT ProfileImagePath FROM Users WHERE UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        oldImagePath = result.ToString();
                    }
                }
            }

            if (!string.IsNullOrEmpty(oldImagePath))
            {
                string fullPath = Server.MapPath("~/Uploads/ProfileImages/" + oldImagePath);
                if (File.Exists(fullPath))
                {
                    File.Delete(fullPath);
                }
            }
        }

        private void UpdateProfileImage(string fileName)
        {
            int userId = GetCurrentUserId();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE Users SET ProfileImagePath = @ImagePath WHERE UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@ImagePath", fileName);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess = true)
        {
            var messagePanel = FindControl("messagePanel") as WebControl;
            var lblMessage = FindControl("lblMessage") as Label;
            
            if (messagePanel != null && lblMessage != null)
            {
                messagePanel.Attributes["class"] = "message-panel " + (isSuccess ? "success-message" : "error-message");
                lblMessage.Text = message;
                
                ScriptManager.RegisterStartupScript(this, GetType(), "showMessage",
                    @"var panel = document.getElementById('messagePanel');
                      if(panel) {
                          panel.style.display = 'block';
                          setTimeout(function() { 
                              panel.style.display = 'none';
                          }, 3000);
                      }", true);
            }
        }
    }
}
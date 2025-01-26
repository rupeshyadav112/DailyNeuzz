using System;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class CreatePost : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategories();
        }

        // Add OnClick event handler for the Publish button
        btnPublish.Click += new EventHandler(btnPublish_Click);
    }

    private void LoadCategories()
    {
        ddlCategory.Items.Clear();
        ddlCategory.Items.Add(new ListItem("Select a Category", ""));
        ddlCategory.Items.Add(new ListItem("Technology", "technology"));
        ddlCategory.Items.Add(new ListItem("Sports", "sports"));
        ddlCategory.Items.Add(new ListItem("Entertainment", "entertainment"));
    }

    protected void btnPublish_Click(object sender, EventArgs e)
    {
        try
        {
            // Validate inputs
            if (string.IsNullOrEmpty(txtTitle.Text.Trim()))
            {
                ShowAlert("Please enter a title");
                return;
            }

            if (string.IsNullOrEmpty(txtContent.Text.Trim()))
            {
                ShowAlert("Please enter content");
                return;
            }

            if (string.IsNullOrEmpty(ddlCategory.SelectedValue))
            {
                ShowAlert("Please select a category");
                return;
            }

            // Get form data
            string title = txtTitle.Text.Trim();
            string content = txtContent.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string fontStyle = ddlFontStyle.SelectedValue;
            string imagePath = SaveUploadedFile();

            // Save to database
            SaveToDatabase(title, content, category, imagePath, fontStyle);

            // Clear form and show success message
            ClearForm();
            ShowAlert("Post published successfully!");
        }
        catch (Exception ex)
        {
            ShowAlert("Error: " + ex.Message);
        }
    }

    private string SaveUploadedFile()
    {
        if (!fileUpload.HasFile)
            return string.Empty;

        try
        {
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
            string fileExtension = Path.GetExtension(fileUpload.FileName).ToLower();

            if (!allowedExtensions.Contains(fileExtension))
            {
                throw new Exception("Only image files (.jpg, .jpeg, .png, .gif) are allowed");
            }

            string uploadFolder = Server.MapPath("~/Uploads");
            if (!Directory.Exists(uploadFolder))
            {
                Directory.CreateDirectory(uploadFolder);
            }

            string uniqueFileName = Guid.NewGuid().ToString() + fileExtension;
            string filePath = Path.Combine(uploadFolder, uniqueFileName);
            
            fileUpload.SaveAs(filePath);
            return "~/Uploads/" + uniqueFileName;
        }
        catch (Exception)
        {
            throw new Exception("Error uploading file. Please try again.");
        }
    }

    private void SaveToDatabase(string title, string content, string category, string imagePath, string fontStyle)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = @"INSERT INTO Posts (Title, Content, Category, ImagePath, FontStyle, CreatedAt) 
                           VALUES (@Title, @Content, @Category, @ImagePath, @FontStyle, @CreatedAt)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Content", content);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                cmd.Parameters.AddWithValue("@FontStyle", fontStyle);
                cmd.Parameters.AddWithValue("@CreatedAt", DateTime.Now);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }

    private void ShowAlert(string message)
    {
        string script = $"alert('{message.Replace("'", "\\'")}');";
        ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
    }

    private void ClearForm()
    {
        txtTitle.Text = string.Empty;
        txtContent.Text = string.Empty;
        ddlCategory.SelectedIndex = 0;
        ddlFontStyle.SelectedIndex = 0;
        txtFileName.Text = "Choose File No file chosen";
    }
}
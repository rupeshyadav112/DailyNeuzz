using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace DailyNeuzz
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRecentPosts();

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

        private void LoadRecentPosts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = @"SELECT TOP 5 PostID, Title, Content, Category, ImagePath, FontStyle, CreatedAt 
                                      FROM Posts 
                                      WHERE PostID IS NOT NULL
                                      ORDER BY CreatedAt DESC";

                    try
                    {
                        conn.Open();
                        rptRecentPosts.DataSource = cmd.ExecuteReader();
                        rptRecentPosts.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Log the error appropriately
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
            }
        }


        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Home.aspx");
        }

    }
}
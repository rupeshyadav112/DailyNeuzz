using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DailyNeuzz
{
    public partial class YourArticles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPosts();
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

        private void LoadPosts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT PostID, Title, Content, Category, ImagePath, CreatedAt FROM Posts ORDER BY CreatedAt DESC", conn))
                {
                    try
                    {
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvPosts.DataSource = dt;
                        gvPosts.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Log the error and show user-friendly message
                        Response.Write("An error occurred while loading posts: " + ex.Message);
                    }
                }
            }
        }

        protected void gvPosts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int postId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeletePost")
            {
                DeletePost(postId);
            }
            else if (e.CommandName == "EditPost")
            {
                Response.Redirect($"EditPost.aspx?id={postId}");
            }
        }

        private void DeletePost(int postId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Posts WHERE PostID = @PostID", conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        LoadPosts(); // Refresh the grid
                    }
                    catch (Exception ex)
                    {
                        // Log the error and show user-friendly message
                        Response.Write("An error occurred while deleting the post: " + ex.Message);
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

        protected void lnkDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        protected void lnkProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void lnkCreatePost_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreatePost.aspx");
        }

        protected void lnkArticles_Click(object sender, EventArgs e)
        {
            Response.Redirect("YourArticles.aspx");
        }

        protected void lnkUsers_Click(object sender, EventArgs e)
        {
            Response.Redirect("AllUsers.aspx");
        }

        protected void lnkComments_Click(object sender, EventArgs e)
        {
            Response.Redirect("AllComments.aspx");
        }
    }
}


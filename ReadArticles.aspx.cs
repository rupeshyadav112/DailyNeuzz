using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web;

namespace DailyNeuzz
{
    public partial class ReadArticles : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        private int postId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckUserSession();
                HandlePostRequest();
            }
        }

        private void CheckUserSession()
        {
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

        private void HandlePostRequest()
        {
            if (int.TryParse(Request.QueryString["id"], out postId))
            {
                LoadPost();
                LoadComments();
                LoadRecentArticles();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        private void LoadPost()
        {
            string query = "SELECT * FROM Posts WHERE PostID = @PostID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@PostID", postId);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        ltlTitle.Text = reader["Title"].ToString();
                        ltlContent.Text = reader["Content"].ToString();
                        ltlCategory.Text = reader["Category"].ToString();
                        ltlCreatedAt.Text = Convert.ToDateTime(reader["CreatedAt"]).ToString("MMMM dd, yyyy");
                        imgArticle.ImageUrl = reader["ImagePath"].ToString();
                    }
                    else
                    {
                        Response.Redirect("~/Home.aspx");
                    }
                }
            }
        }

        private void LoadComments()
        {
            string query = @"
                SELECT c.*, u.Username 
                FROM Comments c 
                INNER JOIN Users u ON c.UserID = u.UserID 
                WHERE c.PostID = @PostID 
                ORDER BY c.CreatedAt DESC";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@PostID", postId);

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptComments.DataSource = dt;
                    rptComments.DataBind();
                }
            }
        }

        private void LoadRecentArticles()
        {
            string query = @"
                SELECT TOP 5 PostID, Title, Content, Category, ImagePath, CreatedAt 
                FROM Posts 
                WHERE PostID != @CurrentPostID 
                ORDER BY CreatedAt DESC";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@CurrentPostID", postId);

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptRecentArticles.DataSource = dt;
                    rptRecentArticles.DataBind();
                }
            }
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/SignIn.aspx");
                return;
            }

            string comment = txtComment.Text.Trim();

            if (!string.IsNullOrEmpty(comment))
            {
                int userId = GetCurrentUserId();

                string query = @"
                    INSERT INTO Comments (PostID, UserID, CommentText, CreatedAt)
                    VALUES (@PostID, @UserID, @CommentText, GETDATE())";

                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@CommentText", comment);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                txtComment.Text = string.Empty;
                LoadComments();
            }
        }

        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/SignIn.aspx");
                return;
            }

            int commentId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                DeleteComment(commentId);
                LoadComments();
            }
        }

        private void DeleteComment(int commentId)
        {
            int userId = GetCurrentUserId();

            string query = "DELETE FROM Comments WHERE CommentID = @CommentID AND UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@CommentID", commentId);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private int GetCurrentUserId()
        {
            // Replace this with your actual authentication user ID logic
            return 1;
        }

        protected string GetUserAvatar(object userId)
        {
            return ResolveUrl("~/images/default-avatar.png");
        }

        protected string GetTimeAgo(object dateObj)
        {
            DateTime commentDate = Convert.ToDateTime(dateObj);
            TimeSpan timePassed = DateTime.Now - commentDate;

            if (timePassed.TotalDays >= 1)
                return $"{(int)timePassed.TotalDays} days ago";
            else if (timePassed.TotalHours >= 1)
                return $"{(int)timePassed.TotalHours} hours ago";
            else if (timePassed.TotalMinutes >= 1)
                return $"{(int)timePassed.TotalMinutes} minutes ago";
            else
                return "just now";
        }

        protected string FormatDate(object date)
        {
            return date != null ? Convert.ToDateTime(date).ToString("dd MMM yyyy") : string.Empty;
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Home.aspx");
        }
    }
}

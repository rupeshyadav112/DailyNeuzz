using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

namespace DailyNeuzz
{
    public partial class ReadArticles : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager
           .ConnectionStrings["DefaultConnection"].ConnectionString;
        private int postId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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
        }

        private void LoadPost()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Posts WHERE PostID = @PostID", conn))
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
                            Response.Redirect("~/Default.aspx");
                        }
                    }
                }
            }
        }

        private void LoadComments()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT c.*, u.Username 
                    FROM Comments c 
                    INNER JOIN Users u ON c.UserID = u.UserID 
                    WHERE c.PostID = @PostID 
                    ORDER BY c.CreatedAt DESC", conn))
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
        }

        private void LoadRecentArticles()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT TOP 5 PostID, Title, Content, Category, ImagePath, CreatedAt 
                    FROM Posts 
                    WHERE PostID IS NOT NULL AND PostID != @CurrentPostID
                    ORDER BY CreatedAt DESC", conn))
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
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int userId = GetCurrentUserId();
            string comment = txtComment.Text.Trim();

            if (!string.IsNullOrEmpty(comment))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(@"
                        INSERT INTO Comments (PostID, UserID, CommentText, CreatedAt)
                        VALUES (@PostID, @UserID, @CommentText, GETDATE())", conn))
                    {
                        cmd.Parameters.AddWithValue("@PostID", postId);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@CommentText", comment);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                txtComment.Text = string.Empty;
                LoadComments();
            }
        }

        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int commentId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "Delete":
                    DeleteComment(commentId);
                    break;
                case "Edit":
                    // Implement edit functionality if needed
                    break;
            }

            LoadComments();
        }

        private void DeleteComment(int commentId)
        {
            int userId = GetCurrentUserId();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    DELETE FROM Comments 
                    WHERE CommentID = @CommentID AND UserID = @UserID", conn))
                {
                    cmd.Parameters.AddWithValue("@CommentID", commentId);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected string GetUserAvatar(object userId)
        {
            // Implement this method to return the user's avatar URL
            return ResolveUrl("~/images/default-avatar.png");
        }

        protected string GetTimeAgo(object dateObj)
        {
            DateTime commentDate = Convert.ToDateTime(dateObj);
            TimeSpan timePassed = DateTime.Now - commentDate;

            if (timePassed.TotalDays >= 1)
            {
                int days = (int)timePassed.TotalDays;
                return $"{days} days ago";
            }
            else if (timePassed.TotalHours >= 1)
            {
                int hours = (int)timePassed.TotalHours;
                return $"{hours} hours ago";
            }
            else if (timePassed.TotalMinutes >= 1)
            {
                int minutes = (int)timePassed.TotalMinutes;
                return $"{minutes} minutes ago";
            }
            else
            {
                return "just now";
            }
        }

        private int GetCurrentUserId()
        {
            // Implement this method to return the current user's ID based on your authentication system
            return 1; // Replace with actual implementation
        }

        protected string FormatDate(object date)
        {
            if (date == null) return string.Empty;
            return Convert.ToDateTime(date).ToString("dd MMM yyyy");
        }
    }
}
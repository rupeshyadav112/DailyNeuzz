using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DailyNeuzz
{
    public partial class ReadArticles : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected int currentPostId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out currentPostId))
                {
                    LoadArticle(currentPostId);
                    LoadComments(currentPostId);
                    LoadRecentArticles();
                }

                // Check if user is logged in
                if (Session["UserID"] != null)
                {
                    string username = GetUsername(Convert.ToInt32(Session["UserID"]));
                    ltlCommentUser.Text = username;
                    btnSubmit.Enabled = true;
                }
                else
                {
                    ltlCommentUser.Text = "Please sign in to comment";
                    btnSubmit.Enabled = false;
                    txtComment.Enabled = false;
                    txtComment.Text = "Please sign in to leave a comment";
                }
            }
        }

        private string GetUsername(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Username FROM Users WHERE UserID = @UserID", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    return cmd.ExecuteScalar()?.ToString() ?? "Unknown User";
                }
            }
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("SignIn.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            int postId = Convert.ToInt32(Request.QueryString["id"]);
            int userId = Convert.ToInt32(Session["UserID"]);
            string commentText = txtComment.Text.Trim();

            if (string.IsNullOrEmpty(commentText))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please enter a comment.');", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Comments (PostID, UserID, CommentText, CreatedAt) 
                               VALUES (@PostID, @UserID, @CommentText, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@CommentText", commentText);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            txtComment.Text = string.Empty;
            LoadComments(postId);
        }

        private void LoadComments(int postId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT c.*, u.Username, 
                               (SELECT COUNT(*) FROM CommentLikes WHERE CommentID = c.CommentID) as LikesCount 
                               FROM Comments c 
                               INNER JOIN Users u ON c.UserID = u.UserID 
                               WHERE c.PostID = @PostID 
                               ORDER BY c.CreatedAt DESC";

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
        }

        protected string GetTimeAgo(object createdAt)
        {
            DateTime postTime = Convert.ToDateTime(createdAt);
            TimeSpan timePassed = DateTime.Now - postTime;

            if (timePassed.TotalMinutes < 1)
                return "Just now";
            if (timePassed.TotalHours < 1)
                return $"{(int)timePassed.TotalMinutes}m ago";
            if (timePassed.TotalDays < 1)
                return $"{(int)timePassed.TotalHours}h ago";
            if (timePassed.TotalDays < 7)
                return $"{(int)timePassed.TotalDays}d ago";

            return postTime.ToString("MMM dd, yyyy");
        }

        protected string GetUserAvatar(object userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ProfileImagePath FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    string imagePath = cmd.ExecuteScalar()?.ToString();
                    return !string.IsNullOrEmpty(imagePath) ? imagePath : "~/images/default-avatar.png";
                }
            }
        }

        protected void LikeComment(object sender, CommandEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("SignIn.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            int commentId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"IF NOT EXISTS (SELECT 1 FROM CommentLikes WHERE CommentID = @CommentID AND UserID = @UserID)
                               BEGIN
                                   INSERT INTO CommentLikes (CommentID, UserID) VALUES (@CommentID, @UserID)
                               END
                               ELSE
                               BEGIN
                                   DELETE FROM CommentLikes WHERE CommentID = @CommentID AND UserID = @UserID
                               END";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CommentID", commentId);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadComments(currentPostId);
        }

        protected string FormatDate(object date)
        {
            return Convert.ToDateTime(date).ToString("MMM dd, yyyy");
        }

        protected DataTable GetCommentReplies(object commentId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT r.*, u.Username 
                                FROM CommentReplies r 
                                INNER JOIN Users u ON r.UserID = u.UserID 
                                WHERE r.CommentID = @CommentID 
                                ORDER BY r.CreatedAt ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CommentID", commentId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        protected bool IsCommentLikedByUser(object commentId)
        {
            if (Session["UserID"] == null) return false;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(1) FROM CommentLikes WHERE CommentID = @CommentID AND UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CommentID", commentId);
                    cmd.Parameters.AddWithValue("@UserID", Convert.ToInt32(Session["UserID"]));
                    conn.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }
         protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Home.aspx");
        }

        private void LoadArticle(int postId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Posts WHERE PostID = @PostID";
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
                            ltlCreatedAt.Text = FormatDate(reader["CreatedAt"]);

                            string imagePath = reader["ImagePath"].ToString();
                            if (!string.IsNullOrEmpty(imagePath))
                            {
                                imgArticle.ImageUrl = ResolveUrl(imagePath);
                            }
                        }
                    }
                }
            }
        }

        private void LoadRecentArticles()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP 3 * FROM Posts 
                                WHERE PostID != @CurrentPostID 
                                ORDER BY CreatedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CurrentPostID", currentPostId);
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

        // Add this method to handle the Repeater's ItemCommand event
        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "LikeComment")
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("SignIn.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                    return;
                }

                int commentId = Convert.ToInt32(e.CommandArgument);
                int userId = Convert.ToInt32(Session["UserID"]);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"IF NOT EXISTS (SELECT 1 FROM CommentLikes 
                                    WHERE CommentID = @CommentID AND UserID = @UserID)
                                   BEGIN
                                       INSERT INTO CommentLikes (CommentID, UserID) 
                                       VALUES (@CommentID, @UserID)
                                   END
                                   ELSE
                                   BEGIN
                                       DELETE FROM CommentLikes 
                                       WHERE CommentID = @CommentID AND UserID = @UserID
                                   END";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CommentID", commentId);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Reload comments to reflect the changes
                LoadComments(currentPostId);
            }
            else if (e.CommandName == "AddReply")
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("SignIn.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                    return;
                }

                int commentId = Convert.ToInt32(e.CommandArgument);
                RepeaterItem item = (RepeaterItem)e.Item;
                TextBox replyTextBox = (TextBox)item.FindControl("txtReply");
                string replyText = replyTextBox.Text.Trim();

                if (string.IsNullOrEmpty(replyText))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Please enter a reply.');", true);
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO CommentReplies (CommentID, UserID, ReplyText, CreatedAt) 
                                   VALUES (@CommentID, @UserID, @ReplyText, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CommentID", commentId);
                        cmd.Parameters.AddWithValue("@UserID", Convert.ToInt32(Session["UserID"]));
                        cmd.Parameters.AddWithValue("@ReplyText", replyText);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Clear the reply textbox and reload comments
                replyTextBox.Text = string.Empty;
                LoadComments(currentPostId);
            }
        }
    }
}
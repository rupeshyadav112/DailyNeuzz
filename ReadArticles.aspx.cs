using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Newtonsoft.Json;
using System.Web;

namespace DailyNeuzz
{
    public partial class ReadArticles : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
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

                if (Session["UserID"] != null)
                {
                    litUserEmail.Text = Session["UserEmail"].ToString();
                    // ProfileImagePath से इमेज URL लें
                    string profileImagePath = Session["UserProfileImage"]?.ToString();
                    imgProfile.ImageUrl = ResolveUrl(!string.IsNullOrEmpty(profileImagePath)
                                                     ? profileImagePath
                                                     : "image/Avatar.png");
                }
                else
                {
                    ltlCommentUser.Text = "Please sign in to comment";
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

        [WebMethod]
        public static object AddComment(int postId, string commentText)
        {
            if (HttpContext.Current.Session["UserID"] == null)
                return new { success = false, message = "unauthorized" };

            int userId = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Comments (PostID, UserID, CommentText, CreatedAt) 
                               OUTPUT INSERTED.CommentID
                               VALUES (@PostID, @UserID, @CommentText, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@CommentText", commentText);

                    conn.Open();
                    int commentId = (int)cmd.ExecuteScalar();

                    // Get the newly created comment details
                    query = @"SELECT c.*, u.Username, 
                             (SELECT COUNT(*) FROM CommentLikes WHERE CommentID = c.CommentID) as LikesCount 
                             FROM Comments c 
                             INNER JOIN Users u ON c.UserID = u.UserID 
                             WHERE c.CommentID = @CommentID";

                    using (SqlCommand getCmd = new SqlCommand(query, conn))
                    {
                        getCmd.Parameters.AddWithValue("@CommentID", commentId);
                        using (SqlDataReader reader = getCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                var comment = new
                                {
                                    CommentID = commentId,
                                    UserID = userId,
                                    Username = reader["Username"].ToString(),
                                    CommentText = commentText,
                                    CreatedAt = DateTime.Now,
                                    LikesCount = 0,
                                    IsOwner = true,
                                    UserAvatar = GetUserAvatar(userId)
                                };

                                return new { success = true, comment = comment };
                            }
                        }
                    }
                }
            }

            return new { success = false };
        }

        [WebMethod]
        public static string UpdateComment(int commentId, string commentText)
        {
            try
            {
                if (HttpContext.Current.Session["UserID"] == null)
                    return "unauthorized";

                if (string.IsNullOrWhiteSpace(commentText))
                    return "error";

                int userId = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            // First verify the comment belongs to the user
                            string verifyQuery = "SELECT COUNT(1) FROM Comments WHERE CommentID = @CommentID AND UserID = @UserID";

                            using (SqlCommand verifyCmd = new SqlCommand(verifyQuery, conn, transaction))
                            {
                                verifyCmd.Parameters.AddWithValue("@CommentID", commentId);
                                verifyCmd.Parameters.AddWithValue("@UserID", userId);

                                int count = (int)verifyCmd.ExecuteScalar();

                                if (count == 0)
                                {
                                    transaction.Rollback();
                                    return "unauthorized";
                                }

                                // If verified, proceed with update
                                string updateQuery = @"UPDATE Comments 
                                                    SET CommentText = @CommentText, 
                                                        ModifiedAt = GETDATE() 
                                                    WHERE CommentID = @CommentID 
                                                    AND UserID = @UserID";

                                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn, transaction))
                                {
                                    updateCmd.Parameters.AddWithValue("@CommentID", commentId);
                                    updateCmd.Parameters.AddWithValue("@CommentText", commentText);
                                    updateCmd.Parameters.AddWithValue("@UserID", userId);

                                    int result = updateCmd.ExecuteNonQuery();
                                    if (result > 0)
                                    {
                                        transaction.Commit();
                                        return "success";
                                    }
                                    else
                                    {
                                        transaction.Rollback();
                                        return "error";
                                    }
                                }
                            }
                        }
                        catch
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception details here
                return "error";
            }
        }

        [WebMethod]
        public static string DeleteComment(int commentId)
        {
            if (HttpContext.Current.Session["UserID"] == null)
                return "unauthorized";

            int userId = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // First delete any likes associated with the comment
                        string deleteLikesQuery = "DELETE FROM CommentLikes WHERE CommentID = @CommentID";
                        using (SqlCommand cmd = new SqlCommand(deleteLikesQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@CommentID", commentId);
                            cmd.ExecuteNonQuery();
                        }

                        // Then delete the comment
                        string deleteCommentQuery = "DELETE FROM Comments WHERE CommentID = @CommentID AND UserID = @UserID";
                        using (SqlCommand cmd = new SqlCommand(deleteCommentQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@CommentID", commentId);
                            cmd.Parameters.AddWithValue("@UserID", userId);

                            int result = cmd.ExecuteNonQuery();
                            if (result > 0)
                            {
                                transaction.Commit();
                                return "success";
                            }
                            else
                            {
                                transaction.Rollback();
                                return "error";
                            }
                        }
                    }
                    catch
                    {
                        transaction.Rollback();
                        return "error";
                    }
                }
            }
        }

        [WebMethod]
        public static string ToggleLike(int commentId)
        {
            if (HttpContext.Current.Session["UserID"] == null)
                return "unauthorized";

            int userId = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        string toggleQuery = @"
                            IF EXISTS (SELECT 1 FROM CommentLikes WHERE CommentID = @CommentID AND UserID = @UserID)
                                DELETE FROM CommentLikes WHERE CommentID = @CommentID AND UserID = @UserID
                            ELSE
                                INSERT INTO CommentLikes (CommentID, UserID) VALUES (@CommentID, @UserID)";

                        using (SqlCommand cmd = new SqlCommand(toggleQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@CommentID", commentId);
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.ExecuteNonQuery();
                        }

                        string getLikesQuery = "SELECT COUNT(*) FROM CommentLikes WHERE CommentID = @CommentID";
                        using (SqlCommand cmd = new SqlCommand(getLikesQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@CommentID", commentId);
                            int likesCount = (int)cmd.ExecuteScalar();
                            transaction.Commit();
                            return JsonConvert.SerializeObject(new { success = true, likesCount = likesCount });
                        }
                    }
                    catch
                    {
                        transaction.Rollback();
                        return "error";
                    }
                }
            }
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

        protected static string GetUserAvatar(object userId)
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

        protected bool IsCommentOwner(object userId)
        {
            if (Session["UserID"] == null) return false;
            return Convert.ToInt32(userId) == Convert.ToInt32(Session["UserID"]);
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

        protected string FormatDate(object date)
        {
            return Convert.ToDateTime(date).ToString("MMM dd, yyyy");
        }
    }
}
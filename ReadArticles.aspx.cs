using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DailyNeuzz
{
    public partial class ReadArticles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // URL से PostID प्राप्त करें
                string postId = Request.QueryString["PostID"];
                if (!string.IsNullOrEmpty(postId))
                {
                    LoadArticle(postId);
                    LoadComments(postId);
                    UpdateLikeCount(postId);
                }
                else
                {
                    Response.Redirect("~/NewsArticles.aspx"); // यदि PostID नहीं मिला तो वापस मुख्य पेज पर भेज दें
                }

                if (!IsUserLoggedIn())
                {
                    pnlAddComment.Visible = false;
                    btnLike.Enabled = false;
                }
            }
        }

        private void LoadArticle(string postId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT p.*, u.UserName as AuthorName 
                    FROM Posts p 
                    LEFT JOIN Users u ON p.UserID = u.UserID 
                    WHERE p.PostID = @PostID", conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // टाइटल और कंटेंट सेट करें
                            lblTitle.Text = reader["Title"].ToString();
                            litContent.Text = reader["Content"].ToString();

                            // कैटेगरी और डेट सेट करें
                            lblCategory.Text = reader["Category"].ToString();
                            lblDate.Text = Convert.ToDateTime(reader["CreatedAt"]).ToString("dd MMM yyyy");

                            // फॉन्ट स्टाइल अप्लाई करें
                            string fontStyle = reader["FontStyle"].ToString();
                            if (!string.IsNullOrEmpty(fontStyle))
                            {
                                litContent.Text = $"<div style='font-family: {fontStyle}'>{litContent.Text}</div>";
                            }

                            // इमेज सेट करें
                            string imagePath = reader["ImagePath"].ToString();
                            if (!string.IsNullOrEmpty(imagePath))
                            {
                                imgFeatured.ImageUrl = imagePath;
                                imgFeatured.Visible = true;
                            }
                            else
                            {
                                imgFeatured.Visible = false;
                            }
                        }
                        else
                        {
                            Response.Redirect("~/NewsArticles.aspx"); // यदि पोस्ट नहीं मिला तो वापस भेज दें
                        }
                    }
                }
            }
        }

        protected void btnLike_Click(object sender, EventArgs e)
        {
            if (!IsUserLoggedIn())
            {
                Response.Redirect("~/SignIn.aspx");
                return;
            }

            string postId = Request.QueryString["PostID"];
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    IF NOT EXISTS (SELECT 1 FROM PostLikes WHERE PostID = @PostID AND UserID = @UserID)
                    BEGIN
                        INSERT INTO PostLikes (PostID, UserID, LikedDate) 
                        VALUES (@PostID, @UserID, @LikedDate)
                    END", conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    cmd.Parameters.AddWithValue("@UserID", GetCurrentUserId());
                    cmd.Parameters.AddWithValue("@LikedDate", DateTime.Now);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            UpdateLikeCount(postId);
        }

        private void UpdateLikeCount(string postId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT COUNT(*) FROM PostLikes WHERE PostID = @PostID", conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    conn.Open();
                    int likeCount = (int)cmd.ExecuteScalar();
                    lblLikes.Text = likeCount.ToString() + " likes";
                }
            }
        }

        protected void btnComment_Click(object sender, EventArgs e)
        {
            if (!IsUserLoggedIn())
            {
                Response.Redirect("~/SignIn.aspx");
                return;
            }

            string postId = Request.QueryString["PostID"];
            string userId = GetCurrentUserId();
            string commentText = txtComment.Text.Trim();

            if (string.IsNullOrEmpty(commentText))
            {
                return; // खाली कमेंट न जोड़ें
            }

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO PostComments (PostID, UserID, CommentText, CommentDate) 
                    VALUES (@PostID, @UserID, @CommentText, @CommentDate)", conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@CommentText", commentText);
                    cmd.Parameters.AddWithValue("@CommentDate", DateTime.Now);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            txtComment.Text = "";
            LoadComments(postId);
        }

        private void LoadComments(string postId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT pc.*, u.UserName 
                    FROM PostComments pc 
                    INNER JOIN Users u ON pc.UserID = u.UserID 
                    WHERE pc.PostID = @PostID 
                    ORDER BY pc.CommentDate DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@PostID", postId);
                    conn.Open();
                    rptComments.DataSource = cmd.ExecuteReader();
                    rptComments.DataBind();
                }
            }
        }

        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteComment")
            {
                string commentId = e.CommandArgument.ToString();
                DeleteComment(commentId);
                LoadComments(Request.QueryString["PostID"]);
            }
        }

        private void DeleteComment(string commentId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(@"
                    DELETE FROM PostComments 
                    WHERE CommentID = @CommentID AND UserID = @UserID", conn))
                {
                    cmd.Parameters.AddWithValue("@CommentID", commentId);
                    cmd.Parameters.AddWithValue("@UserID", GetCurrentUserId());
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected bool IsUserLoggedIn()
        {
            return Session["UserId"] != null;
        }

        public string GetCurrentUserId()
        {
            return Session["UserId"]?.ToString();
        }

        private string GetConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DailyNeuzz
{
    public partial class ReadArticle : System.Web.UI.Page
    {
        private int articleId;
        private string connectionString = System.Configuration.ConfigurationManager
            .ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Get article ID from query string
            if (!int.TryParse(Request.QueryString["id"], out articleId))
            {
                Response.Redirect(""); // Redirect if no valid ID
                return;
            }

            if (!IsPostBack)
            {
                LoadArticle();
                LoadRelatedArticles();
                LoadComments();
            }
        }

        private void LoadArticle()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetArticleById", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ArticleId", articleId);

                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                ltlTitle.Text = reader["Title"].ToString();
                                ltlArticleTitle.Text = reader["Title"].ToString();
                                ltlAuthorName.Text = reader["AuthorName"].ToString();
                                ltlPublishDate.Text = Convert.ToDateTime(reader["PublishDate"])
                                    .ToString("MMMM dd, yyyy");
                                ltlArticleContent.Text = reader["Content"].ToString();

                                // Set images
                                imgArticle.ImageUrl = reader["ImageUrl"].ToString();
                                imgAuthorAvatar.ImageUrl = reader["AuthorAvatarUrl"].ToString();
                            }
                            else
                            {
                                Response.Redirect(""); // Article not found
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log error and show user-friendly message
                        System.Diagnostics.Debug.WriteLine($"Error loading article: {ex.Message}");
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert",
                            "alert('Unable to load the article. Please try again later.');", true);
                    }
                }
            }
        }

        private void LoadRelatedArticles()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetRelatedArticles", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ArticleId", articleId);
                    cmd.Parameters.AddWithValue("@Count", 3); // Number of related articles to show

                    try
                    {
                        conn.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            rptRelatedArticles.DataSource = dt;
                            rptRelatedArticles.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error loading related articles: {ex.Message}");
                    }
                }
            }
        }

        private void LoadComments()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetArticleComments", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ArticleId", articleId);

                    try
                    {
                        conn.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            rptComments.DataSource = dt;
                            rptComments.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error loading comments: {ex.Message}");
                    }
                }
            }
        }

        protected void btnSubmitComment_Click(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            string comment = txtComment.Text.Trim();
            if (string.IsNullOrEmpty(comment))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "CommentError",
                    "alert('Please enter a comment.');", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("AddComment", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ArticleId", articleId);
                    cmd.Parameters.AddWithValue("@UserId", User.Identity.Name);
                    cmd.Parameters.AddWithValue("@CommentText", comment);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        txtComment.Text = string.Empty;
                        LoadComments(); // Reload comments
                        ScriptManager.RegisterStartupScript(this, GetType(), "CommentSuccess",
                            "alert('Comment posted successfully.');", true);
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error posting comment: {ex.Message}");
                        ScriptManager.RegisterStartupScript(this, GetType(), "CommentError",
                            "alert('Unable to post comment. Please try again later.');", true);
                    }
                }
            }
        }
    }
}
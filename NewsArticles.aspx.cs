using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace DailyNeuzz
{
    public partial class NewsArticles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllPosts();
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

        private void LoadAllPosts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT PostID, Title, Content, Category, ImagePath, FontStyle, CreatedAt FROM Posts ORDER BY CreatedAt DESC", conn))
                {
                    try
                    {
                        conn.Open();
                        rptArticles.DataSource = cmd.ExecuteReader();
                        rptArticles.DataBind();
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error: {ex.Message.Replace("'", "")}');</script>");
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
        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearchTerm.Text.Trim();
            string sortBy = ddlSortBy.SelectedValue;
            string category = ddlCategory.SelectedValue;

            string query = "SELECT PostID, Title, Content, Category, ImagePath, FontStyle, CreatedAt FROM Posts WHERE 1=1";

            // Filters
            if (!string.IsNullOrEmpty(searchTerm))
                query += " AND (Title LIKE @SearchTerm OR Content LIKE @SearchTerm)";

            if (!string.IsNullOrEmpty(category))
                query += " AND Category = @Category";

            // Sorting
            switch (sortBy)
            {
                case "date":
                    query += " ORDER BY CreatedAt DESC";
                    break;
                case "popularity":
                    query += " ORDER BY CreatedAt DESC";
                    break;
                default:
                    query += " ORDER BY CreatedAt DESC";
                    break;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(query, con);

                    if (!string.IsNullOrEmpty(searchTerm))
                        cmd.Parameters.AddWithValue("@SearchTerm", $"%{searchTerm}%");

                    if (!string.IsNullOrEmpty(category))
                        cmd.Parameters.AddWithValue("@Category", category);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptArticles.DataSource = dt;
                    rptArticles.DataBind();

                    // Reset Filters after Data Binding
                    txtSearchTerm.Text = string.Empty;
                    ddlSortBy.SelectedIndex = 0;
                    ddlCategory.SelectedIndex = 0;
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>alert('Error: {ex.Message.Replace("'", "")}');</script>");
                }
            }
        }
    }
}
using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace DailyNeuzz
{
    public partial class Dashboard : Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] == null)
                {
                    Response.Redirect("SignIn.aspx");
                    return;
                }

                litUserEmail.Text = $"Welcome, {Session["UserEmail"]}";

                // Set profile image if available
                string profileImage = Session["UserProfileImage"]?.ToString();
                if (!string.IsNullOrEmpty(profileImage))
                {
                    imgProfile.ImageUrl = profileImage;
                    imgProfile.Visible = true;
                    headerProfilePlaceholder.Visible = false;
                }
                else
                {
                    imgProfile.Visible = false;
                    headerProfilePlaceholder.Visible = true;
                }

                LoadDashboardStats();
                LoadRecentUsers();
                LoadRecentPosts();
                this.DataBind(); // Important for the circle calculations
            }
        }

        private void LoadDashboardStats()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        SELECT 
                            (SELECT COUNT(*) FROM Users) as TotalUsers,
                            (SELECT COUNT(*) FROM Comments) as TotalComments,
                            (SELECT COUNT(*) FROM Posts) as TotalPosts,
                            (SELECT COUNT(*) FROM Users WHERE DATEADD(day, -30, GETDATE()) <= CreatedAt) as LastMonthUsers,
                            (SELECT COUNT(*) FROM Comments WHERE DATEADD(day, -30, GETDATE()) <= CreatedAt) as LastMonthComments,
                            (SELECT COUNT(*) FROM Posts WHERE DATEADD(day, -30, GETDATE()) <= CreatedAt) as LastMonthPosts";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblTotalUsers.Text = reader["TotalUsers"].ToString();
                                lblTotalComments.Text = reader["TotalComments"].ToString();
                                lblTotalPosts.Text = reader["TotalPosts"].ToString();

                                lblLastMonthUsers.Text = reader["LastMonthUsers"].ToString();
                                lblLastMonthComments.Text = reader["LastMonthComments"].ToString();
                                lblLastMonthPosts.Text = reader["LastMonthPosts"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error appropriately
                System.Diagnostics.Debug.WriteLine($"Error loading dashboard stats: {ex.Message}");
            }
        }

        private void LoadRecentUsers()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT TOP 5 
                            UserID, 
                            Username, 
                            Email, 
                            ISNULL(ProfileImagePath, '~/Images/default-profile.png') as UserImage,
                            CreatedAt
                        FROM Users 
                        ORDER BY CreatedAt DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            gvRecentUsers.DataSource = dt;
                            gvRecentUsers.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading recent users: {ex.Message}");
            }
        }

        private void LoadRecentPosts()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT TOP 5 
                            PostID, 
                            Title, 
                            Category, 
                            ISNULL(ImagePath, '~/Images/default-post.png') as PostImage,
                            CreatedAt
                        FROM Posts 
                        ORDER BY CreatedAt DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            gvRecentPosts.DataSource = dt;
                            gvRecentPosts.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading recent posts: {ex.Message}");
            }
        }

        protected double GetCircleOffset(int value)
        {
            // Get the maximum value among all stats for relative scaling
            int maxValue = Math.Max(
                Math.Max(
                    Convert.ToInt32(lblTotalUsers.Text),
                    Convert.ToInt32(lblTotalComments.Text)
                ),
                Convert.ToInt32(lblTotalPosts.Text)
            );

            // Calculate the percentage
            double percentage = maxValue == 0 ? 0 : (double)value / maxValue;

            // The circle's circumference is 2πr = 2 * π * 70 ≈ 439.6
            double circumference = 439.6;

            // Calculate the offset
            return circumference * (1 - percentage);
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

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/SignIn.aspx");
        }
    }
}
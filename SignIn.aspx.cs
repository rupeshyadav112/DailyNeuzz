using System;
using System.Configuration;
using System.Data.SqlClient;

namespace DailyNeuzz
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                    {
                        conn.Open();
                        lblError.Text = "Database connection successful!";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Database connection failed: " + ex.Message;
                }
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            // 1. Check hardcoded credentials
            if (email == "ryadav943@rku.ac.in" && password == "123123")
            {
                Session["UserEmail"] = email;
                Session["UserId"] = 1; // Hardcoded user ID
                Session["UserName"] = "Hardcoded User";
                Response.Redirect("Dashboard.aspx");
                return;
            }

            // 2. Check database credentials
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT UserId, Email, Username, FullName FROM Users WHERE Email = @Email AND Password = @Password";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.HasRows)
                        {
                            reader.Read();
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["UserEmail"] = reader["Email"].ToString();
                            Session["Username"] = reader["Username"].ToString();
                            Session["FullName"] = reader["FullName"].ToString();
                            reader.Close();
                            conn.Close();
                            Response.Redirect("Home.aspx");
                        }
                        else
                        {
                            lblError.Text = "Invalid email or password.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = "Error: " + ex.Message;
                        System.Diagnostics.Debug.WriteLine("Login Error: " + ex.ToString());
                    }
                }
            }
        }
    }
}
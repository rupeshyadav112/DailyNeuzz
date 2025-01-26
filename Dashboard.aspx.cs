using System;
using System.Web.UI;

namespace DailyNeuzz
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] == null)
                {
                    // Redirect to login page if user is not logged in
                    Response.Redirect("SignIn.aspx");
                }
                else
                {
                    // Set user email in profile dropdown
                    litUserEmail.Text = $"Welcome, {Session["UserEmail"]}";
                    imgProfile.ImageUrl = Session["UserProfileImage"]?.ToString() ?? "~/Images/default-profile.png";
                }
            }
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to login page
            Session.Clear();
            Response.Redirect("SignIn.aspx");
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
            // Logout logic here
            // Example: Clear session and redirect to login page
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

    }
}

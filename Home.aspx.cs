using System;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace DailyNeuzz
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserEmail"] != null)
                {
                    litUserEmail.Text = Session["UserEmail"].ToString();
                    imgProfile.ImageUrl = ResolveUrl(Session["UserProfileImage"]?.ToString() ?? "image/Avatar.png");

                    // Dynamically load recent posts
                    LoadRecentPosts();
                }
            }
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            // Clear the session and redirect to login page
            Session.Clear();
            Session.Abandon();
            Response.Redirect("SignIn.aspx");
        }

        // Mock method to get recent posts
        private List<Article> GetRecentPosts()
        {
            // In real implementation, fetch from your database.
            return new List<Article>
            {
                new Article { Id = 1, Title = "Discover Serenity: Top Hidden Travel Gems", ImageUrl = "image/Article1.jpeg", Category = "worldnews" },
                new Article { Id = 2, Title = "City Park Revamp Project Brings New Life", ImageUrl = "image/Article2.jpg", Category = "localnews" },
                new Article { Id = 3, Title = "Lionel Messi's Magical Hat-Trick", ImageUrl = "image/Messi.jpeg", Category = "sportsnews" },
                new Article { Id = 4, Title = "Breakthrough Climate Agreement", ImageUrl = "image/mountain.jpeg", Category = "worldnews" },
                new Article { Id = 5, Title = "Sports Fiesta", ImageUrl = "image/sport.jpg", Category = "sportsnews" },
                new Article { Id = 6, Title = "AI Technology", ImageUrl = "image/Ai.jpg", Category = "worldnews" }
            };
        }

        private void LoadRecentPosts()
        {
            // Fetch posts (for example, from a database)
            var posts = GetRecentPosts();

            // Dynamically generate post cards
            foreach (var post in posts)
            {
                var articleMarkup = $@"
                    <article class='post-card'>
                        <img src='{post.ImageUrl}?height=200&width=400' alt='{post.Title}'>
                        <div class='post-content'>
                            <h3 class='post-title'>{post.Title}</h3>
                            <p class='post-category'>{post.Category}</p>
                        </div>
                        <div class='post-footer'>
                            <a href='ReadArticle.aspx?articleId={post.Id}' class='button button-secondary button-full'>Read Article</a>
                        </div>
                    </article>";

                // Add the dynamically created article HTML to the Recent Posts section
                //recentPostsContainer.InnerHtml += articleMarkup;
            }
        }
    }
}

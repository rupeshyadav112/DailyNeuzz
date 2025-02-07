
//using System;
//using System.Web;
//using System.Data.SqlClient;
//using Newtonsoft.Json;
//using System.Configuration;

//namespace DailyNeuzz
//{
//    public class LikeComment : IHttpHandler
//    {
//        public void ProcessRequest(HttpContext context)
//        {
//            context.Response.ContentType = "application/json";

//            if (!int.TryParse(context.Request.QueryString["commentId"], out int commentId) ||
//                HttpContext.Current.Session["UserID"] == null)
//            {
//                context.Response.Write(JsonConvert.SerializeObject(new { success = false }));
//                return;
//            }

//            int userId = (int)HttpContext.Current.Session["UserID"];

//            using (SqlConnection conn = new SqlConnection(
//                ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
//            {
//                conn.Open();

//                // Like/Unlike लॉजिक
//                bool exists = new SqlCommand(
//                    "SELECT COUNT(*) FROM CommentLikes WHERE CommentID = @cid AND UserID = @uid",
//                    conn)
//                {
//                    Parameters = {
//                        new SqlParameter("@cid", commentId),
//                        new SqlParameter("@uid", userId)
//                    }
//                }.ExecuteScalar().ToString() != "0";

//                if (exists)
//                {
//                    new SqlCommand(
//                        "DELETE FROM CommentLikes WHERE CommentID = @cid AND UserID = @uid",
//                        conn)
//                    {
//                        Parameters = {
//                            new SqlParameter("@cid", commentId),
//                            new SqlParameter("@uid", userId)
//                        }
//                    }.ExecuteNonQuery();
//                }
//                else
//                {
//                    new SqlCommand(
//                        "INSERT INTO CommentLikes (CommentID, UserID) VALUES (@cid, @uid)",
//                        conn)
//                    {
//                        Parameters = {
//                            new SqlParameter("@cid", commentId),
//                            new SqlParameter("@uid", userId)
//                        }
//                    }.ExecuteNonQuery();
//                }

//                // नया काउंट पाएं
//                int newCount = (int)new SqlCommand(
//                    "SELECT COUNT(*) FROM CommentLikes WHERE CommentID = @cid",
//                    conn)
//                {
//                    Parameters = { new SqlParameter("@cid", commentId) }
//                }.ExecuteScalar();

//                context.Response.Write(JsonConvert.SerializeObject(new
//                {
//                    success = true,
//                    newCount = newCount
//                }));
//            }
//        }

//        public bool IsReusable => false;
//    }
//}
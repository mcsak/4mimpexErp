using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FourMImpexClass.DAL;

namespace FourMImpex
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnlog_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            AdminBusiness d_admin = new AdminBusiness();
            
            string password = txtpassword.Text.Trim();
            if(txtemail.Text!=null && txtpassword.Text!=null)
            {
                string saltGenSize = password.Substring(password.Length - 4);
                string hashedPasswordAndSalt = d_admin.CreatePasswordHash(txtpassword.Text.Trim(), saltGenSize);
                ds = d_admin.GetUserandPass(txtemail.Text, hashedPasswordAndSalt);
                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (ds.Tables[0].Rows[0]["Result"].ToString() == "S")
                            {
                                Session["UserID"] = ds.Tables[0].Rows[0]["UserID"].ToString();
                                Response.Redirect("~/Welcome.aspx");
                            }
                            
                        }
                    }
                    else
                    {
                        lblmessage.Text = "User does not exist.";
                    }
                }
               
            }
           
        }
    }
}
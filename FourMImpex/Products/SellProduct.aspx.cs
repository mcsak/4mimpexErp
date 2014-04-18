using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace FourMImpex.Products
{
    public partial class SellProduct : System.Web.UI.Page
    {/// 
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["dt"] != null)
            {
                dt = (DataTable)Session["dt"];
                GvProductList.DataSource = dt;
                GvProductList.DataBind();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            btnPrint.Visible = false;
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "Script", "javascript:window.print();", true);
            //OnClientClick="javascript:window.print();this.hide();"
        }
    }
}
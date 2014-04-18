using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using FourMImpexClass.DAL;

namespace FourMImpex.UC
{
    public partial class Banner : System.Web.UI.UserControl
    {
        //ProductsD ProductsDAL;
       
        protected void Page_Load(object sender, EventArgs e)
        {
           // alnkproducts.HRef = "~/Products/ProductSelection.aspx";
           // alnkproductadmin.HRef = "~/Admin/ProductGrid.aspx";
        }

        protected void imgbtnAdvanceSearch_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Products/SearchResults.aspx?LoadID=1&LoadValue="+txtAdvanceSearch.Text.Trim());
        }
    }
}
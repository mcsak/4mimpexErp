using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FourMImpexClass.DAL;
using System.Data;

namespace FourMImpex.Products
{
    public partial class SearchResults : System.Web.UI.Page
    {
        ProductsD ProductsDAL = new ProductsD();
        protected void Page_Load(object sender, EventArgs e)
        {
            int LoadID = Convert.ToInt32(Request.QueryString["LoadID"]);
            string LoadValue = Request.QueryString["LoadValue"];
            if (!IsPostBack)
            {
                if(LoadID==1)
                    BindSearchResults(LoadValue);
            }
        }

        protected void BindSearchResults(string TextToSearch)
        {
            DataSet DsResults = new DataSet();
            DsResults = ProductsDAL.GetAdvanceSearchresults(TextToSearch);
            if(DsResults!=null)
                if(DsResults.Tables.Count>0)
                    if (DsResults.Tables[0].Rows.Count > 0)
                    {
                        GVSearchResults.DataSource = DsResults.Tables[0];
                        GVSearchResults.DataBind();
                    }
        }

        protected void GVSearchResults_OnDataBound(object sender, EventArgs ee)
        {
            
           // if (Re.Row.RowType ==DataControlRowType.DataRow)
           // {
           //    int ss = Re.Row.RowIndex;
           // //    string strval = ((HiddenField)Re.Row.FindControl("hdnStockQty")).Value;
           // //    if (Convert.ToInt32(((HiddenField)Re.Row.FindControl("hdnStockQty")).Value) <= 0)
           // //        ((LinkButton)Re.Row.FindControl("lnkbtntoSell")).Enabled = false;
           //}
                
        }

        protected void GVSearchResults_OnRowCommand(object sender, GridViewCommandEventArgs Ce)
        {
            
            if (Ce.CommandName == "ViewSell")
            {
                Response.Redirect("~/Products/ProductSelection.aspx?LoadID=21&LoadValue="+Ce.CommandArgument.ToString());
            }

        }
    }
}
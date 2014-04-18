using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FourMImpexClass.DAL;
using FourMImpex.UC;
using System.Data;

namespace FourMImpex.Stocks
{
    public partial class OpenStockGrid : System.Web.UI.Page
    {
        DataSet DsOpenStock = new DataSet();
        string LoadCase;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PageBind(0, "");
                LoadCase = Request.QueryString["LoadCase"];
            }
 
        }

        protected void PageBind(Byte FilterType,String FilterText)
        {
            StockD StockObj = new StockD();
            DsOpenStock= StockObj.OpenStockLoaddata(FilterType,FilterText);
            if (DsOpenStock != null)
            {
                if (DsOpenStock.Tables[0].Rows.Count > 0)
                {
                    gvOpenStock.DataSource = DsOpenStock.Tables[0];
                    gvOpenStock.DataBind();
                }
                else
                {
                    if (LoadCase == "2")
                        Response.Redirect("~/Stocks/ImportExportOpenStock.aspx?LoadCase=2");
                    else
                        Response.Redirect("~/Stocks/ImportExportOpenStock.aspx");
                }
                // ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("There are no records avilable.");

            }
            else
            {
                InnerMaster inm = Master as InnerMaster;
                ((PageMessage)(Page.Master.FindControl("pagemsg"))).ErrorMessage("Server error caused.");
                UpdatePanel updpnls = (UpdatePanel)inm.FindControl("updpnlMaster");
                updpnls.Update();
            }
               // ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("There are no records avilable.");
                       
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            Byte FilterType=0; String FilterText="";
            if (ddlsearchby.SelectedIndex == -1 || ddlsearchby.SelectedIndex == 0)
            {
                FilterType = 0; FilterText = txtsearch.Text;
            }
            else if (ddlsearchby.SelectedIndex == 1)
            {
                FilterType = 1; FilterText = txtsearch.Text;
            }
            else if (ddlsearchby.SelectedIndex == 2)
            {
                FilterType = 2; FilterText = txtsearch.Text;
            }
            else if (ddlsearchby.SelectedIndex == 3)
            {
                FilterType = 3; FilterText = txtsearch.Text;
            }
            else if (ddlsearchby.SelectedIndex == 4)
            {
                FilterType = 4; FilterText = txtsearch.Text;
            }
            PageBind(FilterType, FilterText); 
        }
    }
}
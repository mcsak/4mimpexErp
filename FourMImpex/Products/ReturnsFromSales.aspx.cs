using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FourMImpexClass.DAL;
using FourMImpex.UC;
using System.Data;

namespace FourMImpex.Products
{
    public partial class ReturnsFromSales : System.Web.UI.Page
    {
        ProductsD Products_D = new ProductsD();
        DataSet Ds = new DataSet();
        string LoadID, LoadValue;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadID = Request.QueryString[0];
            LoadValue = Request.QueryString[1];
            if (LoadID == "21")
            {
                divSearchContainer.Visible = false;
                PageBind(LoadValue, 1);
            }
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void PageBind(String EntityID,byte Type=0)
        {
            Ds= Products_D.GetDetailsForReturnedQty(EntityID,Type);
            if (Ds != null)
                if (Ds.Tables.Count > 0)
                    if (Ds.Tables[0].Rows.Count > 0)
                    {
                        GvProductList.DataSource = Ds.Tables[0];
                        GvProductList.DataBind();
                    }
                    else
                        PageMessageUpdate(2);
                else
                    PageMessageUpdate(4);
            else
                PageMessageUpdate(4);
        }

        protected void gvtxtQty_OnTextChanged(object sender, EventArgs e)
        {

        }

        protected void gvtxtPrice_OnTextChanged(object sender, EventArgs e)
        {

        }

        protected void GvProductList_OnRowCommand(object sender, GridViewRowEventArgs Re)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void PageMessageUpdate(int ResultVal, string Message = "")
        {
            InnerMaster inm = Master as InnerMaster;
            UpdatePanel updpnl = (UpdatePanel)inm.FindControl("updpnlMaster");
            // updpnl.ChildrenAsTriggers = false;
            if (ResultVal == 0)
            {
                // No message
            }
            else if (ResultVal == 1)
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Your data has been saved successfuly.");
                updpnl.Update();
            }
            else if (ResultVal == 2)
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("There are no records found.");
                updpnl.Update();
            }
            else if (ResultVal == 3)
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).ErrorMessage("No data.");
                updpnl.Update();
            }
            else if (ResultVal == 4)
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).ErrorMessage("Server error.");
                updpnl.Update();
            }
            else if (ResultVal == 5)
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).SuccessMessage(Message);
                updpnl.Update();
            }
            else if (ResultVal == 6)
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage(Message);
                updpnl.Update();
            }
            else
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).ErrorMessage("Unknown error.");
                updpnl.Update();
            }
        }

    }
}
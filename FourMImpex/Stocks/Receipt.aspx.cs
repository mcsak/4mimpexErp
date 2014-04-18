using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using FourMImpexClass.DAL;
using FourMImpex.UC;

namespace FourMImpex.Stocks
{
    public partial class Receipt : System.Web.UI.Page
    {
        protected byte Loadcase = 0;
        protected string LoadID = ""; int Result = 0;
        protected StockD ObjStockD = new StockD();
        protected DataSet DsPurchaseOrders;  
      
        protected void Page_Load(object sender, EventArgs e)
        {
            
            Loadcase = Convert.ToByte(Request.QueryString["View"]);
           if (!IsPostBack)
           {
               SetVisibility();
            if (Loadcase == 1)
            {               
                LoadID = Request.QueryString["LoadID"];                
                DsPurchaseOrders = new DataSet();
                DsPurchaseOrders=ObjStockD.GetSinglePurchaseOrderDetailsForReceipt(Convert.ToInt64(LoadID));
                if (DsPurchaseOrders != null)
                    if (DsPurchaseOrders.Tables.Count > 0)
                        if (DsPurchaseOrders.Tables[0].Rows.Count > 0)
                        {
                            GvProductList.DataSource = DsPurchaseOrders.Tables[0];
                            GvProductList.DataBind();
                            Result = 0;
                        }
                        else
                            Result = 2;
                    else
                        Result = 3;
                else
                    Result = 4;
                if (Result!=0)
                PageMessageUpdate(Result);
            }
        }
        }

        protected void SetVisibility()
        {
            if (Loadcase == 1)
            {
                RbtnReceipt.Checked = true;
                RbtnBulkStock.Checked = false;
                RbtnReceipt.Enabled = false;
                RbtnBulkStock.Enabled = false;
                divRemarks.Visible = true;
            }
            else if (Loadcase == 21)
            {
                RbtnBulkStock.Checked = true;
                RbtnReceipt.Checked = false;
                RbtnReceipt.Enabled = false;
                RbtnBulkStock.Enabled = false;
                divRemarks.Visible = true;
            }
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
                ((PageMessageLatest)(Page.Master.FindControl("PageMessageLatest"))).InfoMessage("Your data has been saved successfuly.");
                updpnl.Update();
            }
            else if (ResultVal == 2)
            {
                ((PageMessageLatest)(Page.Master.FindControl("PageMessageLatest"))).InfoMessage("There are no records found.");
                updpnl.Update();
            }
            else if (ResultVal == 3)
            {
                ((PageMessageLatest)(Page.Master.FindControl("PageMessageLatest"))).ErrorMessage("No data.");
                updpnl.Update();
            }
            else if (ResultVal == 4)
            {
                ((PageMessageLatest)(Page.Master.FindControl("PageMessageLatest"))).ErrorMessage("Server error.");
                updpnl.Update();
            }
            else if (ResultVal == 5)
            {
                ((PageMessageLatest)(Page.Master.FindControl("PageMessageLatest"))).SuccessMessage(Message);
                updpnl.Update();
            }
            else if (ResultVal == 6)
            {
                ((PageMessageLatest)(Page.Master.FindControl("PageMessageLatest"))).InfoMessage(Message);
                updpnl.Update();
            }
            else
            {
                ((PageMessageLatest)(Page.Master.FindControl("PageMessageLatest"))).ErrorMessage("Unknown error.");
                updpnl.Update();
            }
        }

        protected int BindDataFromGrid()
        {
            int returnValue = 0;
            DataTable DtReceivedQty = new DataTable();
            
            if (ViewState["DtReceivedQty"] == null)
            {
                DtReceivedQty.Columns.Add("ID");
                DtReceivedQty.Columns.Add("PurchaseID");
                DtReceivedQty.Columns.Add("ModelID");
                DtReceivedQty.Columns.Add("SerialNo");
                DtReceivedQty.Columns.Add("Qty");
                
            }
            else
                DtReceivedQty = (DataTable)ViewState["DtReceivedQty"];

            foreach (GridViewRow GVRow in GvProductList.Rows)
            {
                int RowIndex = GVRow.RowIndex+1;
                long RemainQty = Convert.ToInt64(((HiddenField)GVRow.FindControl("hdnRemainQty")).Value);
                long ModelID = Convert.ToInt64(((HiddenField)GVRow.FindControl("hdnModelID")).Value);
                long hdnPurchaseID = Convert.ToInt64(((HiddenField)GVRow.FindControl("hdnPurchaseID")).Value);                
                int CurrentQty = Convert.ToInt32(((TextBox)GVRow.FindControl("gvtxtQty")).Text);
                string SerialNo = ((TextBox)GVRow.FindControl("gvtxtSerialNo")).Text;
                if (SerialNo == "" || SerialNo == null || SerialNo==" ")
                    SerialNo = "0";
                if(CurrentQty!=0)
                if (RemainQty >= CurrentQty)
                {
                    DtReceivedQty.Rows.Add(DtReceivedQty.Rows.Count + 1, hdnPurchaseID, ModelID, SerialNo, CurrentQty);
                    returnValue= 1;                    
                }
                else
                {
                    PageMessageUpdate(5, "Please Enter Received Qty. Less than or equal to ordered Qty. row @ : " + RowIndex);                   
                    returnValue= 0;
                    break;                    
                }
            }

            if (txtRemarks.Text == "" || txtRemarks.Text == null || txtRemarks.Text == " ")
            {
                returnValue = 0;
                PageMessageUpdate(5, "Please enter remarks.");
            }
            ViewState["DtReceivedQty"] = DtReceivedQty;
            return returnValue;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ViewState["DtReceivedQty"] = null;
           int ValidatedValue= BindDataFromGrid();
           if (ValidatedValue != 0)
           {
               DataTable DtReceivedQty=new DataTable();
               DtReceivedQty=(DataTable)ViewState["DtReceivedQty"];
               String Result = "N";
               if (DtReceivedQty != null && DtReceivedQty.Rows.Count != 0)
               {
                   Result = ObjStockD.PurchaseOrderReceiptBulkCopy(DtReceivedQty, Convert.ToInt32(Session["UserID"]), txtRemarks.Text);
                   btnSubmit.Visible = false;
               }
               
               if (Result == "S")
                   PageMessageUpdate(1);
               else if (Result == "N")
                   PageMessageUpdate(5,"There are no changes made.");
               else
                   PageMessageUpdate(4);
           }
            //else
              // PageMessageUpdate(5, "Please make sure that your entered qty less than There are no changes made.");
        }


    }
}
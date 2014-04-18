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
    public partial class PurchaseOrder : System.Web.UI.Page
    {
        protected DataSet DsCom = new DataSet();
        ProductsD ProdD = new ProductsD(); Int64 ProductID = 0, BrandID = 0, ModelID = 0;
        protected string ProductName, BrandName, ModelName; DataTable dt = new DataTable(); DataSet dsa = new DataSet();
        DataTable dt_ = new DataTable();
        int loadcase;
        protected void Page_Load(object sender, EventArgs e)
        {
            loadcase = Convert.ToInt16(Request.QueryString["Page"]);
            if (!IsPostBack)
            {
                if (loadcase == 1 || loadcase==0)
                {
                    LoadListItems(1);
                    DtPrepare();
                }
            }
        }

        protected void LoadListItems(int Action)
        {
            DsCom = ProdD.LoadListItems(ProductID, BrandID, Action);
            if (DsCom != null)
                if (DsCom.Tables.Count > 0)
                    if (DsCom.Tables[0].Rows.Count > 0)
                    {
                        if (Action == 1)
                        {
                            LstProducts.DataSource = DsCom.Tables[0];
                            LstProducts.DataValueField = "ProductID";
                            LstProducts.DataTextField = "ProductName";
                            LstProducts.DataBind();
                            LstProducts.Items.Insert(0, new ListItem("-- Select Item --", "-1"));
                        }
                        else if (Action == 2)
                        {
                            LstBrands.DataSource = DsCom.Tables[0];
                            LstBrands.DataValueField = "BrandID";
                            LstBrands.DataTextField = "BrandName";
                            LstBrands.DataBind();
                            LstBrands.Items.Insert(0, new ListItem("-- Select Item --", "-1"));
                        }
                        else if (Action == 3)
                        {
                            LstModels.DataSource = DsCom.Tables[0];
                            LstModels.DataValueField = "ModelID";
                            LstModels.DataTextField = "ModelName";
                            LstModels.DataBind();
                            LstModels.Items.Insert(0, new ListItem("-- Select Item --", "-1"));
                        }
                        else { }
                    }
                    else
                    {
                        //Nodata
                    }
                else
                {
                    //Connection Error
                }
            else
            {
                //Session expired
            }

        }

        protected void DtPrepare()
        {
            dt.Columns.Add("ProductID", typeof(Int64));
            dt.Columns.Add("ProductName", typeof(string));
            dt.Columns.Add("BrandID", typeof(Int64));
            dt.Columns.Add("BrandName", typeof(string));
            dt.Columns.Add("ModelID", typeof(Int64));
            dt.Columns.Add("ModelName", typeof(string));
            //dt.Columns.Add("AvailableStock", typeof(int));
            dt.Columns.Add("Qty", typeof(int));
            DataColumn dcID = new DataColumn("ID", typeof(int));
            dcID.AutoIncrement = true;
            dcID.AutoIncrementSeed = 1;
            dcID.AutoIncrementStep = 1;
            dt.Columns.Add(dcID);
            Session["dtPurchaseOrders"] = dt;
        }

        protected void LstProducts_OnTextChanged(object sender, EventArgs e)
        {
            ProductID = Convert.ToInt64(LstProducts.SelectedItem.Value);
            ProductName = LstProducts.SelectedItem.Text;
            LstBrands.Items.Clear();
            LstModels.Items.Clear();
            LoadListItems(2);
        }

        protected void LstBrands_OnTextChanged(object sender, EventArgs e)
        {
            ProductID = Convert.ToInt64(LstProducts.SelectedItem.Value);
            ProductName = LstProducts.SelectedItem.Text;
            BrandID = Convert.ToInt64(LstBrands.SelectedItem.Value);
            BrandName = LstBrands.SelectedItem.Text;
            LstModels.Items.Clear();
            LoadListItems(3);
        }

        protected void LstModels_OnTextChanged(object sender, EventArgs e)
        {
            ProductID = Convert.ToInt64(LstProducts.SelectedItem.Value);
            ProductName = LstProducts.SelectedItem.Text;
            BrandID = Convert.ToInt64(LstBrands.SelectedItem.Value);
            BrandName = LstBrands.SelectedItem.Text;
            ModelID = Convert.ToInt64(LstModels.SelectedItem.Value);
            ModelName = LstModels.SelectedItem.Text;
        }

        protected void btnAddToList_Click(object sender, EventArgs e)
        {
            int dd = LstProducts.SelectedIndex;
            if (Validation() == 1)
            {
                ProductID = Convert.ToInt64(LstProducts.SelectedItem.Value);
                ProductName = LstProducts.SelectedItem.Text;
                BrandID = Convert.ToInt64(LstBrands.SelectedItem.Value);
                BrandName = LstBrands.SelectedItem.Text;
                ModelID = Convert.ToInt64(LstModels.SelectedItem.Value);
                ModelName = LstModels.SelectedItem.Text;
                dt = (DataTable)Session["dtPurchaseOrders"];
                int _flag = 1;
                if (dt.Rows.Count > 0)
                    foreach (DataRow row in dt.Rows)
                    {
                        if (Convert.ToInt64(row[4].ToString()) == ModelID)
                        {
                            PageMessageUpdate(6, "Selected model already exists.");
                            _flag = 0;
                        }
                    }
                if (_flag == 1)
                {
                    dsa = ProdD.GetStockForModel(ModelID);
                    dt.Rows.Add(ProductID, ProductName, BrandID, BrandName, ModelID, ModelName, dsa.Tables[0].Rows[0][0], 0);
                    Session["dtPurchaseOrders"] = dt;
                    GvProductList.DataSource = dt;
                    GvProductList.DataBind();
                }

            }

        }
        protected int Validation()
        {
            if (LstProducts.SelectedIndex > 0)
                if (LstBrands.SelectedIndex > 0)
                    if (LstModels.SelectedIndex > 0)
                        return 1;
                    else
                    {
                        PageMessageUpdate(6, "Select a valid model.");                        
                        return 0;
                    }
                else
                {
                    PageMessageUpdate(6, "Select a valid brand.");
                    return 0;
                }
            else
            {
                PageMessageUpdate(6, "Select a valid Product.");
                return 0;
            }

        }
        protected void GvProductList_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "R")
            {
                int ID = Convert.ToInt32(e.CommandArgument.ToString());
                dt = (DataTable)Session["dtPurchaseOrders"];
                dt.Rows.RemoveAt(ID);
                GvProductList.DataSource = dt;
                GvProductList.DataBind();
                Session["dtPurchaseOrders"] = dt;
            }
            else if (e.CommandName == "U")
            {
                int ID = Convert.ToInt32(e.CommandArgument.ToString());
                dt = (DataTable)Session["dtPurchaseOrders"];

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


        protected void SetVisibility()
        {
            if (loadcase == 1) // Here most of the page controls are visible to the end users
            {
                pnlinput.Visible = true;
                pnlProductDeatils.Visible = true;
            }
            else if (loadcase == 2) // if suppose any receipt was made for the particular PO then need to hide the products add option here .
            {
                pnlinput.Visible = false;
                pnlProductDeatils.Visible = true;
            }
            else if(loadcase==3 || loadcase==4)
            {
                pnlinput.Visible = false;
                pnlProductDeatils.Visible = true;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            StockD objStockD = new StockD();
            string Result;
            dt = (DataTable)Session["dtPurchaseOrders"];
            /// this method will take input parameter as data table , UserID and remarks
            DataTable DtCurrentPurchaseOrder = new DataTable();
            DtCurrentPurchaseOrder.Columns.Add("ID");
            DtCurrentPurchaseOrder.Columns.Add("ModelID");
            DtCurrentPurchaseOrder.Columns.Add("OrderQty");
            DtCurrentPurchaseOrder.Columns.Add("CreateBy");
            
            foreach (GridViewRow GVRow in GvProductList.Rows)
            {                
                TextBox txtQty = (TextBox)GVRow.FindControl("gvtxtQty");
                HiddenField hdnModelID = (HiddenField)GVRow.FindControl("hdnModelID");
                DtCurrentPurchaseOrder.Rows.Add(1, Convert.ToInt64(hdnModelID.Value), Convert.ToInt32(txtQty.Text), Convert.ToInt32(Session["UserID"]));                
            }

            Result = objStockD.PurchaseOrdersBulkCopy(DtCurrentPurchaseOrder, Convert.ToInt32(Session["UserID"]), txtRemarks.Text);
            if (Result == "S") // Saved successfully.
            {
                btnSubmit.Visible = false;
                PageMessageUpdate(5, "Your data has been saved successfully.");             
            }
            else
            {
                // Error
                PageMessageUpdate(5, "Error : ." + Result); 
                
            }
        }

    }
}
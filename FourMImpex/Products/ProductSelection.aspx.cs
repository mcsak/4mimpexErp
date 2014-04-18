using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using FourMImpexClass.DAL;
using FourMImpex.UC;


namespace FourMImpex.Products
{
    public partial class ProductSelection : System.Web.UI.Page
    {
        protected DataSet DsCom=new DataSet();
        ProductsD ProdD = new ProductsD(); Int64 ProductID = 0, BrandID = 0, ModelID = 0;
        protected string ProductName, BrandName, ModelName; DataTable dt = new DataTable(); DataSet dsa = new DataSet();
        DataTable dt_ = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               // GvProductList.DataBind();
                LoadListItems(1);
                DtPrepare();

                lblSelectCust.Visible = false;
                divCustomer.Visible = false;
                ddlCustomers.Visible = false;
                txtCustomerName.Visible = false;
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
            dt.Columns.Add("AvailableStock", typeof(int));
            dt.Columns.Add("Qty", typeof(int));
            dt.Columns.Add("Price", typeof(double));
            DataColumn dcID = new DataColumn("ID", typeof(int));
            dcID.AutoIncrement = true;
            dcID.AutoIncrementSeed = 1;
            dcID.AutoIncrementStep = 1;
            dt.Columns.Add(dcID); 
            Session["dt"] = dt;
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
                dt = (DataTable)Session["dt"];
                int _flag = 1;
                /* Due to new request same model can be added twise
                if (dt.Rows.Count > 0)
                    foreach (DataRow row in dt.Rows)
                    {                        
                        if (Convert.ToInt64(row[4].ToString()) == ModelID)
                        {
                            PageMessageUpdate(6, "Selected model already exists.");                            
                            _flag = 0;
                        }                        
                    }    
                */
                if (_flag == 1)
                {
                    dsa = ProdD.GetStockForModel(ModelID);
                    if (Convert.ToInt32(dsa.Tables[0].Rows[0][0].ToString()) > 0)
                    {
                        dt.Rows.Add(ProductID, ProductName, BrandID, BrandName, ModelID, ModelName, dsa.Tables[0].Rows[0][0], 0, dsa.Tables[0].Rows[0][1], 0);
                        Session["dt"] = dt;
                        GvProductList.DataSource = dt;
                        GvProductList.DataBind();
                        GVFooterRowUpdate();
                        Updpnl.Update();
                    }
                    else
                    {
                        PageMessageUpdate(6, "There are no stock for selected model.");                                          
                    }
                    
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
                PageMessageUpdate(6, "Select a valid product.");            
                return 0;
            }
              
        }

        protected void gvtxtQty_OnTextChanged(object sender, EventArgs ee)
        {
            GridViewRow row = ((GridViewRow)((TextBox)sender).NamingContainer);            
            TextBox gvtxtQtyVal = (TextBox)row.FindControl("gvtxtQty");//hdnModelID            
            //TextBox gvtxtPriceVal = (TextBox)row.FindControl("gvtxtPrice");
            HiddenField Hdnval = (HiddenField)row.FindControl("hdnPrice");
            ((TextBox)row.FindControl("gvtxtPrice")).Text = (Convert.ToInt32(gvtxtQtyVal.Text) * (Convert.ToDouble(Hdnval.Value))).ToString();
            ((Label)row.FindControl("lblSysPriceVal")).Text = (Convert.ToInt32(gvtxtQtyVal.Text) * (Convert.ToDouble(Hdnval.Value))).ToString();
            GVFooterRowUpdate();
            Updpnl.Update();
        }

        protected void gvtxtPrice_OnTextChanged(object sender, EventArgs ee)
        {
            GVFooterRowUpdate();
            Updpnl.Update();
        }

        protected void GVFooterRowUpdate()
        {
            int TotalQty = 0;
            double TotalSystemPrice = 0, TotalCustomerPrice = 0;
            foreach (GridViewRow GvRow in GvProductList.Rows)
            {
                int txtQty = Convert.ToInt32(((TextBox)GvRow.FindControl("gvtxtQty")).Text);
                TotalQty = TotalQty + txtQty;
                double Amount = Convert.ToDouble(((HiddenField)GvRow.FindControl("hdnPrice")).Value); // This is for single piece price from admin module
                TotalSystemPrice = TotalSystemPrice + (Amount * txtQty);
                double CustomerPrice = Convert.ToDouble(((TextBox)GvRow.FindControl("gvtxtPrice")).Text);
                TotalCustomerPrice = TotalCustomerPrice + CustomerPrice;
            }

            GridViewRow GvFooterRow = GvProductList.FooterRow;// lblTotalQty lblTotalPrice lblSysPriceTotal
            ((Label)GvFooterRow.FindControl("lblTotalQty")).Text = TotalQty.ToString();
            ((Label)GvFooterRow.FindControl("lblTotalPrice")).Text = TotalCustomerPrice.ToString();
            ((Label)GvFooterRow.FindControl("lblSysPriceTotal")).Text = TotalSystemPrice.ToString();
        }

        protected void GvProductList_OnRowCommand(object sender,GridViewCommandEventArgs e)
        {
            if (e.CommandName == "R")
            {
                int ID = Convert.ToInt32(e.CommandArgument.ToString());
                dt = (DataTable)Session["dt"];
                dt.Rows.RemoveAt(ID);
                GvProductList.DataSource = dt;
                GvProductList.DataBind();
                GVFooterRowUpdate();
                Session["dt"]=dt;
            }
            else if (e.CommandName == "U")
            {
                int ID = Convert.ToInt32(e.CommandArgument.ToString());
                dt = (DataTable)Session["dt"];
                
            }
            Updpnl.Update();
           
        }

        //protected void GvProductList_OnRowCreated(object sender, GridViewRowEventArgs e)
        //{
        //    dt = (DataTable)Session["dt"];
        //    if (e.Row.RowType== DataControlRowType.Footer)
        //    {

        //        GVFooterRowUpdate();

        //    }
        //    Updpnl.Update();
        //}

        protected void btnSellProduct_Click(object sender, EventArgs e)
        {
            int returnvalue = ValidateStock();
            if (returnvalue == 99999)
            {
                StockD objStockD = new StockD();
                DataTable dtIssue=new DataTable();
                dtIssue.Columns.Add("ID");
                dtIssue.Columns.Add("ModelID");
                dtIssue.Columns.Add("Qty");
                dtIssue.Columns.Add("UserID");
                dtIssue.Columns.Add("Amount");
                foreach (GridViewRow GvRow in GvProductList.Rows)
                {
                    int txtQty = Convert.ToInt32(((TextBox)GvRow.FindControl("gvtxtQty")).Text);
                    long ModelID = Convert.ToInt64(((HiddenField)GvRow.FindControl("hdnModelID")).Value);
                    double Amount = Convert.ToDouble(((TextBox)GvRow.FindControl("gvtxtPrice")).Text); // This is for customer piece price from seller input
                    dtIssue.Rows.Add(GvRow.RowIndex, ModelID, txtQty, Convert.ToInt32(Session["UserID"]),Amount);
                }
               string Result= objStockD.IssueToCustomer(dtIssue, Convert.ToInt32(Session["UserID"]), "OK",txtCustomerName.Text,txtContact.Text,txtEmailID.Text,txtOthers.Text);
               if (Result.Contains(','))
               {                   
                   if (Result.Split(',').First() == "S")
                   {
                       btnSellProduct.Visible = false;
                       PageMessageUpdate(5, "Successfully issued to customer. Billing ID : " + Result.Split(',').Last());                       
                       System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "Script", "PrintDetails();", true);
                   }
               }
               else
               {
                   PageMessageUpdate(6, "Error in Issue to customer.");
               }
                                
            }
            else
            {
                PageMessageUpdate(6, "Enter a Qty less than or equal to Avilable Qty at row " + (returnvalue + 1).ToString() + ". Also it should not be zero");               
            }
        }

        protected int ValidateStock()
        {
            dt = (DataTable)Session["dt"];
            for (int i = 0; i < GvProductList.Rows.Count; i++)
            {
                TextBox txtQty = (TextBox)(GvProductList.Rows[i].FindControl("gvtxtQty"));//gvtxtQty
                int QtyVal = Convert.ToInt32(txtQty.Text);
                
                if (Convert.ToInt32(dt.Rows[i][6].ToString()) < QtyVal || QtyVal==0)
                {
                    // Continue 
                    return i;
                }
                else
                {
                    dt.Rows[i][7] = QtyVal;
                }
            }
            return 99999;       
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
        protected void rbtnNewCust_CheckedChanged(object sender, EventArgs e)
        {
            if (rbtnNewCust.Checked == true)
            {
                divCustomer.Visible = true;
                ddlCustomers.Visible = false;
                lblSelectCust.Visible = false;
                txtCustomerName.Visible = true;
            }
        }

        protected void rbtnExistingCustomer_CheckedChanged(object sender, EventArgs e)
        {
            if (rbtnExistingCustomer.Checked == true)
            {
                lblSelectCust.Visible = true;
                divCustomer.Visible = false;
                ddlCustomers.Visible = true;
                txtCustomerName.Visible = false;
                DataSet DsCustomers = new DataSet();
                DsCustomers=ProdD.GetDDLCustomers();
                DsCustomers=ProdD.GetDDLCustomers();
                if(DsCustomers!=null)
                if(DsCustomers.Tables.Count>0)
                    if (DsCustomers.Tables[0].Rows.Count > 0)
                    {
                        ddlCustomers.DataSource = DsCustomers.Tables[0];
                        ddlCustomers.DataTextField = "CustomerName";
                        ddlCustomers.DataValueField = "CustomerID";
                        ddlCustomers.DataBind();
                        ddlCustomers.Items.Insert(0, new ListItem("<--Select-->", "0"));
                    }
            }
        }

        protected void ddlCustomers_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet DsCustomers = new DataSet();
            if (ddlCustomers.SelectedItem.ToString() != "<--Select-->" || ddlCustomers.SelectedItem.ToString() != "0")
            {
                divCustomer.Visible = true;
                DsCustomers = ProdD.GetDDLCustomers(Convert.ToInt64(ddlCustomers.SelectedValue.ToString()));
                if(DsCustomers!=null)
                    if(DsCustomers.Tables.Count>0)
                        if (DsCustomers.Tables[0].Rows.Count > 0)
                        {
                            txtCustomerName.Text = DsCustomers.Tables[0].Rows[0]["CustomerName"].ToString();
                            txtContact.Text = DsCustomers.Tables[0].Rows[0]["ContactNumber"].ToString();
                            txtEmailID.Text = DsCustomers.Tables[0].Rows[0]["EmailAddress"].ToString();
                            txtOthers.Text = DsCustomers.Tables[0].Rows[0]["Address"].ToString();
                        }
            }
            else
                divCustomer.Visible = false;
        }



    }
}
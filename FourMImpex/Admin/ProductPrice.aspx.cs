using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FourMImpexClass.DAL;
using FourMImpex.UC;

namespace FourMImpex.Admin
{
    public partial class ProductPrice : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        AdminBusiness dAdmin = new AdminBusiness();
        int loadcase;
        Int64 PriceID;

        protected void Page_Load(object sender, EventArgs e)
        {
           loadcase = Convert.ToInt16(Request.QueryString["op"]);
           
            if (!IsPostBack)
            {
                BindProductList();
                if (loadcase == 1)
                {
                    Title = "Manage Price - Add";
                    headertitle.InnerHtml = "Manage Price - Add";
                    btnSubmit.Text = "Submit";
                    if (Request.QueryString["nav"] != null)
                    {
                        if (Request.QueryString["nav"].ToString() == "1")
                        {
                            btnBack.PostBackUrl = "~/Welcome.aspx";
                        }
                    }
                }
                else if (loadcase == 2)
                {
                    Title = "Manage Price - Modify";
                    headertitle.InnerHtml = "Manage Price - Modify";
                    btnSubmit.Text = "Modify";
                    PriceID = Convert.ToInt16(Request.QueryString["RID"]);
                    BindPricing(PriceID);
                }
                else if (loadcase == 3)
                {
                    Title = "Manage Price - Delete";
                    headertitle.InnerHtml = "Manage Price - Delete";
                    btnSubmit.Text = "Delete";
                    ddlProduct.Enabled = false;
                    ddlBrand.Enabled = false;
                    ddlModel.Enabled = false;
                    txtPrice.Enabled = false;
                    txtDescription.Enabled = false;
                    txtDiscount.Enabled = false;
                    PriceID = Convert.ToInt16(Request.QueryString["RID"]);
                    BindPricing(PriceID);
                }
            }

        }

        //bind product in dropdown

        public void BindProductList()
        {
            ds = new DataSet();
            ds = dAdmin.BindProductList();
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlProduct.Items.Clear();
                        ddlProduct.DataTextField = "ProductName";
                        ddlProduct.DataValueField = "ProductID";
                        ddlProduct.DataSource = ds;
                        ddlProduct.DataBind();
                        ddlProduct.Items.Insert(0, new ListItem("--Select--", "0"));
                    }
                    else
                    {
                        ddlProduct.Items.Clear();
                        ddlProduct.Items.Insert(0, new ListItem("--No Data--", "0"));
                    }
                }
            }
        }

        // bind Brand in Drop down


        public void BindBrandList(Int64 ProductID)
        {
            ds = new DataSet();
            ds = dAdmin.BindBrandList(ProductID);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlBrand.Items.Clear();
                        ddlBrand.DataTextField = "BrandName";
                        ddlBrand.DataValueField = "BrandID";
                        ddlBrand.DataSource = ds;
                        ddlBrand.DataBind();
                        ddlBrand.Items.Insert(0, new ListItem("--Select--", "0"));
                    }
                    else
                    {
                        ddlBrand.Items.Clear();
                        ddlBrand.Items.Insert(0, new ListItem("--No Data--", "0"));
                    }
                }
            }
        }
        //get brand details for selected items

        public void BindPricing(Int64 PriceID)
        {
            ds = new DataSet();
            ds = dAdmin.BindPricing(PriceID);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlProduct.SelectedValue = ds.Tables[0].Rows[0]["ProductID"].ToString();
                        ddlBrand.SelectedValue = ds.Tables[0].Rows[0]["BrandID"].ToString();
                        ddlModel.SelectedValue = ds.Tables[0].Rows[0]["ModelID"].ToString();
                        txtPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();
                        txtDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                        txtDiscount.Text = ds.Tables[0].Rows[0]["Discount"].ToString();
                    }
                }
            }
        }

        //IUD functionality

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Int64 UserID = Convert.ToInt64(Session["UserID"]);
            
            Int64 ProductID = Convert.ToInt64(ddlProduct.SelectedValue);
            Int64 BrandID = Convert.ToInt64(ddlBrand.SelectedValue);
            Int64 ModelID = Convert.ToInt64(ddlModel.SelectedValue);
            if (txtPrice.Text.Trim() != "")
            {
                if (loadcase == 1)
                {
                    ds = dAdmin.IUDPrice(ProductID, BrandID,ModelID, 0, txtPrice.Text.Trim(), txtDescription.Text.Trim(),Convert.ToByte( txtDiscount.Text.Trim()), UserID, loadcase);
                }
                else
                {
                    ModelID = Convert.ToInt16(Request.QueryString["RID"]);
                    ds = dAdmin.IUDPrice(ProductID, BrandID, ModelID, PriceID, txtPrice.Text.Trim(), txtDescription.Text.Trim(),Convert.ToByte( txtDiscount.Text.Trim()), UserID, loadcase);
                }
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows[0]["Result"].ToString() == "S")
                        {
                            btnSubmit.Visible = false;
                            btnBack.Text = "Back";
                            ((PageMessage)(Page.Master.FindControl("PageMessage"))).SuccessMessage("Your data has been added successfully.");
                            btnBack.PostBackUrl = "~/Admin/BrandGrid.aspx";
                        }
                        else if (ds.Tables[0].Rows[0]["Result"].ToString() == "U")
                        {
                            btnSubmit.Visible = false;
                            btnBack.Text = "Back";
                            ((PageMessage)(Page.Master.FindControl("PageMessage"))).SuccessMessage("Your data has been updated successfully.");
                        }
                        else if (ds.Tables[0].Rows[0]["Result"].ToString() == "D")
                        {
                            btnSubmit.Visible = false;
                            btnBack.Text = "Back";
                            ((PageMessage)(Page.Master.FindControl("PageMessage"))).SuccessMessage("Your data has been deleted successfully.");
                        }
                        else if (ds.Tables[0].Rows[0]["Result"].ToString() == "AEx")
                        {
                            ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("This record already exists.");
                        }
                    }
                }

            }
            else
            {
                 ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Enter the price.");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ProductPriceGrid.aspx");
        }

        protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int64 ProductID = Convert.ToInt64(ddlProduct.SelectedValue);
            BindBrandList(ProductID);
        }

        protected void ddlBrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int64 BrandID = Convert.ToInt64(ddlBrand.SelectedValue);
            BindModelList(BrandID);
        }


        public void BindModelList(Int64 BrandID)
        {
            ds = new DataSet();
            ds = dAdmin.BindModelList(BrandID);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlModel.Items.Clear();
                        ddlModel.DataTextField = "ModelName";
                        ddlModel.DataValueField = "ModelID";
                        ddlModel.DataSource = ds;
                        ddlModel.DataBind();
                        ddlModel.Items.Insert(0, new ListItem("--Select--", "0"));
                    }
                    else
                    {
                        ddlModel.Items.Clear();
                        ddlModel.Items.Insert(0, new ListItem("--No Data--", "0"));
                    }
                }
            }
        }
    }
}
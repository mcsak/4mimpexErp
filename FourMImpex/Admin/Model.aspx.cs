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
    public partial class Model : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        AdminBusiness dAdmin = new AdminBusiness();
        int loadcase, ModelID;

        protected void Page_Load(object sender, EventArgs e)
        {
           btnBack.PostBackUrl = "~/Admin/ModelGrid.aspx";
           loadcase = Convert.ToInt16(Request.QueryString["op"]);
            if (!IsPostBack)
            {
                BindProductList();
                if (loadcase == 1)
                {
                    Title = "Model - Add";
                    headertitle.InnerHtml = "Model - Add";
                    btnSubmit.Text = "Submit";
                    ddlProduct.Enabled =true;
                    ddlBrand.Enabled = true;
                    txtModel.Enabled =true;
                    txtDescription.Enabled =true;
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
                    Title = "Model - Modify";
                    headertitle.InnerHtml = "Model - Modify";
                    btnSubmit.Text = "Modify";
                    ddlProduct.Enabled = false;
                    ddlBrand.Enabled = false;
                    ModelID = Convert.ToInt16(Request.QueryString["RID"]);
                    BindModel(ModelID);
                  
                }
                else if (loadcase == 3)
                {
                    Title = "Brand - Delete";
                    headertitle.InnerHtml = "Brand - Delete";
                    btnSubmit.Text = "Delete";
                    ddlProduct.Enabled = false;
                    ddlBrand.Enabled = false;
                    txtModel.Enabled = false;
                    txtDescription.Enabled = false;
                    ModelID = Convert.ToInt16(Request.QueryString["RID"]);
                    BindModel(ModelID);
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

        public void BindModel(Int64 ModelID)
        {
            ds = new DataSet();
            ds = dAdmin.BindModel(ModelID);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlProduct.SelectedValue = ds.Tables[0].Rows[0]["ProductID"].ToString();
                        String ProdID = ds.Tables[0].Rows[0]["ProductID"].ToString();
                        Int64 p =Convert.ToInt64(ProdID);
                         String s = ds.Tables[0].Rows[0]["BrandID"].ToString();
                        txtModel.Text = ds.Tables[0].Rows[0]["ModelName"].ToString();
                        txtDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                        BindBrandList(p);
                        ddlBrand.SelectedValue = s;
                    }
                }
            }
        }

        //IUD functionality

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Int64 UserID = Convert.ToInt64(Session["UserID"]);
            
            Int64 ProductID = Convert.ToInt64(ddlProduct.SelectedValue);
            Int64 BrandID=Convert.ToInt64(ddlBrand.SelectedValue);
            if (txtModel.Text.Trim() != "")
            {
                if (loadcase == 1)
                {
                    ds = dAdmin.IUDModel(ProductID,BrandID, 0, txtModel.Text.Trim(), txtDescription.Text.Trim(), UserID, loadcase);
                }
                else
                {
                    ModelID = Convert.ToInt16(Request.QueryString["RID"]);
                    ds = dAdmin.IUDModel(ProductID, BrandID,ModelID ,txtModel.Text.Trim(), txtDescription.Text.Trim(), UserID, loadcase);
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
                            btnBack.PostBackUrl = "~/Admin/ModelGrid.aspx";
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
                 ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Enter the model name.");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/BrandGrid.aspx");
        }

        protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int64 ProductID = Convert.ToInt64(ddlProduct.SelectedValue);
            BindBrandList(ProductID);
        }

    }
}
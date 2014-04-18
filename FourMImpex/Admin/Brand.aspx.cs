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
    public partial class Brand : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        AdminBusiness dAdmin = new AdminBusiness();
        int loadcase, BrandID;

        protected void Page_Load(object sender, EventArgs e)
        {
            loadcase = Convert.ToInt16(Request.QueryString["op"]);
            btnBack.PostBackUrl = "~/Admin/BrandGrid.aspx";
            if (!IsPostBack)
            {
                BindProductList();
                if (loadcase == 1)
                {
                    Title = "Brand - Add";
                    headertitle.InnerHtml = "Brand - Add";
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
                    Title = "Brand - Modify";
                    headertitle.InnerHtml = "Brand - Modify";
                    btnSubmit.Text = "Modify";
                    BrandID = Convert.ToInt16(Request.QueryString["RID"]);
                    BindBrand(BrandID);
                    ddlProduct.Enabled = false;
                }
                else if (loadcase == 3)
                {
                    Title = "Brand - Delete";
                    headertitle.InnerHtml = "Brand - Delete";
                    btnSubmit.Text = "Delete";
                    txtBrand.Enabled = false;
                    ddlProduct.Enabled = false;
                    txtBrandDescription.Enabled = false;
                    BrandID = Convert.ToInt16(Request.QueryString["RID"]);
                    BindBrand(BrandID);
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

        //get brand details for selected items

        public void BindBrand(Int64  BrandID)
        {
            ds = new DataSet();
            ds = dAdmin.BindBrand(BrandID);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlProduct.SelectedValue = ds.Tables[0].Rows[0]["ProductID"].ToString();
                        txtBrand.Text = ds.Tables[0].Rows[0]["BrandName"].ToString();
                        txtBrandDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                    }
                }
            }
        }

        //IUD functionality

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Int64 UserID = Convert.ToInt64(Session["UserID"]);            
            Int64 ProductID = Convert.ToInt64(ddlProduct.SelectedValue);
            if (txtBrand.Text.Trim() != "")
            {
                if (loadcase == 1)
                {
                    ds = dAdmin.IUDBrand(ProductID,0, txtBrand.Text.Trim(), txtBrandDescription.Text.Trim(), UserID, loadcase);
                }
                else
                {
                    BrandID = Convert.ToInt16(Request.QueryString["RID"]);
                    ds = dAdmin.IUDBrand(ProductID,BrandID, txtBrand.Text.Trim(), txtBrandDescription.Text.Trim(), UserID, loadcase);
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
                        else if (ds.Tables[0].Rows[0]["Result"].ToString() == "ND")
                        {
                            ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Delete the model related to this brand before delete this record..");
                        }
                    }
                }

            }
            else
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Enter the Brand name.");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/BrandGrid.aspx");
        }
    }
}
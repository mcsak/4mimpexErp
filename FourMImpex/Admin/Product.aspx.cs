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
    public partial class Product : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        AdminBusiness dAdmin = new AdminBusiness();
        int loadcase, ProductID;

        protected void Page_Load(object sender, EventArgs e)
        {
           loadcase = Convert.ToInt16(Request.QueryString["op"]);

            if (!IsPostBack)
            {
                if (loadcase == 1)
                {
                    Title = "Product - Add";
                    headertitle.InnerHtml = "Product - Add";
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
                    Title = "Product - Modify";
                    headertitle.InnerHtml = "Product - Modify";
                    btnSubmit.Text = "Modify";
                    ProductID = Convert.ToInt16(Request.QueryString["RID"]);                    
                    BindProduct(ProductID);
                }
                else if (loadcase == 3)
                {
                    Title = "Product - Delete";
                    headertitle.InnerHtml = "Product - Delete";
                    btnSubmit.Text = "Delete";
                    txtProduct.Enabled = false;
                    txtProductDescription.Enabled = false;
                    ProductID = Convert.ToInt16(Request.QueryString["RID"]);
                    BindProduct(ProductID);
                }

            }

        }


        public void BindProduct(int ProductID)
        {
            ds = new DataSet();
            ds = dAdmin.BindProduct(ProductID);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        txtProduct.Text = ds.Tables[0].Rows[0]["ProductName"].ToString();
                        txtProductDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Int64 UserID = Convert.ToInt64(Session["UserID"]);
           
            if (txtProduct.Text.Trim() != "")
            {
                if (loadcase == 1)
                {
                    ds = dAdmin.IUDProduct(0, txtProduct.Text.Trim(),txtProductDescription.Text.Trim(), UserID, loadcase);
                }
                else
                {
                    ProductID = Convert.ToInt16(Request.QueryString["RID"]);
                    ds = dAdmin.IUDProduct(ProductID, txtProduct.Text.Trim(),txtProductDescription.Text.Trim(), UserID, loadcase);
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
                            btnBack.PostBackUrl = "~/Admin/ProductGrid.aspx";
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
                            ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Delete the brand related to this product before delete this record.");
                        }
                    }
                }

            }
            else
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Enter the Product name.");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ProductGrid.aspx");
        }
    }
}
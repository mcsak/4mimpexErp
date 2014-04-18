using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using FourMImpexClass.DAL;
using FourMImpex.UC;

namespace FourMImpex.Admin
{
    public partial class ModelGrid : System.Web.UI.Page
    {
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["SortDir"] = "";
                ViewState["SortColIndex"] = "";
                Title = "Model";
                imgSearch.ImageUrl = "~/Images/searchicongrid.png";
                ddlsearchby.Items.Clear();
                ddlsearchby.Items.Insert(0, new ListItem("--Select--", "0"));
                ddlsearchby.Items.Insert(1, new ListItem("Product Name", "1"));
                ddlsearchby.Items.Insert(2, new ListItem("Brand Name", "2"));
                ddlsearchby.Items.Insert(3, new ListItem("Model Name", "3"));
                GridBind();
            }
        }

        public void GridBind(string searchtext = "", int key = 0)
        {
            AdminBusiness adminbus = new AdminBusiness();
            if (searchtext == "" && key == 0)
            {

                ds = adminbus.GridModel(searchtext, key);
                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ViewState["Grid"] = ds;
                        gvModel.DataSource = ds;
                        gvModel.DataBind();
                        if (ViewState["SortColIndex"].ToString() != "")
                        {
                            HtmlImage imgSort = new HtmlImage();
                            imgSort.Align = "AppsMiddle";
                            imgSort.Style.Add("margin-top", "5px");
                            imgSort.Style.Add("margin-left", "3px");
                            if (ViewState["SortDir"].ToString() == "DESC")
                            {
                                imgSort.Src = "~/Images/sort_desc.gif";
                            }
                            else
                            {
                                imgSort.Src = "~/Images/sort_asc.gif";
                            }

                            gvModel.HeaderRow.Cells[Convert.ToInt16(ViewState["SortColIndex"].ToString())].Controls.Add(imgSort);
                        }
                    }
                    else
                    {
                        gvModel.Visible = false;
                        Response.Redirect("~/Admin/Model.aspx?RID=0&op=1");
                    }
                }
            }
            else
            {
                ds = adminbus.GridModel(searchtext, key);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ViewState["Grid"] = ds;
                    gvModel.DataSource = ds;
                    gvModel.DataBind();
                    if (ViewState["SortColIndex"].ToString() != "")
                    {
                        HtmlImage imgSort = new HtmlImage();
                        imgSort.Align = "AppsMiddle";
                        if (ViewState["SortDir"].ToString() == "DESC")
                        {
                            imgSort.Src = "~/Images/sort_desc.gif";
                        }
                        else
                        {
                            imgSort.Src = "~/Images/sort_asc.gif";
                        }

                        gvModel.HeaderRow.Cells[Convert.ToInt16(ViewState["SortColIndex"].ToString())].Controls.Add(imgSort);
                    }
                }
                else
                {
                    ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("No matching records found.");
                }
            }
        }





        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            if (imgSearch.CommandArgument == "S")
            {
                if (ddlsearchby.SelectedIndex == 0)
                {
                    ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("select a search by.");
                }
                else if (txtsearch.Text == "")
                {
                    ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Enter the search text.");
                }
                GridBind(txtsearch.Text.Trim(), Convert.ToInt16(ddlsearchby.SelectedValue));
                imgSearch.ImageUrl = "~/Images/cancelsearch.png";
                imgSearch.ToolTip = "Close";
                imgSearch.CommandArgument = "C";
                txtsearch.Enabled = false;
            }
            else
            {
                ViewState["SearchText"] = null;
                ddlsearchby.SelectedIndex = 0;
                GridBind();
                imgSearch.ImageUrl = "~/Images/searchicongrid.png";
                imgSearch.ToolTip = "Go";
                imgSearch.CommandArgument = "S";
                txtsearch.Text = "";
                ((System.Web.UI.HtmlControls.HtmlContainerControl)(Page.Master.FindControl("PageMessage").FindControl("infomsg"))).Style.Add("visibility", "hidden");
                txtsearch.Enabled = true;
            }
        }

        private void GridSort(GridView gv)
        {
            DataView dv = new DataView();
            DataTable dt;
            ds = (DataSet)ViewState["Grid"];
            dv = new DataView(ds.Tables[0]);
            dv.Sort = ViewState["SortExp"] + " " + ViewState["SortDir"];
            gv.DataSource = dv;
            dt = dv.ToTable();
            DataSet ds1 = new DataSet();
            ds1.Tables.Add(dt.Copy());
            ViewState["Grid"] = ds1;
            gv.DataBind();
        }

        protected void gvModel_Sorting(object sender, GridViewSortEventArgs e)
        {
            string[] arrSort = e.SortExpression.ToString().Split('|');
            ViewState["SortExp"] = arrSort[0];
            if ((ViewState["SortColIndex"].ToString() != arrSort[1]) || (ViewState["SortColIndex"].ToString() == ""))
            {
                ViewState["SortDir"] = "ASC";
            }
            else
            {
                if (ViewState["SortDir"].ToString() == "ASC")
                {
                    ViewState["SortDir"] = "DESC";
                }
                else
                {
                    ViewState["SortDir"] = "ASC";
                }
            }
            ViewState["SortColIndex"] = arrSort[1];
            GridSort(gvModel);
            if (ViewState["SortColIndex"].ToString() != "")
            {
                HtmlImage imgSort = new HtmlImage();
                imgSort.Align = "AppsMiddle";
                if (ViewState["SortDir"].ToString() == "DESC")
                {
                    imgSort.Src = "~/Images/sort_desc.gif";
                }
                else
                {
                    imgSort.Src = "~/Images/sort_asc.gif";
                }
                gvModel.HeaderRow.Cells[Convert.ToInt16(ViewState["SortColIndex"])].Controls.Add(imgSort);
            }
        }
        protected void gvModel_SelectedIndexChanged(object sender, GridViewPageEventArgs e)
        {
            gvModel.PageIndex = e.NewPageIndex;
            ds = (DataSet)ViewState["Grid"];
            gvModel.DataSource = ds;
            gvModel.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/Model.aspx?RID=0&op=1");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int RId = Convert.ToInt16(Request.Form["OptID"]);
            Response.Redirect("~/Admin/Model.aspx?RID=" + RId + "&op=2");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int RId = Convert.ToInt16(Request.Form["OptID"]);
            Response.Redirect("~/Admin/Model.aspx?RID=" + RId + "&op=3");
        }
    }
}
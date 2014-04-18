﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FourMImpexClass.DAL;
using FourMImpex.UC;
using System.Data;

namespace FourMImpex.Reports
{
    public partial class SalesReceiptReport : System.Web.UI.Page
    {
        string Fromdate;
        string Todate;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFrom.Attributes.Add("readonly", "readonly");
                txtto.Attributes.Add("readonly", "readonly");
                txtFrom.Text = DateTime.Today.ToString("dd/MMM/yyyy");
                txtto.Text = DateTime.Today.ToString("dd/MMM/yyyy");
            }
            Title = "Sales Receipt Reports ";
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
                BindGridView(txtsearch.Text.Trim(), Convert.ToInt16(ddlsearchby.SelectedValue));
                imgSearch.ImageUrl = "~/Images/cancelsearch.png";
                imgSearch.ToolTip = "Close";
                imgSearch.CommandArgument = "C";
                txtsearch.Enabled = false;
            }
            else
            {
                ViewState["SearchText"] = null;
                ddlsearchby.SelectedIndex = 0;
                BindGridView();
                imgSearch.ImageUrl = "~/Images/searchicongrid.png";
                imgSearch.ToolTip = "Go";
                imgSearch.CommandArgument = "S";
                txtsearch.Text = "";
                ((System.Web.UI.HtmlControls.HtmlContainerControl)(Page.Master.FindControl("PageMessage").FindControl("infomsg"))).Style.Add("visibility", "hidden");
                txtsearch.Enabled = true;
            }
        }
        protected void btnView_Click(object sender, System.EventArgs e)
        {
            GvReceiptReport.AllowPaging = true;
            GvReceiptReport.PageSize = 10;
            BindGridView();

        }
        public void BindGridView(string searchtext = "", int key = 0)
        {
            if (validation() == 1)
            {
                DataSet ds;
                string dtfrom = DateTime.Parse(txtFrom.Text).ToString("yyyyMMdd");
                string dtto = DateTime.Parse(txtto.Text).ToString("yyyyMMdd");
                ReportsD rpt = new ReportsD();
                ds = rpt.rptSalesReceipt(dtfrom, dtto, searchtext, key);
                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            GvReceiptReport.DataSource = ds;
                            ViewState["gv"] = ds.Tables[0];
                            GvReceiptReport.DataBind();
                            pnlcontainer.Visible = true;
                        }
                        else
                        {
                            ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Currently there is no record.");
                        }
                    }
                }
            }
        }
        public byte validation()
        {
            if (string.IsNullOrEmpty(txtFrom.Text))
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Select the from date.");
                pnlcontainer.Visible = false;
                return 0;
            }
            else
            {
                Fromdate = txtFrom.Text.Trim();
            }
            if (string.IsNullOrEmpty(txtto.Text))
            {
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Select the to date.");
                pnlcontainer.Visible = false;
                return 0;
            }
            else
            {
                Todate = txtto.Text.ToString();
            }
            if (!string.IsNullOrEmpty(txtFrom.Text) & !string.IsNullOrEmpty(txtto.Text))
            {
                DateTime fromDate = DateTime.Parse(txtFrom.Text);
                System.DateTime toDate = DateTime.Parse(txtto.Text);
                TimeSpan TimeSpan = default(TimeSpan);
                int NumberOfDays = 0;
                TimeSpan = toDate.Subtract(fromDate);
                NumberOfDays = TimeSpan.Days;
                if (NumberOfDays < 0)
                {
                    ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("From date cannot be greater than to date.");
                    pnlcontainer.Visible = false;
                    return 0;
                }
            }
            return 1;
        }
        public void exportexcel()
        {
            Control parent = GvReceiptReport.Parent;
            int GridIndex = 0;
            if (parent != null)
            {
                GridIndex = parent.Controls.IndexOf(GvReceiptReport);
                parent.Controls.Remove(GvReceiptReport);
            }

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=test.xls");
            Response.ContentType = "application/excel";
            System.IO.StringWriter sw = new System.IO.StringWriter();
            HtmlTextWriter htm = new HtmlTextWriter(sw);
            GvReceiptReport.RenderControl(htm);
            Response.Write(sw.ToString());
            Response.End();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            exportexcel();
        }      
    }
}
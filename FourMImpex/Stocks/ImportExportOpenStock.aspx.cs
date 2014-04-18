using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.OleDb;
using System.Data;
using System.Data.SqlClient;
using FourMImpexClass.DAL;
using FourMImpex.UC;

namespace FourMImpex.Stocks
{
    public partial class ImportExportOpenStock : System.Web.UI.Page
    {
        DBExecution dbex = new DBExecution();
        string Loadcase;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Loadcase = Request.QueryString["LoadCase"];
                BindGridView();                
                GVColumnsVisibility(0);
                GvOpenStockExport.DataBind();
                lnkCheckanyunimportedData.Visible = false;
                ddlsearchby.Items.Clear();
                ddlsearchby.Items.Insert(0, new ListItem("--Select--", "0"));
                ddlsearchby.Items.Insert(1, new ListItem("Brand Name", "2"));
                ddlsearchby.Items.Insert(2, new ListItem("Model Name", "3"));
                if (Loadcase == "2")
                {
                    //InnerMaster inm = Master as InnerMaster;
                    //((PageMessageLatest)(Page.Master.FindControl("pagemsg"))).InfoMessage("All stocks are imported successfully.");
                    //UpdatePanel updpnls = (UpdatePanel)inm.FindControl("updpnlMaster");
                    //updpnls.Update();
                    //PageMessageUpdate(5, "All stocks are imported successfully.");
                    btnSubmit.Visible = false;
                    lnkCheckanyunimportedData.Visible = false;
                }
            }
        }

        protected void GVColumnsVisibility(sbyte Flag = 0)
        {
            if (Flag == 0) // Hide all the ID based columns in Grid 
            {
                GvOpenStockExport.Columns[0].HeaderText = "#";
                GvOpenStockExport.Columns[1].Visible = false;
                GvOpenStockExport.Columns[2].Visible = false;
                GvOpenStockExport.Columns[3].HeaderText = "Product Name";
                GvOpenStockExport.Columns[4].Visible = false;
                GvOpenStockExport.Columns[5].HeaderText = "Brand Name";
                GvOpenStockExport.Columns[6].Visible = false;
                GvOpenStockExport.Columns[7].HeaderText = "Model Name";
                
            }
            else if (Flag == 1) // Show all the ID based columns in Grid to export to excel
            {
                GvOpenStockExport.Columns[0].HeaderText = "ID";
                GvOpenStockExport.Columns[1].Visible = true;
                GvOpenStockExport.Columns[2].Visible = true;
                GvOpenStockExport.Columns[3].HeaderText = "ProductName";
                GvOpenStockExport.Columns[4].Visible = true;
                GvOpenStockExport.Columns[5].HeaderText = "BrandName";
                GvOpenStockExport.Columns[6].Visible = true;
                GvOpenStockExport.Columns[7].HeaderText = "ModelName";

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            StockD ObjStockD = new StockD();
          // Provider=Microsoft.ACE.OLEDB.12.0;Data Source=c:\myFolder\myExcel2007file.xlsx;
            //Extended Properties="Excel 12.0 Xml;HDR=YES";
            string filename = FileupdImport.PostedFile.FileName;           
            string tempName = Guid.NewGuid().ToString();
            FileupdImport.PostedFile.SaveAs(Server.MapPath(@"temp\\"+tempName+".xls"));
            string fileLoc = Server.MapPath(@"temp\\" + tempName + ".xls");
            string ConStrOLEDB = ConfigurationManager.AppSettings[@"XLSConnectionStringPart1"] + fileLoc + @"; Extended Properties=" + '"' + @"Excel 12.0 Xml;HDR=YES" + '"' + ";";
            if (FileupdImport.HasFile)
            {
               
                OleDbConnection connx = new OleDbConnection(ConStrOLEDB);
                OleDbCommand cmd = new OleDbCommand("select * from [OpenStock$]", connx);
                DataTable dt = new DataTable();
                dt.Columns.Add("ID");
                dt.Columns.Add("StockID");
                dt.Columns.Add("ProductID");
                dt.Columns.Add("ProductName");
                dt.Columns.Add("BrandID");
                dt.Columns.Add("BrandName");
                dt.Columns.Add("ModelID");
                dt.Columns.Add("ModelName");
                dt.Columns.Add("SerialNo");
                dt.Columns.Add("Remarks");
                dt.Columns.Add("Qty");
                connx.Open();
                try
                {
                    OleDbDataReader dr;
                    dr = cmd.ExecuteReader();
                    dt.Load(dr);                 
                    connx.Close();
                    if (System.IO.File.Exists(fileLoc))
                    {
                        System.IO.File.Delete(fileLoc);
                    }
                    //FileupdImport.SaveAs(Server.MapPath("~")+"/Temp/");
                }
                catch (Exception ee)
                {                    
                    connx.Close();
                }

                
                string Result;
                Result = ObjStockD.OpenStockBulkImport(dt, Convert.ToInt32(Session["UserID"]));
                if (Result == "S")
                {                   
                    PageMessageUpdate(5, "All stocks are imported successfully.");
                    btnSubmit.Visible = false;
                    lnkCheckanyunimportedData.Visible = true;
                    //((PageMessageLatest)(Page.Master.FindControl("PageMessage"))).InfoMessage("Imported Successfully.");
                }
                else
                {
                    PageMessageUpdate(6, "Error : "+Result);
                    // ((PageMessageLatest)(Page.Master.FindControl("PageMessage"))).ErrorMessage(Result);
                }
            }
        }

        DataSet ds=new DataSet();
        public void BindGridView(string searchtext="",byte Key=0)
        {
           
            StockD stockbus = new StockD();
            ds = stockbus.GetOpenStockTemplate(searchtext,Key);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        GvOpenStockExport.DataSource = ds;
                        ViewState["GvOpenStockExport"] = ds;
                        GvOpenStockExport.DataBind();
                    }
                }
            }
        }


        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            if (imgSearch.CommandArgument == "S")
            {
                if (ddlsearchby.SelectedIndex == 0)
                {
                    ((PageMessageLatest)(Page.Master.FindControl("PageMessage"))).InfoMessage("select a search by.");
                }
                else if (txtsearch.Text == "")
                {
                    ((PageMessageLatest)(Page.Master.FindControl("PageMessage"))).InfoMessage("Enter the search text.");
                }
                BindGridView(txtsearch.Text.Trim(), Convert.ToByte(ddlsearchby.SelectedValue));
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
                //((System.Web.UI.HtmlControls.HtmlContainerControl)(Page.Master.FindControl("PageMessage").FindControl("infomsg"))).Style.Add("visibility", "hidden");
                txtsearch.Enabled = true;
            }
        }

        public void exportexcel()
        {
            BindGridView();
            GVColumnsVisibility(1);
            GvOpenStockExport.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            Control parent = GvOpenStockExport.Parent;
            int GridIndex = 0;
            if (parent != null)
            {
                GridIndex = parent.Controls.IndexOf(GvOpenStockExport);
                parent.Controls.Remove(GvOpenStockExport);
            }

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=OpenStockTemplate.xlsx");
            Response.ContentType = "application/vnd.ms.xlsx";
            System.IO.StringWriter sw = new System.IO.StringWriter();
            HtmlTextWriter htm = new HtmlTextWriter(sw);
            GvOpenStockExport.RenderControl(htm);
            Response.Write(sw.ToString());
            Response.End();
            GVColumnsVisibility(0);

        }


        private void ExporttoExcelNew()
        {
            GvOpenStockExport.Dispose();
            BindGridView();
            GVColumnsVisibility(1);   
            //DataTable table = ds.Tables[0];
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ClearHeaders();
            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            //HttpContext.Current.Response.ContentType = "application/ms-word";
           // HttpContext.Current.Response.Write(@"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">");
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=OpenStock.xls");
            // HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=Reports.doc");
            HttpContext.Current.Response.Charset = "utf-8";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1250");
            HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Calibri;'>");
            HttpContext.Current.Response.Write("<BR><BR><BR>");
            HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' borderColor='#000000' cellSpacing='0' cellPadding='0' style='font-size:10.0pt; font-family:Calibri; background:white;'> <TR>");
            int columnscount = GvOpenStockExport.Columns.Count;

            for (int j = 0; j < columnscount; j++)
            {
                HttpContext.Current.Response.Write("<Td>");
                HttpContext.Current.Response.Write("<B>");
                HttpContext.Current.Response.Write(GvOpenStockExport.Columns[j].HeaderText.ToString());
                HttpContext.Current.Response.Write("</B>");
                HttpContext.Current.Response.Write("</Td>");
            }
            HttpContext.Current.Response.Write("</TR>");
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                HttpContext.Current.Response.Write("<TR>");
                for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
                {
                    HttpContext.Current.Response.Write("<Td>");
                    HttpContext.Current.Response.Write(row[i].ToString());
                    HttpContext.Current.Response.Write("</Td>");
                }

                HttpContext.Current.Response.Write("</TR>");
            }
            HttpContext.Current.Response.Write("</Table>");
            HttpContext.Current.Response.Write("</font>");
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
            GVColumnsVisibility(0);
            GvOpenStockExport.DataBind();
        }


        protected void lnkDownloadTemplate_Click(object sender, EventArgs e)
        {
            //exportexcel();
            ExporttoExcelNew();
        }

        protected void lnkCheckanyunimportedData_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Stocks/OpenStockGrid.aspx?LoadCase=2");
        }

        protected void GvOpenStockExport_SelectedIndexChanged(object sender, GridViewPageEventArgs e)
        {
            GvOpenStockExport.PageIndex = e.NewPageIndex;
            ds = (DataSet)ViewState["GvOpenStockExport"];
            GvOpenStockExport.DataSource = ds;
            GvOpenStockExport.DataBind();
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
    }
}
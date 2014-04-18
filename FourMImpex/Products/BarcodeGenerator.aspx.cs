using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BarCodeGenerator;
using System.Data;
using FourMImpex.UC;
using FourMImpexClass.DAL;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.IO;


namespace FourMImpex.Products
{
    public partial class BarcodeGenerator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                GvCurrentStockReport.AllowPaging = false;
            }
            //string BarcodeID = "NA-0314-00001";
            //PrintBarcode(BarcodeID);
        }

        public void BindGridView(string searchtext = "", byte key = 0)
        {
            //if (validation() == 1)
            //{
            DataSet ds;
            //string dtfrom = DateTime.Parse(txtFrom.Text).ToString("yyyyMMdd");
            //string dtto = DateTime.Parse(txtto.Text).ToString("yyyyMMdd");
            ReportsD rpt = new ReportsD();
            ds = rpt.GetCurrentStockForBarcodeGeneration(searchtext, key);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        GvCurrentStockReport.DataSource = ds;
                        ViewState["gv"] = ds.Tables[0];
                        GvCurrentStockReport.DataBind();

                        //pnlcontainer.Visible = true;
                    }
                    else
                    {
                        ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Currently there is no record.");
                    }
                }
                else
                    ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Currently there is no record.");
            }
            else
                ((PageMessage)(Page.Master.FindControl("PageMessage"))).InfoMessage("Currently there is no record.");
            //}
        }


        protected void PrintBarcode(string BarcodeID,DataTable DtSelectedStock=null)
        {
            string StrBody = "";
            String ImagePath = "";
            DataTable dtImagePath = new DataTable();
            dtImagePath.Columns.Add("ImagePath");
            if (DtSelectedStock == null)
            {
                ImagePath = Server.MapPath(@"\Temp\" + Guid.NewGuid() + ".Gif");
                dtImagePath.Rows.Add(ImagePath);
                System.Drawing.Image BarcodeImage = BarCodegeneratorClass.MakeBarcodeImage(BarcodeID, 2, true);
                BarcodeImage.Save(ImagePath, System.Drawing.Imaging.ImageFormat.Gif);
                StrBody = StrBody + @"<table width=""100%"" cellpadding=""2"" cellspacing=""0"" border=""0""   >";
                StrBody = StrBody + @"<tr><td>";
                StrBody = StrBody + @"<table width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0""  >";

                StrBody = StrBody + @"<tr width=""100%"" ><td colspan='3' align=""left"">";

                StrBody = StrBody + @"<table width=""100%"" cellpadding=""3"" cellspacing=""0""  border=""0""  >";
                StrBody = StrBody + @"<tr width=""100%"" >";
                
                
                StrBody = StrBody + @"<td  align=""center"" width=""100%"" valign=""top"" style=""Padding:0 0 0 0; margin:0 0 0 0 ;"" class=""labelFontforEngraving"">";

                StrBody = StrBody + @"<table cellpadding=""0"" cellspacing=""0""  border=""0""><tr><td><img style=""text-align:center;"" height='35px' width='120px' src='" + ImagePath + "'" + "/></td></tr>";
                StrBody = StrBody + @"<tr><td>" + BarcodeID + "</td></tr>";
                StrBody = StrBody + @"</table>";
                StrBody = StrBody + @"</td>";
                               

                StrBody = StrBody + @"</tr>";
                StrBody = StrBody + @"</table>";

                StrBody = StrBody + @"</td></tr>";
                //'Barcode ID
                //StrBody = StrBody + @"<tr width=""100%"" >";
                //StrBody = StrBody + @"<td align=""left"" valign=""top"" width=""33%"" class=""labelFontforEngraving"">" + "Cylinder ID " + " </td>";
                //StrBody = StrBody + @"<td  align=""left"" valign=""top"" width=""3%"" valign=""top"" class=""labelFontforEngraving"">" + ":" + " </td>";
                //StrBody = StrBody + @"<td align=""left"" valign=""top"" width=""64%"" valign=""top"" class=""labelFontforEngraving"" >" + BarcodeID + "</td>";
                //StrBody = StrBody + @"</tr>";
                //'Name of the product
                //StrBody = StrBody + @"<tr width=""100%"">";
                //StrBody = StrBody + @"<td  align=""left"" valign=""top""  width=""33%"" class=""labelFontforEngraving"">" + "Job Name" + " </td>";
                //StrBody = StrBody + @"<td align=""left"" valign=""top"" width=""3%"" valign=""top"" class=""labelFontforEngraving"">" + ":" + " </td>";
                //StrBody = StrBody + @"<td align=""left"" valign=""top"" width=""64%"" valign=""top"" class=""labelFontforEngraving"">" + BarcodeName + "</td>";
                //StrBody = StrBody + @"</tr>";
                StrBody = StrBody + @"</br>";
                StrBody = StrBody + @"</tr></td>";
                StrBody = StrBody + @"</table>";
                StrBody = StrBody + @"</tr></td>";
                StrBody = StrBody + @"</table>";
            }
            else
            {
                int j = 0;
                if (DtSelectedStock.Rows.Count > 1)
                    while (j < DtSelectedStock.Rows.Count)
                    {
                        ImagePath = Server.MapPath(@"\Temp\" + Guid.NewGuid() + ".Gif");
                        dtImagePath.Rows.Add(ImagePath);
                        System.Drawing.Image BarcodeImage = BarCodegeneratorClass.MakeBarcodeImage(DtSelectedStock.Rows[j]["Barcode"].ToString(), 2, true);
                        BarcodeImage.Save(ImagePath, System.Drawing.Imaging.ImageFormat.Gif);
                       // StrBody = StrBody + @"<table width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0""  >";

                        //StrBody = StrBody + @"<tr width=""100%"" ><td colspan='3' align=""left"">";

                        StrBody = StrBody + @"<table width=""100%"" cellpadding=""3"" cellspacing=""0""  border=""0""  >";
                        StrBody = StrBody + @"<tr width=""100%"" >";
                        // Left side barcode
                        StrBody = StrBody + @"<td  align=""center"" width=""100%"" valign=""top"" style=""Padding:0 0 0 0; margin:0 0 0 0 ;"" >";

                        StrBody = StrBody + @"<table cellpadding=""0"" cellspacing=""0""  border=""0""><tr><td><img style=""text-align:center;"" height='35px' width='120px' src='" + ImagePath + "'" + "/></td></tr>";
                        StrBody = StrBody + @"<tr><td>" + DtSelectedStock.Rows[j]["Barcode"].ToString() + "</td></tr>";
                        StrBody = StrBody + @"</table>";
                        StrBody = StrBody + @"</td>";
                        
                        // Right side barcode
                        if (j + 1 < DtSelectedStock.Rows.Count)
                        {
                            ImagePath = Server.MapPath(@"\Temp\" + Guid.NewGuid() + ".Gif");
                            dtImagePath.Rows.Add(ImagePath);
                            System.Drawing.Image BarcodeImageRight = BarCodegeneratorClass.MakeBarcodeImage(DtSelectedStock.Rows[j + 1]["Barcode"].ToString(), 2, true);
                            BarcodeImageRight.Save(ImagePath, System.Drawing.Imaging.ImageFormat.Gif);
                            StrBody = StrBody + @"<td  align=""center"" width=""100%"" valign=""top"" style=""Padding:0 0 0 0; margin:0 0 0 0 ;"" >";
                            StrBody = StrBody + @"<table cellpadding=""0"" cellspacing=""0""  border=""0""><tr><td><img style=""text-align:center;"" height='35px' width='120px' src='" + ImagePath + "'" + "/></td></tr>";
                            StrBody = StrBody + @"<tr><td>" + DtSelectedStock.Rows[j + 1]["Barcode"].ToString() + "</td></tr>";
                            StrBody = StrBody + @"</table>";
                            StrBody = StrBody + @"</td>";
                        }
                        else
                        {
                            ImagePath = Server.MapPath(@"\Temp\" + Guid.NewGuid() + ".Gif");
                            dtImagePath.Rows.Add(ImagePath);
                            System.Drawing.Image BarcodeImageRight = BarCodegeneratorClass.MakeBarcodeImage(DtSelectedStock.Rows[j ]["Barcode"].ToString(), 2, true);
                            BarcodeImageRight.Save(ImagePath, System.Drawing.Imaging.ImageFormat.Gif);
                            StrBody = StrBody + @"<td  align=""center"" width=""100%"" valign=""top"" style=""Padding:0 0 0 0; margin:0 0 0 0 ;"" class=""labelFontforEngraving"">";
                            StrBody = StrBody + @"<table cellpadding=""0"" cellspacing=""0""  border=""0""><tr><td><img style=""text-align:center;"" height='35px' width='120px' src='" + ImagePath + "'" + "/></td></tr>";
                            StrBody = StrBody + @"<tr><td>" + DtSelectedStock.Rows[j ]["Barcode"].ToString() + "</td></tr>";
                            StrBody = StrBody + @"</table>";
                            StrBody = StrBody + @"</td>";
                        }
                        StrBody = StrBody + @"</tr>";
                        StrBody = StrBody + @"</table>";

                       // StrBody = StrBody + @"</td></tr>";
                       
                        //StrBody = StrBody + @"</tr></td>";
                        //StrBody = StrBody + @"</table>";
                        j = j + 2;
                    }
                else
                {
                    ImagePath = Server.MapPath(@"\Temp\" + Guid.NewGuid() + ".Gif");
                    dtImagePath.Rows.Add(ImagePath);
                    System.Drawing.Image BarcodeImage = BarCodegeneratorClass.MakeBarcodeImage(DtSelectedStock.Rows[j]["Barcode"].ToString(), 2, true);
                    BarcodeImage.Save(ImagePath, System.Drawing.Imaging.ImageFormat.Gif);
                    //StrBody = StrBody + @"<table width=""100%"" cellpadding=""2"" cellspacing=""0"" border=""0""   >";
                    //StrBody = StrBody + @"<tr><td>";
                    StrBody = StrBody + @"<table width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0""  >";

                    StrBody = StrBody + @"<tr width=""100%"" ><td colspan='3' align=""left"">";

                    StrBody = StrBody + @"<table width=""100%"" cellpadding=""3"" cellspacing=""0""  border=""0""  >";
                    StrBody = StrBody + @"<tr width=""100%"" >";
                    // Left barcode
                    StrBody = StrBody + @"<td  align=""center"" width=""100%"" valign=""top"" style=""Padding:0 0 0 0; margin:0 0 0 0 ;"" class=""labelFontforEngraving"">";

                    StrBody = StrBody + @"<table cellpadding=""0"" cellspacing=""0""  border=""0""><tr><td><img style=""text-align:center;"" height='35px' width='120px' src='" + ImagePath + "'" + "/></td></tr>";
                    StrBody = StrBody + @"<tr><td>" + DtSelectedStock.Rows[j]["Barcode"].ToString() + "</td></tr>";
                    StrBody = StrBody + @"</table>";
                    StrBody = StrBody + @"</td>";

                    StrBody = StrBody + @"</tr>";
                    StrBody = StrBody + @"</table>";

                    StrBody = StrBody + @"</td></tr>";

                    //StrBody = StrBody + @"</br>";
                    StrBody = StrBody + @"</tr></td>";
                    StrBody = StrBody + @"</table>";
                    //StrBody = StrBody + @"</tr></td>";
                    //StrBody = StrBody + @"</table>";
                    //StrBody = StrBody + @"</br>";
                    //j = j + 2;
                }
            }
         
            Document pdfdoc = convertHTMLToPDF(StrBody.Trim());
            if (dtImagePath.Rows.Count > 0)
                for (int i = 0; i < dtImagePath.Rows.Count - 1;i++ )
                {
                    try
                    {
                        if (System.IO.File.Exists(dtImagePath.Rows[i][0].ToString()))
                        {
                            System.IO.File.Delete(dtImagePath.Rows[i][0].ToString());
                        }
                    }
                    catch { }
                }

            Response.ContentType = "application/pdf";
            //Set default file Name as current datetime DateTime.Now.ToString("yyyyMMdd")
            Response.AddHeader("content-disposition", "attachment; filename=" + BarcodeID + ".pdf");
            System.Web.HttpContext.Current.Response.Write(pdfdoc);            
            Response.Flush();
            Response.End();
        }

        public Document convertHTMLToPDF(string contents)
        {
            //Assign Html content in a string to write in PDF
            var pdfDoc = new Document(new Rectangle(370,150));
            //Document pdfDoc = new Document(PageSize._11X17,5,5,5,5);
            try
            {
                PdfWriter.GetInstance(pdfDoc, System.Web.HttpContext.Current.Response.OutputStream);

                //Open PDF Document to write data
                pdfDoc.Open();


                //Read string contents using stream reader and convert html to parsed conent
                var parsedHtmlElements = HTMLWorker.ParseToList(new StringReader(contents), null);

                //Get each array values from parsed elements and add to the PDF document
                foreach (var htmlElement in parsedHtmlElements)
                    pdfDoc.Add(htmlElement as IElement);

                //Close your PDF
                pdfDoc.Close();
                return pdfDoc;
                

            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
                return null;
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            DataTable DtSelectedStockToPrint = new DataTable();
            DtSelectedStockToPrint.Columns.Add("StockIDSelected");
            DtSelectedStockToPrint.Columns.Add("Barcode");
            StockD StockDAL = new StockD();
            foreach( GridViewRow GVrow in GvCurrentStockReport.Rows )
            {
                if (((CheckBox)GVrow.FindControl("ChkSelectStock")).Checked == true)
                {
                    string SelectedStockID = ((HiddenField)GVrow.FindControl("hdnStockID")).Value;
                    
                    String Barcode = StockDAL.GetBarcodeStringAndUpdate(Convert.ToInt64(SelectedStockID), Convert.ToInt32(Session["UserID"].ToString()));
                    if (Barcode != "N")
                        if (Barcode.Split(',').First() == "S")
                        {
                            DtSelectedStockToPrint.Rows.Add(Convert.ToInt64(SelectedStockID),Barcode.Split(',').Last());
                            //PrintBarcode(Barcode.Split(',').Last());
                        }
                        else
                        {
                        }
                }
            }
            btnPrint.Visible = false;
            PrintBarcode(null, DtSelectedStockToPrint);

        }

        protected void imgSearchby_Click(object sender, ImageClickEventArgs e)
        {
            if (ddlSearchBy.SelectedItem.ToString() != "<--Select-->")
                BindGridView(txtsearch.Text.Trim(), 1);
        }

        protected void BtnExport_Click(object sender, EventArgs e)
        {
            exportexcel();
        }

        public void exportexcel()
        {
           // BindGridView();
            GVColumnsVisibility(0);
            GvCurrentStockReport.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            Control parent = GvCurrentStockReport.Parent;
            int GridIndex = 0;
            if (parent != null)
            {
                GridIndex = parent.Controls.IndexOf(GvCurrentStockReport);
                parent.Controls.Remove(GvCurrentStockReport);
            }

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=BarcodeForAvailableStocks.xls");
            Response.ContentType = "application/vnd.ms.xls";
            System.IO.StringWriter sw = new System.IO.StringWriter();
            HtmlTextWriter htm = new HtmlTextWriter(sw);
            GvCurrentStockReport.RenderControl(htm);
            Response.Write(sw.ToString());
            Response.End();
            GVColumnsVisibility(1);

        }

        protected void GVColumnsVisibility(sbyte Flag = 0)
        {
            if (Flag == 0) // Hide all the ID based columns in Grid 
            {
                //GvCurrentStockReport.Columns[0].HeaderText = "#";
                GvCurrentStockReport.Columns[1].Visible = false;


            }
            else if (Flag == 1) // Show all the ID based columns in Grid to export to excel
            {
                GvCurrentStockReport.Columns[1].Visible = true;

            }

        }
    }

}
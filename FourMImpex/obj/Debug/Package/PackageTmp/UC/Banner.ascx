<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="~/UC/Banner.ascx.cs" Inherits="FourMImpex.UC.Banner" %>
<link href="../Style/Common.css" rel="stylesheet" type="text/css" />
<link href="../Style/Modelling.css" rel="Stylesheet" type="text/css" />
<div class="adminbannercontainer">
    <div class="adminbannerinnercontainer">
        <div class="Adminbannerlogocontainer">
            <asp:ImageButton ID="imgLogo" runat="Server" ImageUrl="~/Images/4M.png" />
        </div>
        <div>
        <div id="DivAdvanceSearchContainer" class="AdvanceSearch">
        <div id="DivTxtSearch" class="DivTxtSearch">
            <asp:TextBox ID="txtAdvanceSearch" CssClass="txtAdvanceSearch" BorderWidth="0" 
                BorderColor="White" BorderStyle="Outset" runat="server" Width="234px" 
                Height="30px" TextMode="SingleLine" EnableTheming="False" />
                
            </div>
            <asp:ImageButton ID="imgbtnAdvanceSearch" runat="server" CssClass="imgbtnAdvanceSearch"
                ImageUrl="~/Images/AdvanceSearchIcon.png" onclick="imgbtnAdvanceSearch_Click" />
            
            </div>
        </div>
        <div class="adminbannerrightcontainer">
            <div class="adminbannercentercontainer">
                <div class="adminbannerhomemenucontainer" style="width: 360px;">
                    <div class="adminbannerhometxt" id="bannerusername" runat="server" style="width: 293px;
                        text-align: right;">
                        User
                    </div>
                    <div class="adminbannerhomeimg">
                        <asp:Image ID="imgBannerUser" runat="server" ImageUrl="~/Images/defaultphoto.gif" />
                    </div>
                </div>
            </div>
            <div class="adminbannerlogoutcontainer" style="width: 193px; text-align: right;">
                <asp:LinkButton ID="lnkLogout" runat="server" Text="Logout" SkinID="lnkBanner" PostBackUrl="~/Default.aspx"></asp:LinkButton>
            </div>
        </div>
    </div>
    <div class="Menus">
        <div id="Menu">
            <ul id="menuh">
            <li><a href="#">Products</a>
            <ul>
                <li><asp:LinkButton ID="lnkbtnProducts" Text="Products Selling" runat="server" PostBackUrl="~/Products/ProductSelection.aspx"></asp:LinkButton> </li>
                <li><asp:LinkButton ID="lnkbtnBarcode" Text="Barcode Process" runat="server" PostBackUrl="~/Products/BarcodeGenerator.aspx"></asp:LinkButton> </li>
                </ul>
                </li>
                <li><a href="#">Stock</a>
                    <ul>
                        <li><asp:LinkButton ID="lnkbtnPurchaseOrder" Text="Purchase Order" runat="server" PostBackUrl="~/Stocks/PurchaseOrder.aspx"></asp:LinkButton></li>
                        <li><asp:LinkButton ID="lnkbtnReceiptfromPO" Text="Receipts From PO" runat="server" PostBackUrl="~/Stocks/ReceiptsGrid.aspx"></asp:LinkButton></li>
                        <li><asp:LinkButton ID="lnkbtnOpenStock" Text="Open Stock" runat="server" PostBackUrl="~/Stocks/OpenStockGrid.aspx"></asp:LinkButton></li>
                       <%-- <li><asp:LinkButton ID="lnkbtnBulkReceipt" Text="Bulk Receipts" runat="server" PostBackUrl="~/Stocks/BulkReceiptGrid.aspx" ></asp:LinkButton></li>--%>
                    </ul>
                </li>
                <li><a href="#">Report</a>
                    <ul>
                    <%-- <li ><asp:LinkButton ID="lnkbtnPurchaseorderreport" Text="Purchase Order Report" runat="server" PostBackUrl="~/Reports/purchaseorderreport.aspx" ></asp:LinkButton></li>
                        <li><asp:LinkButton ID="lnkbtnReceiptreport" Text="Receipt Report" runat="server" PostBackUrl="~/Reports/ReceiptReport.aspx" ></asp:LinkButton></li>
                        <li><asp:LinkButton ID="lnkbtnSalesreport" Text="Sales Receipts Report" runat="server" PostBackUrl="~/Reports/SalesReceiptReport.aspx" ></asp:LinkButton></li>
                       --%> <li><asp:LinkButton ID="lnkbtnCurentstckreport" Text="Current Stock Report" runat="server" PostBackUrl="~/Reports/CurrentStockReport.aspx" ></asp:LinkButton></li>
                   
                    </ul>
                </li>
                <li><a href="#">Admin</a>
                    <ul>
                        <%--<li><a href="../Admin/User.aspx">User </a></li>
                        <li><a href="../Admin/Role.aspx">Role </a></li>--%> 
                        <li><asp:LinkButton ID="lnkbtnProdctadmingrid" Text="Products" runat="server" PostBackUrl="~/Admin/ProductGrid.aspx"></asp:LinkButton></li>
                        <li><asp:LinkButton ID="lnkbtnBrandadmingrid" Text="Brand" runat="server" PostBackUrl="~/Admin/BrandGrid.aspx"></asp:LinkButton></li>
                        <li><asp:LinkButton ID="lnkbtnModeladmingrid" Text="Model" runat="server" PostBackUrl="~/Admin/ModelGrid.aspx"></asp:LinkButton></li>
                        <li><asp:LinkButton ID="lnkbtnProductPriceadmingrid" Text="Manage Price" runat="server" PostBackUrl="~/Admin/ProductPriceGrid.aspx"></asp:LinkButton></li>
                       
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>

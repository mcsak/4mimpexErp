<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellProduct.aspx.cs" Inherits="FourMImpex.Products.SellProduct"  %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>4M Impex</title>
        <link href="Style/Common.css" rel="stylesheet" type="text/css" />
    <link href="Style/Footer.css" rel="Stylesheet" type="text/css" />
    <%--<link type="text/css"  href="../Style/Common.css" />--%>
</head>

<body width="800px">
    <form id="form1" runat="server">
    <div>
    
    <div class="centeroutercontainer">
    
        <div class="headercontent">
            Product Particulars</div>
     </div>
     <br />
     <div>
     <asp:GridView ID="GvProductList" runat="server" AutoGenerateColumns="false" SkinID="ClientDashBoardGrid">
                 <Columns>
                 
                 <asp:TemplateField>
                 <HeaderTemplate><asp:Label ID="lblgvID" runat="server" Text="S.No"></asp:Label> </HeaderTemplate>
                 <ItemTemplate> <asp:Label ID="lblgvIDval" runat="server" Text=' <%# Container.DataItemIndex+1%>'></asp:Label> </ItemTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="ProductName" HeaderText="Products Name" />
                 <asp:BoundField DataField="BrandName" HeaderText="Brand" />
                 <asp:BoundField DataField="ModelName" HeaderText="Model" />                 
                 <asp:TemplateField >
                 <HeaderTemplate> <asp:Label ID="gvlblQty" runat="server" Text="Qty"></asp:Label></HeaderTemplate>
                 <ItemTemplate>                
                <asp:Label ID="gvlblQtyval" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                 </ItemTemplate>
                 </asp:TemplateField>
                 
                 </Columns>
                 </asp:GridView>
     </div>
     <br />
     <asp:Button ID="btnPrint" runat="server" Text="Print" onclick="btnPrint_Click" />
     
    </div>

    </form>
    </body>
</html>
<%--<asp:Content ID="HeadContent" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent">
            Sell Product</div>
        <div class="showproductdetails">
            <div class="productimagebox">
                <asp:Image ID="imgbox" runat="server" ImageUrl="~/Images/HP.jpg" Width="150" Height="150" />
            </div>
            <div class="productdetailcontainer">
                <div class="productdetailleft">
                    Product</div>
                <div class="productdetailright">
                    Monitor</div>
            </div>
            <div class="productdetailcontainer">
                <div class="productdetailleft">
                    Brand</div>
                <div class="productdetailright">
                    HP</div>
            </div>
            <div class="productdetailcontainer">
                <div class="productdetailleft">
                    Model</div>
                <div class="productdetailright">
                    X200</div>
            </div>
            <div class="productdetailcontainer">
                <div class="productdetailleft">
                    Number of Items</div>
                <div class="productdetailright">
                    1</div>
            </div>
            <div class="productdetailcontainer">
                <div class="productdetailleft">
                    Price
                </div>
                <div class="productdetailright">
                    Rs. 4000</div>
            </div>
            <div class="productdetailcontainer">
                <div class="productdetailleft">
                    Discount
                </div>
                <div class="productdetailright">
                    <asp:TextBox ID="txtDiscount" runat="server" Text="10%"></asp:TextBox></div>
            </div>
            <div class="productdetailcontainer">
                <div class="productdetailleft">
                    Net Price
                </div>
                <div class="productdetailright">
                    Rs. 3600</div>
            </div>
            <div class="productdetailcontainer" style="margin-top: 20px;">
                <div class="productdetailleft">
                   
                </div>
                <div class="productdetailright">
                   <asp:Button ID="btnPrint" runat="server" Text="Sold Out & Print" EnableTheming="false"
                        CssClass="btnCommonstyle" />  <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btnCommonstyle"
                        PostBackUrl="~/Products/ProductSelection.aspx" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>


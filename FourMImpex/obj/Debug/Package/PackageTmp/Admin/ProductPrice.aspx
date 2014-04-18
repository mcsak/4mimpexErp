<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/ProductPrice.aspx.cs"
    Inherits="FourMImpex.Admin.ProductPrice" MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="PriceHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead"
    runat="server">
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
     <script src="../Script/jquery-1.9.1.min.js" type="text/javascript"></script>
    <title>Model</title>
     <script language="javascript" type="text/javascript">
         function validate() {
             if (document.getElementById('ctl00_ContentPlaceHolderMain_ddlProduct').value == "0") {
                 $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                 $('div[id$=war]').html('').html('Select the product.');
                 
                 return false;
             }
             if (document.getElementById('ctl00_ContentPlaceHolderMain_ddlBrand').value == "0") {
                 $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                 $('div[id$=war]').html('').html('Select the brand.');
                 
                 return false;
             }
             if (document.getElementById('ctl00_ContentPlaceHolderMain_ddlModel').value == "0") {
                 $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                 $('div[id$=war]').html('').html('Select the model.');
                 
                 return false;
             }
             if (document.getElementById('ctl00_ContentPlaceHolderMain_txtPrice').value == "") {
                 $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                 $('div[id$=war]').html('').html('Enter the price.');
                 return false;
             }
             if (document.getElementById('ctl00_ContentPlaceHolderMain_txtDescription').value == "") {
                 $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                 $('div[id$=war]').html('').html('Enter the description.');
                 
                 return false;
             }
             if (document.getElementById('ctl00_ContentPlaceHolderMain_txtDiscount').value == "") {
                 $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                 $('div[id$=war]').html('').html('Enter the discount.');                 
                 return false;
             }
             var discountamount = Number(document.getElementById('ctl00_ContentPlaceHolderMain_txtDiscount').value);
             if ( discountamount > 101) {
                 $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                 $('div[id$=war]').html('').html('Enter the discount amount less than or equal to 100.');
                 return false;
             }
         }
   
    </script>
</asp:Content>
<asp:Content ID="PriceMainContent" ContentPlaceHolderID="ContentPlaceHolderMain"
    runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent" id="headertitle" runat="server">
            Product Price - Add</div>
        <div class="mainbodycenterconatiner">
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Product
                </div>
                <div class="adminright">
                    <asp:DropDownList ID="ddlProduct" runat="server" Width="205px" Height="25px" AutoPostBack="true" onselectedindexchanged="ddlProduct_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Brand
                </div>
                <div class="adminright">
                    <asp:DropDownList ID="ddlBrand" runat="server" Width="205px" Height="25px" AutoPostBack="true" 
                        onselectedindexchanged="ddlBrand_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Model
                </div>
                <div class="adminright">
                    <asp:DropDownList ID="ddlModel" runat="server" Width="205px" Height="25px">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Price
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtPrice" runat="server" Width="200px" MaxLength="6"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                   Price Description
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtDescription" runat="server" Width="250px" Height="70px" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Discount
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtDiscount" runat="server" Width="50px" MaxLength="3"></asp:TextBox><span>&nbsp;&nbsp;%</span>
                    <ajx:FilteredTextBoxExtender ID="filternumber" runat="server" TargetControlID="txtDiscount" FilterType="Numbers"></ajx:FilteredTextBoxExtender>
                    
                </div>
            </div>
             
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    &nbsp;
                </div>
                <div class="adminright">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnCommonstyle" Text="Submit" onclick="btnSubmit_Click" OnClientClick="return validate()" />&nbsp;<asp:Button
                        ID="btnBack" runat="server" CssClass="btnCommonstyle" onclick="btnBack_Click" Text="Back" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/Product.aspx.cs"
    Inherits="FourMImpex.Admin.Product" MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="ProductHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead"
    runat="server">
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <title>Product</title>
    <script src="../Script/jquery-1.9.1.min.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function validate() {
                if (document.getElementById('ctl00_ContentPlaceHolderMain_txtProduct').value == "") {
                    $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                    $('div[id$=war]').html('').html('Enter the product name.');
                    return false;
                }
                if (document.getElementById('ctl00_ContentPlaceHolderMain_txtProductDescription').value == "") {
                    $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                    $('div[id$=war]').html('').html('Enter the description.');
                    return false;
                }
            }
   
    </script>
</asp:Content>
<asp:Content ID="ProductMainContent" ContentPlaceHolderID="ContentPlaceHolderMain"
    runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent" id="headertitle" runat="server">
            Product - Add</div>
        <div class="mainbodycenterconatiner">
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Product Name
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtProduct" runat="server" Width="200px" MaxLength="100"></asp:TextBox>
                </div>
            </div>
             <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Product Description
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtProductDescription" runat="server" Width="300px" Height="60px" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    &nbsp;
                </div>
                <div class="adminright">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnCommonstyle" 
                        Text="Submit" OnClientClick="return validate()" onclick="btnSubmit_Click" />&nbsp;<asp:Button
                        ID="btnBack" runat="server" CssClass="btnCommonstyle" Text="Back" 
                        onclick="btnBack_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

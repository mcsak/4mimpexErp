<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/Brand.aspx.cs"
    Inherits="FourMImpex.Admin.Brand" MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="BrandHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead"
    runat="server">
    <script src="../Script/jquery-1.9.1.min.js" type="text/javascript"></script>
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <title>Brand</title>
        <script language="javascript" type="text/javascript">
            function validate() {
                if (document.getElementById('ctl00_ContentPlaceHolderMain_ddlProduct').value == "0") {
                    $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                    $('div[id$=war]').html('').html('Select the prroduct.');
                    return false;
                }
                if (document.getElementById('ctl00_ContentPlaceHolderMain_txtBrand').value == "") {
                    $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                    $('div[id$=war]').html('').html('Enter the brand name.');
                    return false;
                }
                if (document.getElementById('ctl00_ContentPlaceHolderMain_txtBrandDescription').value == "") {
                    $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                    $('div[id$=war]').html('').html('Enter the description.');
                    return false;
                }
            }
   
    </script>
</asp:Content>
<asp:Content ID="BrandMainContent" ContentPlaceHolderID="ContentPlaceHolderMain"
    runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent" id="headertitle" runat="server">
            Brand - Add</div>
        <div class="mainbodycenterconatiner">
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Product
                </div>
                <div class="adminright">
                    <asp:DropDownList ID="ddlProduct" runat="server" Width="205px" Height="25px">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Brand Name
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtBrand" runat="server" Width="200px"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Brand Description
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtBrandDescription" runat="server" Width="300px" TextMode="MultiLine" Height="70px" MaxLength="500"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    &nbsp;
                </div>
                <div class="adminright">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnCommonstyle" 
                        Text="Submit" OnClientClick="return validate()" onclick="btnSubmit_Click" />&nbsp;<asp:Button
                        ID="btnBack" runat="server" CssClass="btnCommonstyle" Text="Back" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

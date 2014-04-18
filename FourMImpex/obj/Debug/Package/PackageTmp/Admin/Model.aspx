<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/Model.aspx.cs"
    Inherits="FourMImpex.Admin.Model" MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="ModelHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead"
    runat="server">
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <title>Model</title>
    <script src="../Script/jquery-1.9.1.min.js" type="text/javascript"></script>
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
                if (document.getElementById('ctl00_ContentPlaceHolderMain_txtModel').value == "") {
                    $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                    $('div[id$=war]').html('').html('Enter the model name.');
                    return false;
                }
                if (document.getElementById('ctl00_ContentPlaceHolderMain_txtDescription').value == "") {
                    $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                    $('div[id$=war]').html('').html('Select the descriionpt.');
                    return false;
                }
            }
   
    </script>
</asp:Content>
<asp:Content ID="ModelMainContent" ContentPlaceHolderID="ContentPlaceHolderMain"
    runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent" id="headertitle" runat="server">
            Model - Add</div>
        <div class="mainbodycenterconatiner">
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Product
                </div>
                <div class="adminright">
                    <asp:DropDownList ID="ddlProduct" runat="server" Width="205px" Height="25px" AutoPostBack="true" 
                        onselectedindexchanged="ddlProduct_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Brand
                </div>
                <div class="adminright">
                    <asp:DropDownList ID="ddlBrand" runat="server" Width="205px" Height="25px">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Model Name
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtModel" runat="server" Width="200px" MaxLength="100"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                   Model Description
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtDescription" runat="server" Width="250px" Height="70px" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    &nbsp;
                </div>
                <div class="adminright">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnCommonstyle" 
                        Text="Submit" OnClientClick="return validate()" onclick="btnSubmit_Click" />&nbsp;<asp:Button
                        ID="btnBack" runat="server" CssClass="btnCommonstyle" Text="Back"  />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

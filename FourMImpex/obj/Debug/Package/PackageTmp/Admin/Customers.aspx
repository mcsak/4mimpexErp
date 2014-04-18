<%@ Page Title="" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="FourMImpex.Admin.Customers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
<link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

 <div class="centeroutercontainer">
        <div class="headercontent" id="headertitle" runat="server">
            Model - Add</div>
        <div class="mainbodycenterconatiner">
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Customer Name
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtCustomerName" runat="server" CssClass="textBoxStyle">
           </asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Phone Number
                </div>
                <div class="adminright">
                   <asp:TextBox ID="txtContact" runat="server" CssClass="textBoxStyle">
           </asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Email Address
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtEmailAddress" runat="server" Width="200px" MaxLength="100"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                   Address & Others
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtAddress" runat="server" Width="250px" Height="70px" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
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

 <%--<asp:Label ID="lblCustName" runat="server" Text="Customer Name" ></asp:Label> &nbsp; : <asp:TextBox ID="txtCustomerName" runat="server" CssClass="textBoxStyle">
           </asp:TextBox>
           
           <asp:Label ID="lblContactNumber" runat="server" Text="Contact No."></asp:Label>&nbsp; : <asp:TextBox ID="txtContact" runat="server" CssClass="textBoxStyle">
           </asp:TextBox>
           
           <asp:Label ID="lblEmailID" runat="server" Text="E-mail ID" />&nbsp; : <asp:TextBox ID="txtEmailID" runat="server" CssClass="textBoxStyle" />
           <br />--%>
</asp:Content>

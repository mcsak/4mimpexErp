<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/User.aspx.cs" Inherits="FourMImpex.Admin.User"
    MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="UserHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <title>User</title>
</asp:Content>
<asp:Content ID="UserMainContent" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent">
            User</div>
        <div class="mainbodycenterconatiner">
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    First Name
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtFname" runat="server" Width="200px"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Last Name
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtLname" runat="server" Width="200px"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Email ID
                </div>
                <div class="adminright">
                    <asp:TextBox ID="txtEmailID" runat="server" Width="200px"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    &nbsp;
                </div>
                <div class="adminright">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnCommonstyle" Text="Submit" />&nbsp;<asp:Button
                        ID="btnBack" runat="server" CssClass="btnCommonstyle" Text="Back" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

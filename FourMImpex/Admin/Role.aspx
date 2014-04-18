<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/Role.aspx.cs" Inherits="FourMImpex.Admin.Role"
    MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="RoleHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <title>Role</title>
    <script language="javascript" type="text/javascript">
        function validate() {
            if (document.getElementById('ContentPlaceHolderMain_txtRole').value == "") {
                alert('Enter the Role.');
                return false;
            }
        }
   
    </script>
</asp:Content>
<asp:Content ID="RoleMainContent" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent">
            Role</div>
        <div class="mainbodycenterconatiner">
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    Role</div>
                <div class="adminright">
                    <asp:TextBox ID="txtRole" runat="server" Width="200px"></asp:TextBox>
                </div>
            </div>
            <div class="adminsinglerowcontainer">
                <div class="adminleft">
                    &nbsp;
                </div>
                <div class="adminright">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnCommonstyle" Text="Submit" OnClientClick="return validate()" />&nbsp;<asp:Button
                        ID="btnBack" runat="server" CssClass="btnCommonstyle" Text="Back" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

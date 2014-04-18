<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/BrandGrid.aspx.cs"
    Inherits="FourMImpex.Admin.BrandGrid" MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="BrandHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead"  runat="server">
    <title>Brand</title>
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../Script/jquery-1.9.1.min.js"></script>
    <script language="javascript" type="text/javascript">
        function gridsearchvalidation() {
            if (document.getElementById("ctl00_ContentPlaceHolderMain_ddlsearchby").selectedIndex == 0) {
                $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                $('div[id$=war]').html('').html('Select a search by.');
                return false;
            }
            if (document.getElementById("ctl00_ContentPlaceHolderMain_txtsearch").value == "") {
                $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
                $('div[id$=war]').html('').html('Enter the search text.');
                document.getElementById("ctl00_ContentPlaceHolderMain_txtsearch").focus();
                return false;
            }
        }

        function isRecordSelected(str) {
            var element = document.getElementById('ctl00_ContentPlaceHolderMain_gvBrand').getElementsByTagName('input');
            for (var i = 0; i < element.length; i++)
                if (element[i].type === 'radio')
                    if (element[i].checked == true)
                        return true;
            $('div[id$=warningmsg]').css({ 'visibility': 'visible', 'display': 'block' });
            $('div[id$=war]').html('').html('Select a record to ' + str + '.');

            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="BrandMainContent" ContentPlaceHolderID="ContentPlaceHolderMain"
    runat="server">
    <div class="admininnercontainer">
        <div class="admincontentcontainer">
            <div class="adminpagetitlecontainer">
                Brand</div>
            <div class="adminpagegridcontainer">
                <div class="admingridsearchcontainer">
                    <div class="pro_ddl_search">
                        <asp:DropDownList ID="ddlsearchby" runat="server" SkinID="CommonSearchBy" TabIndex="1">
                        </asp:DropDownList>
                    </div>
                    <div class="pro_searchtext">
                        <span class="gridsearch_txt">
                            <asp:TextBox ID="txtsearch" runat="server" SkinID="CommonGridSearch" TabIndex="2"
                                MaxLength="50"></asp:TextBox>
                        </span><span class="gridsearch_pic">
                            <asp:ImageButton ID="imgSearch" runat="server" Height="20px" Width="23px" TabIndex="3"
                                OnClientClick="return gridsearchvalidation()" CommandArgument="S" ImageAlign="Top"
                                ToolTip="Go" ImageUrl="~/Images/searchicongrid.png" OnClick="imgSearch_Click" />
                        </span>
                    </div>
                    <div class="gridbtncontainer">
                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
                        <asp:Button ID="btnUpdate" runat="server" Text="Modify" OnClick="btnUpdate_Click"
                            OnClientClick="return isRecordSelected('modify')" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click"
                            OnClientClick="return isRecordSelected('delete')" />
                    </div>
                </div>
                <div class="admingridcontainer">
                    <asp:GridView ID="gvBrand" runat="server" Width="100%" PagerStyle-Height="30px"
                        AutoGenerateColumns="false" OnSorting="gvBrand_Sorting" OnPageIndexChanging="gvBrand_SelectedIndexChanged">
                        <Columns>
                            <asp:TemplateField HeaderText="#" HeaderStyle-Width="5%" ItemStyle-Width="5%" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblno" SkinID="gridlbl" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Select" HeaderStyle-Width="5%" ItemStyle-Width="5%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <input type="radio" id="OptID" name="OptID" value='<%#Eval("BrandID")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Product Name" HeaderStyle-Width="25%" ItemStyle-Width="25%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="ProductName|2">
                                <ItemTemplate>
                                    <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("ProductName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Brand Name" HeaderStyle-Width="25%" ItemStyle-Width="25%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="BrandName|3">
                                <ItemTemplate>
                                    <asp:Label ID="lblBrandName" runat="server" Text='<%#Eval("BrandName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" HeaderStyle-Width="25%" ItemStyle-Width="25%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Description|4">
                                <ItemTemplate>
                                    <asp:Label ID="lblBrandDescription" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

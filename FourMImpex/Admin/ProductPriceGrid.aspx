<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Admin/ProductPriceGrid.aspx.cs" Inherits="FourMImpex.Admin.ProductPriceGrid" MasterPageFile="~/InnerMaster.Master" %>


<asp:Content ID="ProductHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead"
    runat="server">
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
            var element = document.getElementById('ctl00_ContentPlaceHolderMain_gvProductPrice').getElementsByTagName('input');
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


<asp:Content ID="ProductMainContent" ContentPlaceHolderID="ContentPlaceHolderMain"
    runat="server">

    <div class="admininnercontainer">
<div class="admincontentcontainer">
  
    <div class="adminpagetitlecontainer">Manage Price</div>
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
                        ToolTip="Go" ImageUrl="~/Images/searchicongrid.png" 
                    onclick="imgSearch_Click"  />
                </span>
            </div>
            <div class="gridbtncontainer">
                <asp:Button ID="btnAdd" runat="server"  Text="Add" onclick="btnAdd_Click" />
                <asp:Button ID="btnUpdate" runat="server"   Text="Modify" onclick="btnUpdate_Click" OnClientClick="return isRecordSelected('modify')" />
                <asp:Button ID="btnDelete" runat="server"  Text="Delete" onclick="btnDelete_Click" OnClientClick="return isRecordSelected('delete')" />
            </div>
        </div>
        <div class="admingridcontainer">
            <asp:GridView ID="gvProductPrice" runat="server" Width="100%"   PagerStyle-Height="30px" AutoGenerateColumns="false"
            OnPageIndexChanging="gvProductPrice_SelectedIndexChanged"
                OnSorting="gvProductPrice_Sorting">
           
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
                            <input type="radio" id="OptID" name="OptID" value='<%#Eval("PriceID")%>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Model Name" HeaderStyle-Width="20%" ItemStyle-Width="20%"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="ModelName|2">
                        <ItemTemplate>
                          <asp:Label ID="lblModelName" runat="server" Text='<%#Eval("ModelName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" HeaderStyle-Width="20%" ItemStyle-Width="20%"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Price|3">
                        <ItemTemplate>
                          <asp:Label ID="lblPrice" runat="server" Text='<%#Eval("Price") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Description" HeaderStyle-Width="40%" ItemStyle-Width="40%"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Description|4">
                        <ItemTemplate>
                          <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</div>

</div>
    </asp:Content>
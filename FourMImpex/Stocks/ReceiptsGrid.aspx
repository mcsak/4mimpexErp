﻿<%@ Page Title="" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="ReceiptsGrid.aspx.cs" Inherits="FourMImpex.Stocks.ReceiptsGrid" %>


<asp:Content ID="ReceiptHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
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
            var element = document.getElementById('ctl00_ContentPlaceHolderMain_GVReceipts').getElementsByTagName('input');
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
<asp:Content ID="ReceiptMainContent" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="centeroutercontainer">
        <div class="headercontent">
            Receipts</div>
        <div class="headercontent">
        </div>
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
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                    OnClientClick="return isRecordSelected('modify')" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click"
                    OnClientClick="return isRecordSelected('delete')" />
            </div>
        </div>
        <div class="admingridcontainer">
            <asp:UpdatePanel ID="Updpnl" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GVReceipts" runat="server" Width="90%" PagerStyle-Height="30px"
                        AutoGenerateColumns="false" OnSorting="GVReceipts_Sorting" OnPageIndexChanging="GVReceipts_SelectedIndexChanged">
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
                                    <input type="radio" id="OptID" name="OptID" value='<%#Eval("MasterPurchaseID")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PurchaseID" HeaderStyle-Width="10%" ItemStyle-Width="10%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="PurchaseID|2">
                                <ItemTemplate>
                                    <asp:Label ID="lblPurchaseID" runat="server" Text='<%#Eval("PurchaseID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CreatedDateTime" HeaderStyle-Width="15%" ItemStyle-Width="15%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="CreatedDateTime|5">
                                <ItemTemplate>
                                    <asp:Label ID="lblCreatedDateTime" runat="server" Text='<%#Eval("PurchaseOrderDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks" HeaderStyle-Width="20%" ItemStyle-Width="20%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Remarks|3">
                                <ItemTemplate>
                                    <asp:Label ID="lblRemarks" runat="server" Text='<%#Eval("Remarks") %>' ToolTip='<%#Eval("RemarksTip") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status" HeaderStyle-Width="10%" ItemStyle-Width="10%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Remarks|3">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("POStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty" HeaderStyle-Width="10%" ItemStyle-Width="10%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Qty|5">
                                <ItemTemplate>
                                    <asp:Label ID="lblQty" runat="server" Text='<%#Eval("Qty") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RemainQty" HeaderStyle-Width="10%" ItemStyle-Width="10%"
                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" SortExpression="Qty|5">
                                <ItemTemplate>
                                    <asp:Label ID="lblRemainQty" runat="server" Text='<%#Eval("RemainQty") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
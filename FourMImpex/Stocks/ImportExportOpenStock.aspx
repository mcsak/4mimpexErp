<%@ Page Title="" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="ImportExportOpenStock.aspx.cs" Inherits="FourMImpex.Stocks.ImportExportOpenStock" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
   <script language="javascript" type="text/javascript" src="../Script/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
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
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server" >
<div class="centeroutercontainer">
     <div class="headercontent">
     </div>
        <div class="headercontent">
            Import Export Open Stock</div>
                    <div class="showproductdetails">
                    <div >
                   <div style="float:left;margin-left:10px;width:100%;text-align:center;">
                       <asp:LinkButton ID="lnkDownloadTemplate" runat="server" Text="Click here" 
                           onclick="lnkDownloadTemplate_Click"></asp:LinkButton> &nbsp;to download template</div>
                    <div style="float:left;text-align:center;width:100%;margin-top:20px;">
                    <asp:FileUpload ID="FileupdImport" runat="server" /><br />
                    <br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                            onclick="btnSubmit_Click" />&nbsp;<%--<asp:Button 
                        ID="btnClose" runat="server" Text="Back To Grid" PostBackUrl="~/Stocks/OpenStockGrid.aspx" />--%>
                       <asp:LinkButton ID="lnkCheckanyunimportedData" runat="server" 
                            Text="Click here to check if any un imported stock" onclick="lnkCheckanyunimportedData_Click" 
                           ></asp:LinkButton> 
                        </div>
                        
                    </div>
                    </div>

                 <div class="admingridcontainer">
                    <div class="admingridsearchcontainer" >
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
                       &nbsp;
                    </div>
                </div>
                 <div class="admingridcontainer">
<asp:GridView ID="GvOpenStockExport" CssClass="GridViewStyle" runat="server"  OnPageIndexChanging="GvOpenStockExport_SelectedIndexChanged"
                            FooterStyle-BackColor="Black" PagerStyle-HorizontalAlign="Center" HorizontalAlign="Center"
                            AllowSorting="True" AutoGenerateColumns="false" TabIndex="7" Width ="80%">
                           
                            <Columns>
                                <asp:TemplateField HeaderText="#" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsNo" runat="server" class="gridColumns " EnableTheming="false"
                                            Text=' <%# Container.DataItemIndex+1%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="StockID" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="StockID" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                    <asp:BoundField DataField="ProductID" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="ProductID" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                    <asp:BoundField DataField="ProductName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="ProductName" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                    <asp:BoundField DataField="BrandID" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="BrandID" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                <asp:BoundField DataField="BrandName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="BrandName" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                       <asp:BoundField DataField="ModelID" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="ModelID" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>  
                                       <asp:BoundField DataField="ModelName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="ModelName" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                       <asp:BoundField DataField="SerialNo" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="SerialNo" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                       <asp:BoundField DataField="Remarks" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Remarks" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                       <asp:BoundField DataField="Qty" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Qty" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                      
                                
                            </Columns>
                        </asp:GridView>
                        </div>
                        </div>
            
</div>
</asp:Content>

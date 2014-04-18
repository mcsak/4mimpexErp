<%@ Page Title="" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="Receipt.aspx.cs" Inherits="FourMImpex.Stocks.Receipt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
  <asp:UpdatePanel ID="UpdpanlReceipt" runat="server" >
  <ContentTemplate>
    <div class="centeroutercontainer">
<div class="headercontent"> </div>
<div class="headercontent"> </div>

<div class="adminfunctioninnercontainer">
<div class="admincontentcontainer">
    <div class="adminpagetitlecontainer"><asp:Label ID="lblPageTitle" runat="server" Text="Receipt"></asp:Label></div>
    <div class="adminfunctioncontainer">
    <div class="adminlabel">Receipt Type</div>
    <asp:RadioButton ID="RbtnBulkStock" Text="Bulk Stock" runat="server" AutoPostBack="true" Checked="true" />
    <asp:RadioButton ID="RbtnReceipt" runat="server" AutoPostBack="true" Text="Purchased Stock" />
    </div>    
</div>

</div>
<div class="showproductdetails">

            
                 <asp:GridView ID="GvProductList" AutoGenerateColumns="false" runat="server" >
                 <Columns>
                 
                 <asp:TemplateField>
                 <HeaderTemplate><asp:Label ID="lblgvID" runat="server" Text="S.No"></asp:Label> </HeaderTemplate>
                 <ItemTemplate> <asp:Label ID="lblgvIDval" runat="server" Text=' <%# Container.DataItemIndex+1%>'></asp:Label> </ItemTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="ProductName" HeaderText="Products Name" />
                 <asp:BoundField DataField="BrandName" HeaderText="Brand" />
                 <asp:BoundField DataField="ModelName" HeaderText="Model" />
                 <asp:BoundField DataField="OrderQty" HeaderText="Order Qty" />
                 <asp:BoundField DataField="PreviousQty" HeaderText="Pre.Rec.Qty" />                  
                 <asp:TemplateField ItemStyle-Width="30px" >
                 <HeaderTemplate> <asp:Label ID="gvlblQty" runat="server" Text="Rec.Qty"></asp:Label></HeaderTemplate>
                 <ItemTemplate>
                 <asp:TextBox ID="gvtxtQty" runat="server" CssClass="gridTextboxqty" Text='<%# Bind("CurrentQty") %>' MaxLength="3" AutoCompleteType="Disabled"></asp:TextBox>
                  <ajx:FilteredTextBoxExtender ID="filternumber" runat="server" TargetControlID="gvtxtQty" FilterType="Numbers"></ajx:FilteredTextBoxExtender>
                <asp:HiddenField ID="hdnModelID" runat="server" Value='<%# Bind("ModelID") %>' />
                <asp:HiddenField ID="hdnPurchaseID" runat="server" Value='<%# Bind("PurchaseIDMaster") %>' />
                <asp:HiddenField ID="hdnRemainQty" runat="server" Value='<%# Bind("RemainQty") %>' />
                 </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField ItemStyle-Width="30px" >
                 <HeaderTemplate> <asp:Label ID="gvlblSerialNo" runat="server" Text="Serial No."></asp:Label></HeaderTemplate>
                 <ItemTemplate>
                 <asp:TextBox ID="gvtxtSerialNo" runat="server" CssClass="gridTextboxqty" Text=" " AutoCompleteType="Disabled"></asp:TextBox>
                </ItemTemplate>
                 </asp:TemplateField>
                 </Columns>
                 </asp:GridView>

                 <asp:Panel ID="pnlBtnSubmit" runat="server" CssClass=""  >
                 <div id="divRemarks" runat="server" style="height:100px;padding:5px 10px 5px 10px;">
                 <div style="float:left;padding:20px 5px 0px 100px;"><asp:Label ID="lblremarks" runat="server" Text="Remarks :"></asp:Label> </div>
                 <div style="float:right;padding-right:150px;"><asp:TextBox Width="650px" Height="70px" ID="txtRemarks" runat="server" TextMode="MultiLine"></asp:TextBox></div>
                 </div>
                 <div style="text-align:center;">
                  <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                        EnableTheming="false" CssClass="btnCommonstyle" 
                         onclick="btnSubmit_Click"  /><asp:Button
                          ID="BtnBack" runat="server" Text="Back"  PostBackUrl="~/Stocks/ReceiptsGrid.aspx"
                        EnableTheming="false" CssClass="btnCommonstyle"  />
                                                
                 </div> 
        </asp:Panel>
        
                
                
            
        </div>

</div>
  
  </ContentTemplate>
  <Triggers></Triggers>
  </asp:UpdatePanel>
</asp:Content>

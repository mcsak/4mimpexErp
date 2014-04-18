<%@ Page Title="" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="PurchaseOrder.aspx.cs" Inherits="FourMImpex.Stocks.PurchaseOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

<asp:Panel ID="pnlinput" runat="server" >
        <div class="headercontent">
            Purchase Orders</div>
             <div class="RowContainer">
                <div class="singleitemcontainer">
            <div class="itemheader">
                Categories</div>
            <asp:ListBox runat="server" CssClass="ListBoxStyle" ID="LstProducts" AutoPostBack="true"  OnTextChanged="LstProducts_OnTextChanged">
                
            </asp:ListBox>
        </div>
                <div class="singleitemcontainer">
            <div class="itemheader">
                Brand</div>
            <asp:ListBox ID="LstBrands" runat="server" CssClass="ListBoxStyle" AutoPostBack="true" OnTextChanged="LstBrands_OnTextChanged">
                
            </asp:ListBox>
        </div>
                <div class="singleitemcontainer">
            <div class="itemheader">
                Model</div>
            <asp:ListBox ID="LstModels" runat="server"  CssClass="ListBoxStyle" AutoPostBack="true" OnTextChanged="LstModels_OnTextChanged">
                
            </asp:ListBox>
        </div>
              <div class="btncellcontainer">
            <asp:Button ID="btnAddToList" runat="server" Text="Add To List" EnableTheming="false" ValidationGroup="VGNone"
                CssClass="btnCommonstyle" onclick="btnAddToList_Click" />
        </div>   
             </div>  
        </asp:Panel>
        <asp:Panel ID="pnlProductDeatils" runat="server">
                      <div class="headercontent">
           Selected Product Details</div>
        <div class="showproductdetails">

            
                 <asp:GridView ID="GvProductList" runat="server" AutoGenerateColumns="false" OnRowCommand="GvProductList_OnRowCommand" >
                 <Columns>
                 
                 <asp:TemplateField>
                 <HeaderTemplate><asp:Label ID="lblgvID" runat="server" Text="S.No"></asp:Label> </HeaderTemplate>
                 <ItemTemplate> <asp:Label ID="lblgvIDval" runat="server" Text=' <%# Container.DataItemIndex+1%>'></asp:Label> </ItemTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="ProductName" HeaderText="Products Name" />
                 <asp:BoundField DataField="BrandName" HeaderText="Brand" />
                 <asp:BoundField DataField="ModelName" HeaderText="Model" />
                 <%--<asp:BoundField DataField="AvailableStock" HeaderText="Available Stock" />--%>
                 <asp:TemplateField ItemStyle-Width="30px" >
                 <HeaderTemplate> <asp:Label ID="gvlblQty" runat="server" Text="Order Qty"></asp:Label></HeaderTemplate>
                 <ItemTemplate>
                 <asp:TextBox ID="gvtxtQty" runat="server" CssClass="gridTextboxqty"  AutoCompleteType="Disabled" MaxLength="3" Text='<%# Bind("Qty") %>'></asp:TextBox>
                 <ajx:FilteredTextBoxExtender ID="filterqty" runat="server" TargetControlID="gvtxtQty" FilterType="Numbers" Enabled="true"></ajx:FilteredTextBoxExtender>
                <asp:HiddenField ID="hdnModelID" runat="server" Value='<%# Bind("ModelID") %>' />
                 </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField ItemStyle-HorizontalAlign="Center" >
                 <HeaderTemplate>
                    <asp:Label ID="lblGvlink" Text="Action" runat="server"></asp:Label>
                 </HeaderTemplate>
                 <ItemTemplate   >
                    <asp:LinkButton ID="lnkgvRemove" runat="server" Text="Remove"  CommandArgument=' <%# Container.DataItemIndex %>' CommandName="R" ></asp:LinkButton>
                 </ItemTemplate>
                 </asp:TemplateField>
                 </Columns>
                 </asp:GridView>
                 <asp:Panel ID="pnlBtnSubmit" runat="server" CssClass=""  >
                 <div style="height:100px;padding:5px 10px 5px 10px;">
                 <div style="float:left;padding:20px 5px 0px 100px;"><asp:Label ID="lblremarks" runat="server" Text="Remarks :"></asp:Label> </div>
                 <div style="float:right;padding-right:150px;"><asp:TextBox Width="650px" Height="70px" ID="txtRemarks" runat="server" TextMode="MultiLine"></asp:TextBox></div>
                 </div>
                 <div style="text-align:center;">
                  <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                        EnableTheming="false" CssClass="btnCommonstyle" onclick="btnSubmit_Click" />
                        <%--<input type="button" value="Print" id="btnprint" onclick="window.print();" xmlns:asp="#unknown" />--%>
                 </div> 
        </asp:Panel>
        
                
                
            
        </div>   
        </asp:Panel>
        
       



</asp:Content>

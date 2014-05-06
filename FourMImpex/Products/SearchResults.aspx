<%@ Page Title="" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="FourMImpex.Products.SearchResults" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="centeroutercontainer">
<asp:Panel ID="pnlSearchresults" runat="server">
<asp:GridView ID="GVSearchResults" runat="server" AutoGenerateColumns="false" AllowPaging="false" OnRowCommand="GVSearchResults_OnRowCommand"
 OnRowDataBound="GVSearchResults_OnRowDataBound" >
<Columns>
 <asp:TemplateField>
 <HeaderTemplate>#</HeaderTemplate>
 <ItemTemplate><asp:Label ID="lblSerialNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label> </ItemTemplate>
 </asp:TemplateField>
 <asp:BoundField HeaderText="Product ID/Barcode" DataField="EntityNameID" />
 <asp:BoundField HeaderText="Product/Brand/Model Name" DataField="EntityName" />
 <asp:BoundField HeaderText="Avaialbel Qty" DataField="AvailableQty" />
 
  <asp:TemplateField>
 <HeaderTemplate>Product Status</HeaderTemplate>
 <ItemTemplate><asp:LinkButton ID="lnkbtntoSell" runat="server" Text="View/Selling"  CommandName="ViewSell" CommandArgument='<%# Eval("ModelID") %>' ></asp:LinkButton>
 <asp:HiddenField ID="hdnStockQty" runat="server" Value="" />
 <asp:HiddenField ID="hdnType" runat="server" Value='<%# Eval("Type") %>' />
  </ItemTemplate> 
 </asp:TemplateField>
</Columns>
</asp:GridView>
</asp:Panel> 
</div>
</asp:Content>

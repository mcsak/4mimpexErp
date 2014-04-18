<%@ Page Title="" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="ReturnedStocksGrid.aspx.cs" Inherits="FourMImpex.Stocks.ReturnedStocksGrid" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

<asp:GridView ID="GVRetrurnedStocks" runat="server" >
<Columns>
<asp:TemplateField >
<HeaderTemplate>#</HeaderTemplate>
<InsertItemTemplate><asp:Label ID="lblSerialNo" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label> </InsertItemTemplate>
</asp:TemplateField>
<asp:BoundField HeaderText="Customer Name" DataField="CustomerName" />
<asp:BoundField HeaderText="P.O.#" DataField="PO" />
<asp:BoundField HeaderText="Product Details" DataField="ProductDetails" />
<asp:BoundField HeaderText="P.O. Date" DataField="PODate" />
<asp:BoundField HeaderText="Qty" DataField="Qty" />
<asp:BoundField HeaderText="Price" DataField="Amount" />
<asp:BoundField HeaderText="Status" DataField="Status" />
</Columns>
</asp:GridView>
</asp:Content>

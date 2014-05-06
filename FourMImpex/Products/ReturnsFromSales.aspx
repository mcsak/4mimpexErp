<%@ Page Title="Returns From Sales" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" CodeBehind="ReturnsFromSales.aspx.cs" Inherits="FourMImpex.Products.ReturnsFromSales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
<div class="headercontent">
           Product Details</div>
         <div class="adminpagegridcontainer">

            <div style="padding:20px">
                <div class="admingridsearchcontainer" id="divSearchContainer" runat="server">
                    <div class="pro_ddl_search">
                        <asp:DropDownList ID="ddlsearchby" runat="server" SkinID="CommonSearchBy" TabIndex="1">
                        <asp:ListItem Text="--Select--" Value="0" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Barcode" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Serial No" Value="2"></asp:ListItem>
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
                            onclick="imgSearch_Click"  />  <%--OnClick="imgSearch_Click"--%>
                        </span>
                    </div>
                    <div class="gridbtncontainer">
                        <%--<asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
                        <asp:Button ID="btnUpdate" runat="server" Text="Modify" OnClick="btnUpdate_Click"
                            OnClientClick="return isRecordSelected('modify')" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click"
                            OnClientClick="return isRecordSelected('delete')" />--%>
                    </div>
                </div>
                 <asp:GridView ID="GvProductList" runat="server" AutoGenerateColumns="false" 
                   ShowFooter="true">
                 <Columns>
                 
                 <asp:TemplateField>
                 <HeaderTemplate><asp:Label ID="lblgvID" runat="server" Text="S.No"></asp:Label> </HeaderTemplate>
                 <ItemTemplate> <asp:Label ID="lblgvIDval" runat="server" Text=' <%# Container.DataItemIndex+1%>'></asp:Label> </ItemTemplate>
                 <FooterTemplate>Total</FooterTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="ProductName" HeaderText="Products Name" />
                 <asp:BoundField DataField="BrandName" HeaderText="Brand" />
                 <asp:BoundField DataField="ModelName" HeaderText="Model" />
                 <asp:BoundField DataField="AvailableStock" HeaderText="Available Stock" />
                 <asp:BoundField DataField="Barcode" HeaderText="Barcode" />
                 <asp:TemplateField >
                 <HeaderTemplate> <asp:Label ID="gvlblReturnQty" runat="server" Text="Return Qty."></asp:Label></HeaderTemplate>
                 <ItemTemplate>
                 <asp:TextBox ID="gvtxtQty" runat="server" OnTextChanged="gvtxtQty_OnTextChanged" AutoPostBack="true" AutoCompleteType="Disabled" MaxLength="3" Text="1" ReadOnly="true"></asp:TextBox>
                   <ajx:FilteredTextBoxExtender ID="filternumber" runat="server" TargetControlID="gvtxtQty" FilterType="Numbers"></ajx:FilteredTextBoxExtender>
                <asp:HiddenField ID="hdnModelID" runat="server" Value='<%# Bind("ModelID") %>' />
                 </ItemTemplate>
                 <FooterTemplate>
                 <asp:Label ID="lblTotalQty" runat="server" ></asp:Label>
                 </FooterTemplate>
                 </asp:TemplateField>
                 
                 <asp:TemplateField >
                 <HeaderTemplate> <asp:Label ID="gvlblAmount" runat="server" Text="Amount"></asp:Label></HeaderTemplate>
                 <ItemTemplate>
                 <asp:TextBox ID="gvtxtPrice" runat="server" OnTextChanged="gvtxtPrice_OnTextChanged" AutoPostBack="true" AutoCompleteType="Disabled" Text='<%# Bind("Price") %>'></asp:TextBox>
                   <ajx:FilteredTextBoxExtender ID="filternumberPrice" runat="server" TargetControlID="gvtxtPrice" FilterType="Numbers"></ajx:FilteredTextBoxExtender>
                <asp:HiddenField ID="hdnPrice" runat="server" Value='<%# Bind("Price") %>' />
                 </ItemTemplate>
                 <FooterTemplate>
                 <asp:Label ID="lblTotalPrice" runat="server" ></asp:Label>
                 </FooterTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField>
                 <HeaderTemplate>
                        <asp:Label ID="lblSysPrice" runat="server" Text="Sys. Price" />
                 </HeaderTemplate>
                 <ItemTemplate>
                    <asp:Label ID="lblSysPriceVal" runat="server"  Text="0"/>
                 </ItemTemplate>
                 <FooterTemplate>
                 <asp:Label ID="lblSysPriceTotal" runat="server" />
                 </FooterTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField >
                 <HeaderTemplate>
                    <asp:Label ID="lblGvlink" Text="" runat="server"></asp:Label>
                 </HeaderTemplate>
                 <ItemTemplate>
                    <asp:LinkButton ID="lnkgvRemove" runat="server" Text="Remove" CommandArgument=' <%# Container.DataItemIndex %>' CommandName="R" ></asp:LinkButton>
                 </ItemTemplate>
                 </asp:TemplateField>
                 </Columns>
                 </asp:GridView>
                 <div style="text-align:center;padding:5px 0px 5px 0px;">
                 <asp:Button ID="btnSubmit" Text="Submit" runat="server" CssClass="btn" 
                         onclick="btnSubmit_Click" />
                         
                 </div>
            </div>
                <div class="ButtonsAtBottomBar">

                </div>
                
           
        </div>
</asp:Content>

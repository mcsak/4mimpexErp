<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Products/ProductSelection.aspx.cs"
 Inherits="FourMImpex.Products.ProductSelection" MasterPageFile="~/InnerMaster.Master" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <%--<script language="javascript" type="text/javascript" src="../Script/jquery-1.9.1.min.js"></script>--%>

    <script language="javascript" type="text/javascript">
        function PrintDetails()
         {
             debugger;
             winStatus = window.open('../Products/SellProduct.aspx', 'menubar=no,toolbar=no,location=no,hotkeys=no,status=no,copyhistory=no,width=865,height=300,scrollbars=yes,resizable=no,top=10,left=20');
             // __doPostBack('txtPnoofstep', 'OnTextChanged');      'RegistrationMarksPop',    
                return false;
            

        }
       </script>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <asp:UpdatePanel ID="Updpnl" runat="server" UpdateMode="Conditional" >
  <ContentTemplate>
  
    <div class="centeroutercontainer">
    <%--Product grouping designs--%>
    <div style="width:100%;">
        <div class="headercontent">
            Product Selection</div>
             <div class="RowContainer">
               <asp:Panel ID="pnlCategories" runat="server">
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
                </asp:Panel>
            </div>
            </div>

            <div class="SeperatorDiv"></div>

            <asp:Panel ID="PnlCustomerDeatails" runat="server" >
            <div style="width:1000px; min-height:20px;" id="DivCustomereatails">
        <div class="headercontent">
           Customer Details</div>
           <br />
           <%--<div class="divSeperator"></div>--%>
          <div >
          <br />
          <div style="width:100%; float:left;">
            <asp:RadioButton ID="rbtnNewCust" runat="server" GroupName="A"  AutoPostBack="true"
                  Text="New Customer" oncheckedchanged="rbtnNewCust_CheckedChanged" /> &nbsp;<asp:RadioButton 
                  ID="rbtnExistingCustomer" GroupName="A" runat="server" Text="Existing Customer" AutoPostBack="true"
                  oncheckedchanged="rbtnExistingCustomer_CheckedChanged" /> &nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblSelectCust"
                   Text="Select Customer :" runat="server"></asp:Label> &nbsp; <asp:DropDownList
                    ID="ddlCustomers" runat="server" Width="250px" AutoPostBack="true"
                  onselectedindexchanged="ddlCustomers_SelectedIndexChanged"></asp:DropDownList>
          </div>
          <div style="width:100%"><br /></div>
          <div runat="server" id="divCustomer">
          <div style="height:5px;">           
          </div>
          <div style="width:33%;float:left;">
          <asp:Label ID="lblCustName" runat="server" Text="Customer Name" ></asp:Label> &nbsp; : 
              <asp:TextBox ID="txtCustomerName" runat="server" CssClass="textBoxStyle" >
           </asp:TextBox>
          </div>
          <div style="width:33%;float:left;">
            <asp:Label ID="lblContactNumber" runat="server" Text="Contact No."></asp:Label>&nbsp; : <asp:TextBox ID="txtContact" runat="server" CssClass="textBoxStyle">
           </asp:TextBox>
          </div>
          <div style="width:33%;float:right;">
             <asp:Label ID="lblEmailID" runat="server" Text="E-mail ID" />&nbsp; : <asp:TextBox ID="txtEmailID" runat="server" CssClass="textBoxStyle" />
          </div>
           
           <div >
           <br />           
          </div>
          <div style="width:100%;float:left; ">
            <asp:Label ID="lblOtherDetails" runat="server" Text="Other Details"/>&nbsp; : <asp:TextBox ID="txtOthers" runat="server" TextMode="MultiLine" CssClass="txtRemarks"/>
          </div>        
        
        <div style="width:100%"><br /></div>
           
           
           </div>
           </div>
           <br />
           <%--<div class="divSeperator"></div>--%>
           </div>
           </asp:Panel>
           <div class="SeperatorDiv"></div>
           <br />
           <div style="width:100%"><br /></div>
         <div class="headercontent">
           Product Details</div>
           <div class="productdetailright">
                  <asp:Button ID="btnSellProduct" runat="server" Text="Sell Product" 
                        EnableTheming="false" CssClass="btnCommonstyle"
                         onclick="btnSellProduct_Click" />
                        <%--<input type="button" value="Print" id="btnprint" onclick="window.print();" xmlns:asp="#unknown" />--%>
                </div>
        <div class="showproductdetails">
        
            <div class="RowContainerGrid">
                 <asp:GridView ID="GvProductList" runat="server" AutoGenerateColumns="false" OnRowCommand="GvProductList_OnRowCommand" 
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
                 <asp:TemplateField >
                 <HeaderTemplate> <asp:Label ID="gvlblQty" runat="server" Text="Qty"></asp:Label></HeaderTemplate>
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
            </div>
                <div class="productdetailleft">

                </div>
                
            
        </div>
    </div>

    </ContentTemplate>
  <Triggers>
  <asp:AsyncPostBackTrigger ControlID="btnAddToList" />
  
  </Triggers>
  </asp:UpdatePanel>
</asp:Content>

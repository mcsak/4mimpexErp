<%@ Page Title="Barcode Generate And Prints" Language="C#" MasterPageFile="~/InnerMaster.Master" AutoEventWireup="true" 
CodeBehind="BarcodeGenerator.aspx.cs" Inherits="FourMImpex.Products.BarcodeGenerator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../Script/jquery-1.9.1.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <div class="admininnercontainer">
        <div class="admincontentcontainer">
            <div class="adminpagetitlecontainer">
                Barcode Generation</div>
            <div class="adminpagegridcontainer">
              <div class="divrptDatecontainer" >
                    <div class="divrptinnercontainer">
                        
                        <div style="float: right; width: 140px; text-align :right; ">
                            &nbsp;
                            </div>
                    </div>
                </div>
                <div class="admingridcontainer">
                    <div class="admingridsearchcontainer" style =" display :none ;">
                    <div class="pro_ddl_search">
                        <asp:DropDownList ID="ddlsearchbyold" runat="server" SkinID="CommonSearchBy" TabIndex="1">
                        </asp:DropDownList>
                    </div>
                    <div class="pro_searchtext">
                        <span class="gridsearch_txt">
                            <asp:TextBox ID="txtsearchold" runat="server" SkinID="CommonGridSearch" TabIndex="2"
                                MaxLength="50"></asp:TextBox>
                        </span><span class="gridsearch_pic">
                            <asp:ImageButton ID="imgSearchold" runat="server" Height="20px" Width="23px" TabIndex="3"
                                OnClientClick="return gridsearchvalidation()" CommandArgument="S" ImageAlign="Top"
                                ToolTip="Go" ImageUrl="~/Images/searchicongrid.png"  />
                        </span>
                    </div>
                    <div class="gridbtncontainer">
                       &nbsp;
                    </div>
                </div>
                    <%--<asp:Panel ID="pnlcontainer" runat="server" HorizontalAlign="Center" ScrollBars="Horizontal" Width="900px" 
                        BorderWidth="1px" BorderStyle="Solid" Visible="false">--%>
                        <div class="adminpagegridcontainer">
                        <div class="admingridsearchcontainer" >
                    <div class="pro_ddl_search">
                        <asp:DropDownList ID="ddlSearchBy" runat="server" SkinID="CommonSearchBy" TabIndex="1">
                        <asp:ListItem Value="0" Text="<--Select-->"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Model Name"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="pro_searchtext">
                        <span class="gridsearch_txt">
                            <asp:TextBox ID="txtsearch" runat="server" SkinID="CommonGridSearch" TabIndex="2"
                                MaxLength="50"></asp:TextBox>
                        </span><span class="gridsearch_pic">
                            <asp:ImageButton ID="imgSearchby" runat="server" Height="20px" Width="23px" TabIndex="3" ImageAlign="Top"
                                ToolTip="Go" ImageUrl="~/Images/searchicongrid.png" onclick="imgSearchby_Click"   />
                        </span>
                    </div>
                    <div class="gridbtncontainer" style="width:100px;padding-right:5px;padding-top:3px;">
                        <asp:Button ID="btnPrint" runat="server" onclick="btnPrint_Click" 
                            Text="Print" />
                    </div>
                </div>
                <div class="admingridcontainer">
                        <asp:GridView ID="GvCurrentStockReport" CssClass="GridViewStyle" runat="server" EnableTheming="false" 
                            FooterStyle-BackColor="Black" PagerStyle-HorizontalAlign="Center" HorizontalAlign="Center"
                            AllowSorting="True" AutoGenerateColumns="false" TabIndex="7" Width ="100%">
                           <HeaderStyle BackColor="#02498d" ForeColor="White" Font-Size="Medium" />
                            <Columns>
                                <asp:TemplateField HeaderText="#"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsNo" runat="server" class="gridColumns " EnableTheming="false"
                                            Text=' <%# Container.DataItemIndex+1%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField >
                                <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">                                
                                <ItemTemplate><asp:CheckBox ID="ChkSelectStock" runat="server" />
                                
                                <asp:HiddenField ID="hdnStockID" runat="server" Value='<%# Eval("M_StockID") %>' /> </ItemTemplate>                                
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Products Name" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                    <asp:BoundField DataField="BrandName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Brand Name" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                    <asp:BoundField DataField="ModelName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Model Name" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                
                                
                            </Columns>
                        </asp:GridView>
                        </div>
                        </div>
                    <%--</asp:Panel>--%>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

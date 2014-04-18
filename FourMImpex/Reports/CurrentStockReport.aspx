<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Reports/CurrentStockReport.aspx.cs"
    Inherits="FourMImpex.Reports.CurrentStockReport" MasterPageFile="~/InnerMaster.Master" %>

<asp:Content ID="ModelHeadContent" ContentPlaceHolderID="ContentPlaceHolderHead"
    runat="server">
    <title>Current Stock Report</title>
    <link href="../Style/Admin.css" rel="Stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../Script/jquery-1.9.1.min.js"></script>
    <script language="javascript" type="text/javascript">
        function DatetextBoxClick(D) {
            document.getElementById(D).click();
        }
        function validate() {
            if (document.getElementById('txtFrom').value == "") {
                alert('Select the from date.');
                document.getElementById('txtFrom').focus();
                return false;
            }
            if (document.getElementById('txttodt').value == "") {
                alert('Select the to date.');
                document.getElementById('txttodt').focus();
                return false;
            }
            return true;
        }
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
<asp:Content ID="ModelMainContent" ContentPlaceHolderID="ContentPlaceHolderMain"
    runat="server">
    <div class="admininnercontainer">
        <div class="admincontentcontainer">
            <div class="adminpagetitlecontainer">
                Current Stock Report</div>
            <div class="adminpagegridcontainer">
              <div class="divrptDatecontainer" >
                    <div class="divrptinnercontainer">
                        <div class="divrptfrom" style="visibility:hidden;">
                            From Date</div>
<%--
                        <div class="divrptFromtext">
                            <div style="float: left; width: 105px;">
                                <asp:TextBox ID="txtFrom" runat="server" EnableTheming="False" Width="95px" BackColor="#FFFFFF"
                                    BorderStyle="Solid" Font-Size="12px" Font-Names="Verdana" ForeColor="#585880"
                                    BorderColor="#585880" BorderWidth="1pt" OnClick="DatetextBoxClick('imgCalFrmDt')" />
                            </div>
                            <div style="float: left; width: 15px;padding-top :3px;">
                                <asp:ImageButton runat="Server" ID="imgCalFrmDt" ImageUrl="~/Images/Cal.gif" Width="15px"
                                    AlternateText="Click to show calendar" ImageAlign="AbsMiddle" TabIndex="1" /><ajx:CalendarExtender
                                        ID="CalendarExtender1" runat="server" PopupPosition="Right" TargetControlID="txtFrom"
                                        Format="dd/MMM/yyyy" CssClass="MyCalendar" PopupButtonID="imgCalFrmDt" />
                            </div>
                        </div>
--%>
                       <%-- <div style ="float :left ; width :80px; text-align :center ;" style="visibility:hidden;">
                            To Date</div>--%>
<%--
                        <div class="divrptFromtext">
                            <div style="float: left; width: 110px;">
                                <asp:TextBox ID="txtto" runat="server" EnableTheming="False" Width="95px" BackColor="#FFFFFF"
                                    BorderStyle="Solid" Font-Size="12px" Font-Names="Verdana" ForeColor="#585880"
                                    BorderColor="#585880" BorderWidth="1pt" OnClick="DatetextBoxClick('imgCalToDt')" />
                            </div>
                            <div style="float: left; width: 15px; padding-top :3px;">
                                <asp:ImageButton runat="Server" ID="imgCalToDt" ImageUrl="~/Images/Cal.gif" Width="15px"
                                    AlternateText="Click to show calendar" ImageAlign="AbsMiddle" TabIndex="1" /><ajx:CalendarExtender
                                        ID="CalendarExtender2" runat="server" PopupPosition="Right" TargetControlID="txtto"
                                        Format="dd/MMM/yyyy" CssClass="MyCalendar" PopupButtonID="imgCalToDt" />
                            </div>
                        </div>
--%>
                        <div style="float: right; width: 140px; text-align :right; ">
                            <asp:Button runat="server" ID="btnView" Text="View" Visible="false" />&nbsp;
                            <asp:Button runat="server" ID="BtnExport" Text="Export" OnClick="BtnExport_Click" />
                        </div>
                    </div>
                </div>
                <div class="admingridcontainer">
                    <div class="admingridsearchcontainer" style =" display :none ;">
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
                    <asp:Panel ID="pnlcontainer" runat="server" HorizontalAlign="Center" ScrollBars="Horizontal"
                        BorderWidth="1px" BorderStyle="Solid" Visible="false">
                        <asp:GridView ID="GvCurrentStockReport" CssClass="GridViewStyle" runat="server"
                            FooterStyle-BackColor="Black" PagerStyle-HorizontalAlign="Center" HorizontalAlign="Center"
                            AllowSorting="True" AutoGenerateColumns="false" TabIndex="7" Width ="80%">
                           
                            <Columns>
                                <asp:TemplateField HeaderText="#"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsNo" runat="server" class="gridColumns " EnableTheming="false"
                                            Text=' <%# Container.DataItemIndex+1%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Products Name" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                    <asp:BoundField DataField="BrandName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Brand Name" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                    <asp:BoundField DataField="ModelName" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Model Name" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                <asp:BoundField DataField="Qty" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center"
                                    HeaderText="Quantity" HeaderStyle-Width="100px" ItemStyle-Width="100px"></asp:BoundField>
                                
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

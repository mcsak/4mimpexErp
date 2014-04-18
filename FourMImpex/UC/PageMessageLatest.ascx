<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageMessageLatest.ascx.cs" Inherits="FourMImpex.UC.PageMessageLatest" %>

<div class="pagemessagecontainer" id="sucessmsg" runat="server">
    <div class="adminpagemessagesuccesscontainer">
        <div class="adminpagemessage" id="Suc" runat="server">
        </div>
        <span class="adminmessageclose green">
            <img id="imgSucClose" runat="server" alt="Close" /></span>
    </div>
</div>
<div class="pagemessagecontainer" id="errormsg" runat="server">
    <div class="adminpagemessageerrorcontainer">
        <div class="adminpagemessage error" id="Err" runat="server">
        </div>
        <span class="adminmessageclose">
            <img id="imgErrClose" runat="server" alt="Close" /></span>
    </div>
</div>
<div class="pagemessagecontainer" id="warningmsg" runat="server">
    <div class="adminpagemessagewarningcontainer">
        <div class="adminpagemessage warning" id="war" runat="server">
        </div>
        <span class="adminmessageclose brown">
            <img id="imgWarClose" runat="server" alt="Close" /></span>
    </div>
</div>
<div class="pagemessagecontainer" id="infomsg" runat="server">
    <div class="adminpagemessageinfocontainer">
        <div class="adminpagemessage info" id="info" runat="server">
        </div>
        <span class="adminmessageclose blue">
            <img id="imgInfoClose" runat="server" alt="Close" /></span>
    </div>
</div>


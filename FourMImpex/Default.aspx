<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FourMImpex.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login</title>
     <link href="Style/Common.css" rel="stylesheet" type="text/css" /> 
   <link href="Style/Login.css" rel="Stylesheet" type="text/css" />
   <link href="Style/Footer.css" rel="Stylesheet" type="text/css" />
   <script src="../Script/jquery-1.9.1.min.js" type="text/javascript"></script>
   <script language="javascript" type="text/javascript">
       function validate() {
           if (document.getElementById('txtemail').value == "") {
               $('#lblmessage').html('Enter the email ID.');
               return false;
           }
           if (document.getElementById('txtpassword').value == "") {
               $('#lblmessage').html('Enter the password.');
               return false;
           }
       }
   
    </script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnlog">
    <div class="Mainloginpage">
        <div class="InnerLoginpage">
            <div class="MainCompanylogo">
                <div class="Innercompanylogo">
                    <asp:ImageButton ID="Cmplogo" ImageUrl="~/Images/4M.png" runat="server"  OnClientClick="return false;" style="cursor:default;"/>                    
                    </div>
            </div>
            <div class="Mainprofileimage">
                <div class="innerProfileimage">
                    <div class="Screenimage">
                        <div class="innerscreenimage">
                        </div>
                    </div>
                    <div class="LoginImage">
                        <div class="Loginheader">
                            <div class="innerloginheader">
                                Log In</div>
                        </div>
                        <div class="Loginspace123">
                        </div>                      
                         <div class="Loginspace123">
                        </div>
                        <div class="Loginspace123">
                        </div>                      
                         <div class="Loginspace123">
                        </div>
                         <div class="Loginspace123">
                        </div>
                         <div class="Loginspace123">
                        </div>
                        <div class="Loginheader">
                            <%-- <div class="Smallspace"></div>--%>
                            <div class="lblEmail">
                                Email ID</div>
                            <div class="Smallspace">
                            </div>
                            <div class="txtEmail">
                                <asp:TextBox ID="txtemail" runat="server" SkinID="textEmail" Font-Size="13px" Width="160px" Height="21px" MaxLength="50"></asp:TextBox>
                                  <script language="javascript" type="text/javascript">                                      document.getElementById('txtemail').focus();</script>
                                </div>
                        </div>
                        <div class="Loginspace">
                        </div>
                        <div class="Loginheader">
                            <%-- <div class="Smallspace"></div>--%>
                            <div class="lblEmail">
                                Password</div>
                            <div class="Smallspace">
                            </div>
                            <div class="txtEmail">
                                <asp:TextBox ID="txtpassword" runat="server" EnableTheming="false" Width="160px" Height="18px" TextMode="Password"  Font-Size="13px" MaxLength="50" ></asp:TextBox></div>
                        </div>
                        <div class="Loginspace12">
                        </div>
                        <div class="Loginheader">                           
                            <div class="lblEmail">
                            </div>
                            <div class="Smallspace">
                            </div>
                            <div class="txtEmail">
                                <asp:CheckBox ID="chkremmber" Text="Remember me" runat="server" CssClass="Remembertext" /></div>
                        </div>
                       
                        <div class="defaultLoginheader">                           
                            <div class="defaultloginlblEmail">
                            </div>
                            <div class="defaultloginSmallspace">
                            </div>
                            <div class="defaultloginbtn" style="color:#ffffff;">                                
                                    <asp:Label ID="lblmessage" Style="color: #ffffff; text-align: center;" runat="server"></asp:Label>                               
                            </div>
                        </div>
                        <div class="btnheader">                           
                            <div class="lblEmail">
                            </div>
                            <div class="Smallspace">
                            </div>
                            <div class="btnLogin">
                                <asp:Button ID="btnlog" Text="Login" runat="server" CssClass="loginbtn" UseSubmitBehavior="true"
                                    EnableTheming="false" onclick="btnlog_Click" OnClientClick="return validate()"   /></div>
                            <div class="Smspace">
                            </div>
                            <div class="fpassword" style="display:none;">
                            <asp:LinkButton ID="lnkForget" runat="Server" Text="Forgot Password?" 
                                    EnableTheming="false" CssClass="forgetPwd"  ></asp:LinkButton>
                               </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footerdefault">
          
          <UC:Footer ID="footer" runat="server"></UC:Footer>
    
            </div>
        </div>
    </div>
    </form>
</body>
</html>
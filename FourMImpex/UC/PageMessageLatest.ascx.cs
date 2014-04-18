using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FourMImpex.UC
{
    public partial class PageMessageLatest : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((ViewState["MsgUsed"] == null) && (!IsPostBack))
            {
                //Admin Page Message
                imgSucClose.Src = "~/Images/CloseIcon16.png";
                imgInfoClose.Src = "~/Images/CloseIcon16.png";
                imgErrClose.Src = "~/Images/CloseIcon16.png";
                imgWarClose.Src = "~/Images/CloseIcon16.png";
                sucessmsg.Style.Add("visibility", "hidden");
                sucessmsg.Style.Add("display", "none");
                errormsg.Style.Add("visibility", "hidden");
                errormsg.Style.Add("display", "none");
                warningmsg.Style.Add("visibility", "hidden");
                warningmsg.Style.Add("display", "none");
                infomsg.Style.Add("visibility", "hidden");
                infomsg.Style.Add("display", "none");

            }
        }
        public void SuccessMessage(string Msg)
        {
            imgSucClose.Src = "~/Images/CloseIcon16.png";
            imgInfoClose.Src = "~/Images/CloseIcon16.png";
            imgErrClose.Src = "~/Images/CloseIcon16.png";
            imgWarClose.Src = "~/Images/CloseIcon16.png";
            errormsg.Style.Add("visibility", "hidden");
            errormsg.Style.Add("display", "none");
            warningmsg.Style.Add("visibility", "hidden");
            warningmsg.Style.Add("display", "none");
            infomsg.Style.Add("visibility", "hidden");
            infomsg.Style.Add("display", "none");

            sucessmsg.Style.Add("visibility", "visible");
            sucessmsg.Style.Add("display", "block");
            Suc.InnerHtml = Msg;
            ViewState["MsgUsed"] = true;
        }

        public void ErrorMessage(string Msg)
        {
            imgSucClose.Src = "~/Images/CloseIcon16.png";
            imgInfoClose.Src = "~/Images/CloseIcon16.png";
            imgErrClose.Src = "~/Images/CloseIcon16.png";
            imgWarClose.Src = "~/Images/CloseIcon16.png";
            sucessmsg.Style.Add("visibility", "hidden");
            sucessmsg.Style.Add("display", "none");
            warningmsg.Style.Add("visibility", "hidden");
            warningmsg.Style.Add("display", "none");
            infomsg.Style.Add("visibility", "hidden");
            infomsg.Style.Add("display", "none");

            errormsg.Style.Add("visibility", "visible");
            errormsg.Style.Add("display", "block");
            Err.InnerHtml = Msg;
            ViewState["MsgUsed"] = true;
        }

        public void WarningMessage(string Msg)
        {
            imgSucClose.Src = "~/Images/CloseIcon16.png";
            imgInfoClose.Src = "~/Images/CloseIcon16.png";
            imgErrClose.Src = "~/Images/CloseIcon16.png";
            imgWarClose.Src = "~/Images/CloseIcon16.png";
            sucessmsg.Style.Add("visibility", "hidden");
            sucessmsg.Style.Add("display", "none");
            errormsg.Style.Add("visibility", "hidden");
            errormsg.Style.Add("display", "none");
            infomsg.Style.Add("visibility", "hidden");
            infomsg.Style.Add("display", "none");
            warningmsg.Style.Add("visibility", "visible");
            warningmsg.Style.Add("display", "block");
            war.InnerHtml = Msg;
            ViewState["MsgUsed"] = true;
        }

        public void InfoMessage(string Msg)
        {
            imgSucClose.Src = "~/Images/CloseIcon16.png";
            imgInfoClose.Src = "~/Images/CloseIcon16.png";
            imgErrClose.Src = "~/Images/CloseIcon16.png";
            imgWarClose.Src = "~/Images/CloseIcon16.png";
            sucessmsg.Style.Add("visibility", "hidden");
            sucessmsg.Style.Add("display", "none");
            errormsg.Style.Add("visibility", "hidden");
            errormsg.Style.Add("display", "none");
            warningmsg.Style.Add("visibility", "hidden");
            warningmsg.Style.Add("display", "none");
            infomsg.Style.Add("visibility", "visible");
            infomsg.Style.Add("display", "block");
            info.InnerHtml = Msg;
            ViewState["MsgUsed"] = true;
        }


    }
}
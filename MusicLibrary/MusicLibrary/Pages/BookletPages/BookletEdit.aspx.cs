using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MusicLibrary.Pages.BookletPages
{
    public partial class BookletEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SuccessMessage"] != null)
            {
                SuccessMessagePlaceHolder.Visible = true;
                SuccessMessageLiteral.Text = Session["SuccessMessage"].ToString();
                Session.Remove("SuccessMessage");
            }
        }
    }
}
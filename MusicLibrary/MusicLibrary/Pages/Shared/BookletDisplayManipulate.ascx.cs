using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using MusicLibrary.Model.BLL;

namespace MusicLibrary.Pages.Shared
{
    public partial class BookletDisplayManipulate : System.Web.UI.UserControl
    {
        private Service _service;

        private Service Service
        {
            get
            {
                return _service ?? (_service = new Service());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public Booklet BookletFormView_GetItem([RouteData]int id)
        {
            //try
            //{
            return Service.GetBooklet(id);
            //}
            //catch
            //{
            //    // TODO: skriv klart catch-satsen.
            //    throw new ApplicationException();
            //}
        }

        protected void BookletFormView_DataBound(object sender, EventArgs e)
        {
            Literal literal = Page.FindControl("yearOfPublicationLiteral") as Literal;
            if (literal != null && literal.Text == "1")
            {
                literal.Text = "<span class=\"defaultValue\">Okänt publiseringsår</span>";
            }

            literal = Page.FindControl("placeLiteral") as Literal;
            if (literal != null && literal.Text == "ZZ0000")
            {
                literal.Text = "<span class=\"defaultValue\">Ingen hyllplats</span>";
            }
        }
    }
}
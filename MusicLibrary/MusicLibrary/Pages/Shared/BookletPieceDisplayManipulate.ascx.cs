using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MusicLibrary.Model.BLL;

namespace MusicLibrary.Pages.Shared
{
    public partial class BookletPieceDisplayManipulate : System.Web.UI.UserControl
    {
        public int BookletID { get; set; }

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

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IEnumerable<Piece> BookletPiecesListView_GetData()
        {
            //try
            //{
                return Service.GetPieces(BookletID);
            //}
            //catch
            //{
            //}
        }

        protected void BookletPiecesListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Literal literal = e.Item.FindControl("catalogueNumberLiteral") as Literal;
            if (literal != null && literal.Text == "Inget nummer")
            {
                literal.Text = "<span class=\"defaultValue\">Inget nummer</span>";
            }

            literal = e.Item.FindControl("yearOfCompositionLiteral") as Literal;
            if (literal != null && literal.Text == "1")
            {
                literal.Text = "<span class=\"defaultValue\">Okänt kompositionsår</span>";
            }
        }
    }
}
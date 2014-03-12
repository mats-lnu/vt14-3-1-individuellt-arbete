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

        public bool ReadOnly { get; set; }

        private IEnumerable<Piece> Pieces { get; set; }

        private Service _service;
        private Service Service
        {
            get
            {
                return _service ?? (_service = new Service());
            }
        }

        public BookletPieceDisplayManipulate()
        {
            ReadOnly = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public IEnumerable<Piece> BookletPiecesListView_GetData()
        {
            // TODO: Fundera på att cacha resultatsetet.
            return Service.GetPieces(BookletID);
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

        protected void PlaceHolder_PreRender(object sender, EventArgs e)
        {
            if (ReadOnly)
            {
                PlaceHolder item = (PlaceHolder)sender;
                item.Visible = false;
            }
        }

        protected void BookletPiecesListView_PreRender(object sender, EventArgs e)
        {
            if (ReadOnly)
            {
                BookletPiecesListView.InsertItemPosition = InsertItemPosition.None;
            }
        }

        protected void PieceDropDownList_Load(object sender, EventArgs e)
        {
            // TODO: Fundera på att cacha resultatsetet bookletPieces.
            IEnumerable<Piece> allPieces = Service.GetPieces();
            IEnumerable<Piece> bookletPieces = Service.GetPieces(BookletID);
            List<Piece> filteredPieces = (from p in allPieces
                                          where !(bookletPieces.Select(pz => pz.PieceID).ToList()).Contains(p.PieceID)
                                          select p).ToList();
            DropDownList dp = (DropDownList)sender;

            foreach (Piece p in filteredPieces)
            {
                dp.Items.Add(new ListItem
                {
                    Text = String.Format("{0}, {1}, {2}, {3}", "Kompositör", p.Name, "Tonart", p.CatalogueNumber),
                    Value = p.PieceID.ToString()
                });
            }
        }
    }
}
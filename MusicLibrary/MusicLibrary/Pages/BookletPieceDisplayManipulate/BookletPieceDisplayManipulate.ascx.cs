using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MusicLibrary.Model.BLL;
using Resources;
using System.Web.ModelBinding;

namespace MusicLibrary.Pages.Shared
{
    public partial class BookletPieceDisplayManipulate : System.Web.UI.UserControl
    {
        public int BookletID { get; set; }
        public bool ReadOnly { get; set; }

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

        public void BookletPiecesListView_DeleteItem(int pieceID)
        {
            try
            {
                Service.DeleteBookletContent(BookletID, pieceID);
                Session["SuccessMessage"] = Strings.DeleteContentRecordSuccessSwedish;

                Response.RedirectToRoute("BookletEdit", new { id = BookletID });
                Context.ApplicationInstance.CompleteRequest();
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.DeleteContentRecordErrorSwedish);
            }
        }

        protected void BookletPiecesListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            BookletContent bc = e.Item.DataItem as BookletContent;
            // TODO: Cahca detta.
            IEnumerable<Piece> pieces = Service.GetPieces();
            Piece piece = pieces.FirstOrDefault(p => p.PieceID == bc.PieceID);

            Literal literal = e.Item.FindControl("composerLiteral") as Literal;
            if (literal != null)
            {
                literal.Text = "Kompositör";
            }

            literal = e.Item.FindControl("catalogueNumberLiteral") as Literal;
            if (literal != null && literal.Text == "Inget nummer")
            {
                literal.Text = "<span class=\"defaultValue\">Inget nummer</span>";
            }

            literal = e.Item.FindControl("nameLiteral") as Literal;
            if (literal != null)
            {
                literal.Text = piece.Name;
            }

            literal = e.Item.FindControl("catalogueNumberLiteral") as Literal;
            if (literal != null)
            {
                if (piece.CatalogueNumber == "Inget nummer")
                {
                    literal.Text = "<span class=\"defaultValue\">Inget nummer</span>";
                }
                else
                {
                    literal.Text = piece.CatalogueNumber;
                }
            }

            literal = e.Item.FindControl("scaleLiteral") as Literal;
            if (literal != null)
            {
                literal.Text = "Tonart";
            }

            literal = e.Item.FindControl("instrumentsLiteral") as Literal;
            if (literal != null)
            {
                literal.Text = "Instrument, Instrument, Instrument";
            }

            literal = e.Item.FindControl("genreLiteral") as Literal;
            if (literal != null)
            {
                literal.Text = "Genre";
            }
        }

        public IEnumerable<BookletContent> BookletPiecesListView_GetData()
        {
            return Service.GetBookletContentsByBookletID(BookletID);
        }

        public IEnumerable<Piece> PieceDropDownList_GetData()
        {
            IEnumerable<Piece> allPieces = Service.GetPieces();
            IEnumerable<BookletContent> bookletContentsInBooklet = Service.GetBookletContentsByBookletID(BookletID);
            List<int> li = bookletContentsInBooklet.Select(bc => bc.PieceID).ToList();
            return (from p in allPieces where !(li).Contains(p.PieceID) select p).ToList();
        }

        public void PieceDropDownList_PreRender(object sender, EventArgs e)
        {
            DropDownList dp = (DropDownList)sender;
            IEnumerable<Piece> pieces = Service.GetPieces();

            for (int i = 0; i < dp.Items.Count; i += 1)
            {
                Piece piece = pieces.FirstOrDefault(p => p.PieceID.ToString() == dp.Items[i].Text);
                dp.Items[i].Text = String.Format("{0}, {1}, {2}, {3}, {4}", "Kompositör", piece.Name, "Tonart", piece.CatalogueNumber, "Genre");
            }
        }

        public void BookletPiecesListView_InsertItem(BookletContent bookletContent)
        {
            if (Page.ModelState.IsValid)
            {
                try
                {
                    bookletContent.BookletID = BookletID;
                    Service.SaveBookletContent(bookletContent);

                    Session["SuccessMessage"] = Strings.InsertContentRecordSuccessSwedish;

                    Response.RedirectToRoute("BookletEdit", new { id = BookletID });
                    Context.ApplicationInstance.CompleteRequest();
                }
                catch
                {
                    Page.ModelState.AddModelError(String.Empty, Strings.InsertContentRecordErrorSwedish);
                }
            }
        }

    }
}
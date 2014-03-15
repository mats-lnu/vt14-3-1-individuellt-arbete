using MusicLibrary.Model.BLL;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MusicLibrary.Pages.Shared
{
    public enum Modes { ReadOnly, Edit };

    public partial class BookletPieceDisplayManipulate : System.Web.UI.UserControl
    {
        /// <summary>
        /// ID of the booklet with the content. Sets declaratively when the control is used.
        /// </summary>
        public int BookletID { get; set; }

        /// <summary>
        /// Sets the Mode of the ListView. If ReadOnly, only the ItemTemplate is shown.
        /// </summary>
        public Modes Mode { get; set; }

        /// <summary>
        /// Service-class in the application. Fetch and save data to the database.
        /// </summary>
        private Service _service;
        private Service Service
        {
            get
            {
                return _service ?? (_service = new Service());
            }
        }

        /// <summary>
        /// Constructor sets ReadOnly as Default mode.
        /// </summary>
        public BookletPieceDisplayManipulate()
        {
            Mode = Modes.ReadOnly;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Fetch records from table appSchema.BookletContent.
        /// </summary>
        /// <returns>A collection of BookletContent-instances.</returns>
        public IEnumerable<BookletContent> BookletPiecesListView_GetData()
        {
            try
            {
                return Service.GetBookletContentsByBookletID(BookletID);
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.SelectBookletContentRecordsErrorSwedish);
                return null;
            }
        }

        /// <summary>
        /// Fetch records from table appSchema.Piece to populate The DropDownList-control.
        /// </summary>
        /// <returns>A collection of Piece-instances.</returns>
        public IEnumerable<Piece> PieceDropDownList_GetData()
        {
            try
            {
                // Only the pieces that isn't already in the content list should be returned.
                IEnumerable<Piece> allPieces = Service.GetPieces();
                IEnumerable<BookletContent> bookletContentsInBooklet;

                bookletContentsInBooklet = Service.GetBookletContentsByBookletID(BookletID);

                List<int> li = bookletContentsInBooklet.Select(bc => bc.PieceID).ToList();
                return (from p in allPieces where !(li).Contains(p.PieceID) select p).ToList();
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.SelectPiecesToDropDownListErrorSwedish);
                return null;
            }
        }

        /// <summary>
        /// After the dataitem has been bound , makes text presentations of the pieces in the table.
        /// All default-values from the table is shown with italic style.
        /// For the moment the values for composer, scale and genre are static.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BookletPiecesListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            try
            {
                BookletContent bc = e.Item.DataItem as BookletContent;
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
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.GeneralErrorSwedish);
            }
        }

        /// <summary>
        /// DeleteMethod for BookletPiecesListView.
        /// </summary>
        /// <param name="pieceID">The ID for the piece that should be deleted.</param>
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

        /// <summary>
        /// InsertMethod for BookletPiecesListView
        /// </summary>
        /// <param name="bookletContent">The instance that should be inserted to the database.</param>
        public void BookletPiecesListView_InsertItem(BookletContent bookletContent)
        {
            if (Page.ModelState.IsValid)
            {
                try
                {
                    // Only PieceID is Bound from the control, this statement adds the BookletID.
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

        /// <summary>
        /// Checks if ListView is in ReadOnly mode. If so, the last column in the table is 
        /// hidden (the command-button column)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PlaceHolder_PreRender(object sender, EventArgs e)
        {
            if (Mode == Modes.ReadOnly)
            {
                PlaceHolder item = (PlaceHolder)sender;
                item.Visible = false;
            }
        }

        /// <summary>
        /// Checks if ListView is in ReadOnly mode. If so, the InsertItemTemplate is hidden.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BookletPiecesListView_PreRender(object sender, EventArgs e)
        {
            if (Mode == Modes.ReadOnly)
            {
                BookletPiecesListView.InsertItemPosition = InsertItemPosition.None;
            }
        }

        /// <summary>
        /// The dropdownlists item.text-values is changed to be a text presentation of the pieces.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void PieceDropDownList_PreRender(object sender, EventArgs e)
        {
            try
            {
                DropDownList dp = (DropDownList)sender;
                IEnumerable<Piece> pieces = Service.GetPieces();

                // For the moment the values for composer, scale and genre are static.
                for (int i = 0; i < dp.Items.Count; i += 1)
                {
                    Piece piece = pieces.FirstOrDefault(p => p.PieceID.ToString() == dp.Items[i].Text);
                    dp.Items[i].Text = String.Format("{0}, {1}, {2}, {3}, {4}", "Kompositör", piece.Name, "Tonart", piece.CatalogueNumber, "Genre");
                }
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.GeneralErrorSwedish);
            }
        }
    }
}
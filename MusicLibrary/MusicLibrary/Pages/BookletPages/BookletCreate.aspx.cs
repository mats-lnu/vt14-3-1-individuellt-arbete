using MusicLibrary.Model.BLL;
using MusicLibrary.Pages.Shared;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MusicLibrary.Pages.BookletPages
{
    public partial class BookletCreate : System.Web.UI.Page
    {
        /// <summary>
        /// Service-class in the application. Used to fetch and save content to the database.
        /// </summary>
        private Service _service;
        private Service Service
        {
            get
            {
                return _service ?? (_service = new Service());
            }
        }

        private List<BookletContent> TempBookletContentList
        {
            get
            {
                return Session["TempBookletContentList"] as List<BookletContent>;
            }
            set
            {
                Session["TempBookletContentList"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SuccessMessage"] != null)
            {
                SuccessMessagePlaceHolder.Visible = true;
                SuccessMessageLiteral.Text = Session["SuccessMessage"].ToString();
                Session.Remove("SuccessMessage");
            }

            if (IsPostBack)
            {
                TextBox nameTextBox = (TextBox)BookletCreateFromView.FindControl("nameTextBox");
                string name = nameTextBox.Text;
                Session["name"] = name;

                TextBox yearTextBox = (TextBox)BookletCreateFromView.FindControl("yearOfPublicationTextBox");
                string year = yearTextBox.Text;
                Session["year"] = year;

                TextBox placeTextBox = (TextBox)BookletCreateFromView.FindControl("placeTextBox");
                string place = placeTextBox.Text;
                Session["place"] = place;
            }
        }

        public IEnumerable<BookletContent> BookletPiecesListView_GetData()
        {
            try
            {
                return (IEnumerable<BookletContent>)TempBookletContentList;
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.SelectBookletContentRecordsErrorSwedish);
                return null;
            }
        }

        public IEnumerable<Piece> PieceDropDownList_GetData()
        {
            try
            {
                // Only the pieces that isn't already in the content list should be returned.
                IEnumerable<Piece> allPieces = Service.GetPieces();
                if (TempBookletContentList == null)
                {
                    TempBookletContentList = new List<BookletContent>(100);
                }
                IEnumerable<BookletContent> bookletContentsInBooklet = (IEnumerable<BookletContent>)TempBookletContentList;

                List<int> li = bookletContentsInBooklet.Select(bc => bc.PieceID).ToList();
                return (from p in allPieces where !(li).Contains(p.PieceID) select p).ToList();
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.SelectPiecesToDropDownListErrorSwedish);
                return null;
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

        public void BookletCreateFromView_InsertItem(Booklet booklet)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Before updating the YearOfPublication-field in the record, the input in yearOfPublicationTextBox is 
                    // converted to a DateTime-object.
                    TextBox yearTextBox = (TextBox)BookletCreateFromView.FindControl("yearOfPublicationTextBox");
                    booklet.YearOfPublication = new DateTime((Convert.ToInt32(yearTextBox.Text)), 1, 1);
                    booklet.PublisherID = 1;

                    if (TryUpdateModel(booklet))
                    {
                        Service.SaveBooklet(booklet);

                        // Saving content list
                        List<BookletContent> bc = (List<BookletContent>)Session["TempBookletContentList"];
                        for (int i = 0; i < bc.Count; i += 1)
                        {
                            bc[i].BookletID = booklet.BookletID;
                            Service.SaveBookletContent(bc[i]);
                        }

                        // If success, a success-message is shown.
                        Session.Remove("TempBookletContentList");
                        Session["SuccessMessage"] = String.Format(Strings.InsertNewBookletSuccessSwedish);
                        Response.RedirectToRoute("BookletDetails", new { id = booklet.BookletID });
                        Context.ApplicationInstance.CompleteRequest();
                    }
                }
                catch
                {
                    Page.ModelState.AddModelError(String.Empty, Strings.InsertNewBookletErrorSwedish);
                    return;
                }
            }
        }

        public void BookletPiecesListView_InsertItem(BookletContent bookletContent)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Only PieceID is Bound from the control.
                    bookletContent.BookletID = 0;

                    TempBookletContentList.Add(bookletContent);
                    Session["SuccessMessage"] = Strings.InsertContentRecordSuccessSwedish;

                    // TODO: Fixa den jävla URLen!!!
                    Response.Redirect("~/Pages/BookletPages/BookletCreate.aspx");
                    Context.ApplicationInstance.CompleteRequest();
                }
                catch
                {
                    Page.ModelState.AddModelError(String.Empty, Strings.InsertContentRecordErrorSwedish);
                }
            }
        }

        public void BookletPiecesListView_DeleteItem(int pieceID)
        {
            try
            {
                TempBookletContentList.RemoveAll(p => p.PieceID == pieceID);
                Session["SuccessMessage"] = Strings.DeleteContentRecordSuccessSwedish;

                // TODO: Fixa den jävla URLen!!!
                Response.Redirect("~/Pages/BookletPages/BookletCreate.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.DeleteContentRecordErrorSwedish);
            }
        }

        protected void BookletCreateFromView_PreRender(object sender, EventArgs e)
        {
            if (Session["name"] != null)
            {
                TextBox nameTextBox = (TextBox)BookletCreateFromView.FindControl("nameTextBox");
                nameTextBox.Text = Session["name"].ToString();
                Session.Remove("name");
            }

            if (Session["year"] != null)
            {
                TextBox yearTextBox = (TextBox)BookletCreateFromView.FindControl("yearOfPublicationTextBox");
                yearTextBox.Text = Session["year"].ToString();
                Session.Remove("year");
            }

            if (Session["place"] != null)
            {
                TextBox placeTextBox = (TextBox)BookletCreateFromView.FindControl("placeTextBox");
                placeTextBox.Text = Session["place"].ToString();
                Session.Remove("place");
            }
        }

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

        protected void PublisherDropDownList_PreRender(object sender, EventArgs e)
        {
            DropDownList dp = (DropDownList)sender;

            for (int i = 1; i <= 4; i += 1)
            {
                dp.Items.Add(new ListItem
                {
                    Text = String.Format("Förlag {0}", i),
                    Value = "1"
                });
            }
        }
    }
}
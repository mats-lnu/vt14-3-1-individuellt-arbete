﻿using MusicLibrary.Model.BLL;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MusicLibrary.Pages.BookletPages
{
    public partial class BookletsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SuccessMessage"] != null)
            {
                PlaceHolder successMessage = (PlaceHolder)ListViewBooklets.FindControl("SuccessMessagePlaceHolder");
                successMessage.Visible = true;
                Literal successMassageLiteral = (Literal)ListViewBooklets.FindControl("SuccessMessageLiteral");
                successMassageLiteral.Text = Session["SuccessMessage"].ToString();

                Session.Remove("SuccessMessage");
            }
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IEnumerable<MusicLibrary.Model.BLL.Booklet> ListViewBooklets_GetData()
        {
            try
            {
                return new Service().GetBooklets();
            }
            catch
            {
                Page.ModelState.AddModelError(String.Empty, Strings.SelectBookletsErrorSwedish);
                return null;
            }
        }

        /// <summary>
        /// After the dataitem has been bound this methods checks for default-values and mark
        /// them with font-style italic.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ListViewBooklets_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Literal literal = e.Item.FindControl("yearOfPubliationLabel") as Literal;
            if (literal != null && literal.Text == "1")
            {
                literal.Text = "<span class=\"defaultValue\">Okänt publiseringsår</span>";
            }
            literal = e.Item.FindControl("placeLabel") as Literal;
            if (literal != null && literal.Text == "ZZ0000")
            {
                literal.Text = "<span class=\"defaultValue\">Ingen hyllplats</span>";
            }
        }
    }
}
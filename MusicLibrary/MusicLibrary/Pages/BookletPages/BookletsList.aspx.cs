using MusicLibrary.Model.BLL;
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
                ModelState.AddModelError(String.Empty, "Ett fel inträffade då nothäftena hämtades.");
                return null;
            }
        }
    }
}
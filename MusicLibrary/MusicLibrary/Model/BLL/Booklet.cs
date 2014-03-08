using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MusicLibrary.Model.BLL
{
    public class Booklet
    {
        // TODO: Gör validering med Data annotations.

        public int BookletID { get; set; }

        public string Name { get; set; }

        public int PublisherID { get; set; }

        public DateTime YearOfPublication { get; set; }
    }
}
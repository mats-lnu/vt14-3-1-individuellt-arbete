using System;
using System.ComponentModel.DataAnnotations;

namespace MusicLibrary.Model.BLL
{
    /// <summary>
    /// The class represent a record in table appSchema.Booklet.
    /// </summary>
    public class Booklet
    {
        public int BookletID { get; set; }

        [Required(AllowEmptyStrings=false, ErrorMessage="Name can't be null.")]
        [StringLength(100, ErrorMessage="Name can not be more than 100 characters.")]
        public string Name { get; set; }

        [Required(ErrorMessage="PublisherID can't be null.")]
        [Range(0, Int32.MaxValue, ErrorMessage="PublisherID can not be smaller than 0.")]
        public int PublisherID { get; set; }

        [Required(ErrorMessage="YearOfPublication can't be null.")]
        public DateTime YearOfPublication { get; set; }
    }
}
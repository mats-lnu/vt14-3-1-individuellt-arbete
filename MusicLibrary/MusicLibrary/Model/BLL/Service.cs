using MusicLibrary.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MusicLibrary.Model.BLL
{
    /// <summary>
    /// Service class for applicaton MusicLibrary.
    /// </summary>
    public class Service
    {
        private BookletDAL _bookletDAL;

        private BookletDAL BookletDAL
        {
            get
            {
                return _bookletDAL ?? (new BookletDAL());
            }
        }

        /// <summary>
        /// Detel a record from table appSchema.Booklet.
        /// </summary>
        /// <param name="bookletID">Record to be deleted.</param>
        public void DeleteBooklet(int bookletID)
        {
            BookletDAL.DeleteBooklet(bookletID);
        }

        /// <summary>
        /// Select and return a record from table appSchema.Booklet.
        /// </summary>
        /// <param name="bookletID">Record to be selected.</param>
        /// <returns>An instance of MusicLibrary.Model.BLL.Booklet.</returns>
        public Booklet GetBooklet(int bookletID)
        {
            return BookletDAL.GetBookletByID(bookletID);
        }

        /// <summary>
        /// Select and return all records from table appSchema.Booklet.
        /// </summary>
        /// <returns>A collection of instances of MusicLibrary.Model.BLL.Booklet.</returns>
        public IEnumerable<Booklet> GetBooklets() 
        {
            return BookletDAL.GetBooklets();
        }

        /// <summary>
        /// Select and return records page wise from table appSchema.Booklet.
        /// </summary>
        /// <param name="startRowIndex">Start Row Index of the page.</param>
        /// <param name="maximumRows">Maximum number of Rows on the page.</param>
        /// <param name="totalRowCount">Total number of rows in table appSchema.Booklet.</param>
        /// <returns>A collection of instances of MusicLibrary.Model.BLL.Booklet.</returns>
        public IEnumerable<Booklet> GetBooklets(int startRowIndex, int maximumRows, out int totalRowCount)
        {
            return BookletDAL.GetBooklets(startRowIndex, maximumRows, out totalRowCount);
        }

        /// <summary>
        /// Insert or update a record in table appSchema.Booklet.
        /// </summary>
        /// <param name="booklet">An instance of MusicLibrary.Model.BLL.Booklet.</param>
        public void SaveBooklet(Booklet booklet)
        {
            ICollection<ValidationResult> validatonResults = new List<ValidationResult>();

            // Using extension method for validating.
            if (booklet.Validate(out validatonResults))
            {
                if (booklet.BookletID == 0)
                {
                    BookletDAL.InsertBooklet(booklet);
                }
                else
                {
                    BookletDAL.UpdateBooklet(booklet);
                }
            }
            else
            {
                var ex = new ApplicationException("An error occurred while saving the booklet.");
                ex.Data.Add("ValidationResult", validatonResults);
                throw ex;
            }
        }
    }
}
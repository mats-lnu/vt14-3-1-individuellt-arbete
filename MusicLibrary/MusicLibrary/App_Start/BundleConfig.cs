using System.Web.Optimization;

namespace MusicLibrary
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/Scripts/modernizr").Include(
                "~/Scripts/modernizr-*"
            ));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                "~/Content/SiteStyle.css"
            ));
        }
    }
}
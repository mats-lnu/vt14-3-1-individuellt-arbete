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

            bundles.Add(new ScriptBundle("~/Scripts/foundation").Include(
                "~/Scripts/foundation.min.js"
            ));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                "~/Content/normalize.css",
                "~/Content/foundation.css",
                "~/Content/SiteStyle.css"
            ));
        }
    }
}
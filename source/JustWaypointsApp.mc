using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

const ID_LAST_LAT_DD    = "LastLatDeg";
const ID_LAST_LON_DD    = "LastLonDeg";
const ID_LAST_LAT_MM    = "LastLatMin";
const ID_LAST_LON_MM    = "LastLonMin";
const ID_LAST_LAT_SS    = "LastLatSec";
const ID_LAST_LON_SS    = "LastLonSec";
const ID_LAST_WP_NAME   = "LastWpName";
const ID_WAYPOINTS_LIST = "Waypoints";

var WPCtrl;

class JustWaypointsApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        WPCtrl = new WaypointController();
    }

    // onStart() is called on application start up
    function onStart(state) {
        //Storage.deleteValue(ID_LAST_LAT_DD);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new JustWaypointsView(), new JustWaypointsDelegate() ];
    }

}

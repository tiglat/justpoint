using Toybox.Application;
using Toybox.WatchUi;
using Utils;
using Toybox.Application.Storage as Storage;

const ID_LAST_LAT_DD    = "LastLatDeg";
const ID_LAST_LON_DD    = "LastLonDeg";
const ID_LAST_LAT_DM    = "LastLatDM";
const ID_LAST_LON_DM    = "LastLonDM";
const ID_LAST_LAT_DMS   = "LastLatDMS";
const ID_LAST_LON_DMS   = "LastLonDMS";
const ID_LAST_WP_NAME   = "LastWpName";
const ID_WAYPOINTS_LIST = "Waypoints";

var WPCtrl;

enum {
    LATITUDE,
    LONGITUDE
}

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        WPCtrl = new WaypointController();

    }

    // onStart() is called on application start up
    function onStart(state) {

        System.println("APPLICATION STARTED: " + Utils.getDateString());
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        if (WPCtrl != null) {
            WPCtrl.saveWaypoints();
        }
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new MainView(), new WatchUi.BehaviorDelegate() ];
    }

}

using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
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
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format(
            "$1$:$2$:$3$ $4$ $5$ $6$ $7$",
            [
                today.hour,
                today.min,
                today.sec,
                today.day_of_week,
                today.day,
                today.month,
                today.year
            ]
        );

        System.println("APPLICATION STARTED: " + dateString);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new MainView(), new WatchUi.BehaviorDelegate() ];
    }

}

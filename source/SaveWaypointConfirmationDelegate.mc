using Toybox.WatchUi;
using Toybox.Position;


class SaveWaypointConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    private var mType;

    function initialize(type) {
        ConfirmationDelegate.initialize();
        mType = type;
    }

    function onResponse(response) {
        if (response == CONFIRM_YES) {
            if (mType == Position.GEO_DEG) {
                WPCtrl.saveDegrees();
                System.println("Waypoint is saved");
            }

        }
    }

}

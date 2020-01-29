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

            switch (mType) {
                case Position.GEO_DEG: {
                    WPCtrl.saveDegrees();
                    System.println("DEG Waypoint is saved");
                    break;
                }

                case Position.GEO_DM: {
                    WPCtrl.saveDM();
                    System.println("DM Waypoint is saved");
                    break;
                }

                case Position.GEO_DMS: {
                    WPCtrl.saveDMS();
                    System.println("DMS Waypoint is saved");
                    break;
                }
            }
        }
    }

}

using Toybox.WatchUi;
using Utils;
using Toybox.Application.Storage as Storage;

class DeleteWaypointConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    private var mName;

    function initialize(name) {
        ConfirmationDelegate.initialize();
        mName = name;
    }

    function onResponse(response) {
        if (response == CONFIRM_YES) {

            WPCtrl.delete(mName);

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            System.println("Waypoint is deleted: " + mName);

        }
    }

}
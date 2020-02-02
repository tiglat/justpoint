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

            var waypoints = Storage.getValue($.ID_WAYPOINTS_LIST);
            waypoints.remove(mName);

            try {
                Storage.setValue($.ID_WAYPOINTS_LIST, waypoints);
            } catch (ex instanceof Toybox.Lang.StorageFullException) {
                WatchUi.pushView(new MessageView("Not enough memory"), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
                return;
            }

            Utils.removeWaypointFromPersistedContent(mName);

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            System.println("Waypoint is deleted: " + mName);

        }
    }

}
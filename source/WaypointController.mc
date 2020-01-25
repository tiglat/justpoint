using Toybox.PersistedContent;
using Toybox.Position;
using Toybox.System;
using Toybox.Application.Storage as Storage;

class WaypointController {

    var mWaypoints;

    function initialize() {
        mWaypoints = Storage.getValue($.ID_WAYPOINTS_LIST);

        if (mWaypoints == null) {
            mWaypoints = {};
        }

    }

    function saveDegrees() {
        var name = Storage.getValue($.ID_LAST_WP_NAME);
        var lat  = Storage.getValue($.ID_LAST_LAT_DD);
        var lon  = Storage.getValue($.ID_LAST_LON_DD);

        if (name == null || lat == null || lon == null) {
            return;
        }

        var position = lat + ", " + lon;
        mWaypoints.put(name, position);

        try {
            Storage.setValue($.ID_WAYPOINTS_LIST, mWaypoints);
        } catch (ex instanceof Toybox.Lang.StorageFullException) {
            WatchUi.pushView(new MessageView("No memory to save waypoint"), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        exportWaypointToSavedLocationsDeg(name, position);
    }

//    function update() {
//    }
//
//    function delete() {
//    }
//
//    function deleteAll() {
//    }

    private function exportWaypointToSavedLocationsDeg(name, position) {
        System.println("Coordinates to convert: " + position);

        var location = $.parsePosition(position, Position.GEO_DEG);

        if (location == null) {
            WatchUi.pushView(new MessageView("Could not export to Saved Locations"), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        PersistedContent.saveWaypoint(location, {:name => name});
    }

}
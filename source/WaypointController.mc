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
            System.println("saveDegrees: some of input values is null");
            return;
        }

        var index = name.find(",");
        if (index != null) {
            // rename operation
            var prevName = name.substring(0, index);
            mWaypoints.remove(prevName);
            $.removeWaypointFromPersistedContent(prevName);
            name = name.substring(index + 1, name.length());
        }

        var position = lat + "," + lon;
        var waypointValue = "D," + position;
        mWaypoints.put(name, waypointValue);

        try {
            Storage.setValue($.ID_WAYPOINTS_LIST, mWaypoints);
        } catch (ex instanceof Toybox.Lang.StorageFullException) {
            WatchUi.pushView(new MessageView("No memory to save waypoint"), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        System.println("saveDegrees: name= " + name + ", position= " + position);

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
        System.println("exportWaypointToSavedLocationsDeg: Before conversion: " + position);

        $.removeWaypointFromPersistedContent(name);

        var location = $.parsePosition(position, Position.GEO_DEG);

        if (location == null) {
            System.println("parsePosition result is null");
            WatchUi.pushView(new MessageView("Could not export to Saved Locations"), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        System.println("exportWaypointToSavedLocationsDeg: After conversion: " + location.toDegrees());
        PersistedContent.saveWaypoint(location, {:name => name});
    }

}
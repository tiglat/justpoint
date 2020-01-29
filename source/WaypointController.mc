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

        name = removeWaypointToRename(name);

        var position = lat + "," + lon;
        var waypointValue = "D," + position;
        mWaypoints.put(name, waypointValue);
        saveWaypointsList();

        System.println("saveDegrees: name= " + name + ", position= " + position);

        exportWaypointToSavedLocations(name, position, Position.GEO_DEG);
    }

    function saveDM() {
        var name = Storage.getValue($.ID_LAST_WP_NAME);
        var lat  = Storage.getValue($.ID_LAST_LAT_DM);
        var lon  = Storage.getValue($.ID_LAST_LON_DM);

        if (name == null || lat == null || lon == null) {
            System.println("saveDM: some of input values is null");
            return;
        }

        name = removeWaypointToRename(name);

        var position = lat + "," + lon;
        mWaypoints.put(name, "M," + position);
        saveWaypointsList();

        System.println("saveDM: name= " + name + ", position= " + position);

        exportWaypointToSavedLocations(name, position, Position.GEO_DM);
    }

    function saveDMS() {
        var name = Storage.getValue($.ID_LAST_WP_NAME);
        var lat  = Storage.getValue($.ID_LAST_LAT_DMS);
        var lon  = Storage.getValue($.ID_LAST_LON_DMS);

        if (name == null || lat == null || lon == null) {
            System.println("saveDMS: some of input values is null");
            return;
        }

        name = removeWaypointToRename(name);

        var position = lat + "," + lon;
        mWaypoints.put(name, "S," + position);
        saveWaypointsList();

        System.println("saveDMS: name= " + name + ", position= " + position);

        exportWaypointToSavedLocations(name, position, Position.GEO_DMS);
    }

//    function update() {
//    }
//
//    function delete() {
//    }
//
//    function deleteAll() {
//    }

    private function exportWaypointToSavedLocations(name, position, format) {
        $.removeWaypointFromPersistedContent(name);

        var location = $.parsePosition(position, format);

        if (location == null) {
            System.println("parsePosition result is null");
            WatchUi.pushView(new MessageView("Could not export to Saved Locations"), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        System.println("exportWaypointToSavedLocations: will be exported to system: " + location.toDegrees());
        PersistedContent.saveWaypoint(location, {:name => name});
    }

    private function removeWaypointToRename(name) {
        var index = name.find(",");
        if (index != null) {
            // rename operation
            var prevName = name.substring(0, index);
            mWaypoints.remove(prevName);
            $.removeWaypointFromPersistedContent(prevName);
            name = name.substring(index + 1, name.length());
            Storage.setValue($.ID_LAST_WP_NAME, name);
        }
        return name;
    }

    private function saveWaypointsList() {
        try {
            Storage.setValue($.ID_WAYPOINTS_LIST, mWaypoints);
        } catch (ex instanceof Toybox.Lang.StorageFullException) {
            WatchUi.pushView(new MessageView("No memory to save waypoint"), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }
    }
}
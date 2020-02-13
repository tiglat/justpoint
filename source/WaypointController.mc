using Toybox.PersistedContent;
using Toybox.Position;
using Toybox.System;
using Toybox.Lang;
using Utils;
using Toybox.Application.Storage as Storage;

class WaypointController {

    var mWaypoints = {};
    var mNoMemoryPrompt;
    var mFailedExportPrompt;
    var mIsUpdated = false;

    public function initialize() {
        var waypoints = Storage.getValue($.ID_WAYPOINTS_LIST);

        if (waypoints != null && !waypoints.isEmpty()) {
            restoreWaypoints(waypoints);
        }

        mNoMemoryPrompt     = Rez.Strings.txt_no_memory;
        mFailedExportPrompt = Rez.Strings.txt_failed_export;
    }

    public function getWaypointList() {
        return mWaypoints;
    }

    public function getWaypoint(name) {

        if (mWaypoints.isEmpty()) {
            System.println("No waypoints in the array");
            return null;
        }

        return mWaypoints.get(name);
    }

    public function save(format) {
        var name = Storage.getValue($.ID_LAST_WP_NAME);
        var lat  = Utils.getLastLatitude(format);
        var lon  = Utils.getLastLongitude(format);

        if (name == null || lat == null || lon == null) {
            System.println("save: some of input values is null");
            return;
        }

        name = removeWaypointToRename(name);

        var waypoint;

        try {
            waypoint = new Waypoint(lat, lon, format);
        } catch (ex instanceof InvalidValueException) {
            System.println("Failed to create waypoint due to wrong argument");
            return;
        }

        mWaypoints.put(name, waypoint);
        mIsUpdated = true;
        exportWaypointToSavedLocations(name, waypoint);

        System.println("save: name= " + name + ", position= " + waypoint.getPosition());
    }

    public function delete(name) {
        mWaypoints.remove(name);
        Utils.removeWaypointFromPersistedContent(name);
        mIsUpdated = true;
    }

    public function deleteAll() {
        Storage.clearValues();
        Utils.removeAllWaypointsFromPersistedContent();
    }

    public function storeWaypoints() {

        if (!mIsUpdated) {
            return;
        }

        try {
            var names = mWaypoints.keys();
            var stringWaypoints = {};

            for (var i = 0; i < names.size(); i++) {
                var waypoint = mWaypoints.get(names[i]);
                stringWaypoints.put(names[i], waypoint.serialize());
            }

            Storage.setValue($.ID_WAYPOINTS_LIST, stringWaypoints);
        } catch (ex instanceof Toybox.Lang.StorageFullException) {
            System.println("StorageFullException during saving waypoints");
            return;
        }
    }

    private function restoreWaypoints(points) {

        var names = points.keys();

        for (var i = 0; i < names.size(); i++) {

            var value = points.get(names[i]);

            var index = value.find(",");
            if (index == null) {
                System.println("Wrong position value format for point: " + names[i]);
                continue;
            }

            var format = Position.GEO_DEG;
            var formatChar = value.substring(0, index);

            if (formatChar.equals("D")) {
                format = Position.GEO_DEG;
            } else if (formatChar.equals("M")) {
                format = Position.GEO_DM;
            } else if (formatChar.equals("S")) {
                format = Position.GEO_DMS;
            } else {
                System.println("Unknown postion format found for point: " + names[i]);
                continue;
            }

            var position = value.substring(index + 1, value.length());

            index = position.find(",");
            if (index == null) {
                System.println("Wrong position value format for point: " + names[i]);
                continue;
            }

            var lat = position.substring(0, index);
            var lon = position.substring(index + 1, position.length());

            mWaypoints.put(names[i], new Waypoint(lat, lon, format));
        }

    }

    private function exportWaypointToSavedLocations(name, waypoint) {
        Utils.removeWaypointFromPersistedContent(name);

        var location = waypoint.getLocation();

        if (location == null) {
            System.println("parsePosition result is null");
            WatchUi.pushView(new MessageView(mFailedExportPrompt), new MessageViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
            return;
        }

        System.println("exportWaypointToSavedLocations: will be exported to system: " + location.toDegrees());
        PersistedContent.saveWaypoint(location, {:name => name});
    }


    // In case of rename name has format "oldname,newname"
    private function removeWaypointToRename(name) {
        var index = name.find(",");
        if (index != null) {
            // rename operation
            var prevName = name.substring(0, index);
            mWaypoints.remove(prevName);
            Utils.removeWaypointFromPersistedContent(prevName);
            name = name.substring(index + 1, name.length());
            Storage.setValue($.ID_LAST_WP_NAME, name);
        }
        return name;
    }

}
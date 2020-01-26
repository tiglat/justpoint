using Toybox.WatchUi;
using Toybox.System;
using Toybox.Position;
using Toybox.Application.Storage as Storage;

class WaypointMenuDelegate extends WatchUi.Menu2InputDelegate {

    private var mWaypointName;
    private var mPositionFormat;
    private var mLatitude;
    private var mLongitude;

    function initialize(name) {
        Menu2InputDelegate.initialize();
        mWaypointName = name;

        var points = Storage.getValue($.ID_WAYPOINTS_LIST);

        if (points == null) {
            System.println("Failed to read waypoint array");
            return;
        }

        if (points.isEmpty()) {
            System.println("No waypoints in the array");
            return;
        }

        var value = points.get(name);

        var index = value.find(",");

        if (index == null) {
            System.println("Wrong position value format");
            return;
        }

        var format = value.substring(0, index);

        if (format.equals("D")) {
            mPositionFormat = Position.GEO_DEG;
        } else if (format.equals("M")) {
            mPositionFormat = Position.GEO_DM;
        } else if (format.equals("S")) {
            mPositionFormat = Position.GEO_DMS;
        } else {
            System.println("Unknown postion format found");
            return;
        }

        var position = value.substring(index + 1, value.length());
        index = position.find(",");

        if (index == null) {
            System.println("Wrong position value format");
            return;
        }

        mLatitude = position.substring(0, index);
        mLongitude = position.substring(index + 1, position.length());
     }

    function onSelect(item) {

        switch (item.getId()) {
            case :menu_edit_lat: {
                System.println("WAYPOINT MENU ==> Edit latitude");

                switch (mPositionFormat) {
                    case Position.GEO_DEG:
                    {
                        Storage.setValue($.ID_LAST_LAT_DD, mLatitude);
                        Storage.setValue($.ID_LAST_LON_DD, mLongitude);
                        Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                        WatchUi.pushView(
                            new DegreesCoordinatePicker(DegreesCoordinatePicker.LATITUDE),
                            new DegreesCoordinatePickerEditWaypointDelegate(DegreesCoordinatePicker.LATITUDE),
                            WatchUi.SLIDE_IMMEDIATE
                        );

                        break;
                    }
                }

                break;
            }
            case :menu_edit_lon: {
                System.println("WAYPOINT MENU ==> Edit longitude");

                switch (mPositionFormat) {
                    case Position.GEO_DEG:
                    {
                        Storage.setValue($.ID_LAST_LAT_DD, mLatitude);
                        Storage.setValue($.ID_LAST_LON_DD, mLongitude);
                        Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                        WatchUi.pushView(
                            new DegreesCoordinatePicker(DegreesCoordinatePicker.LONGITUDE),
                            new DegreesCoordinatePickerEditWaypointDelegate(DegreesCoordinatePicker.LONGITUDE),
                            WatchUi.SLIDE_IMMEDIATE
                        );

                        break;
                    }
                }

                break;
            }
            case :menu_rename: {
                System.println("WAYPOINT MENU ==> Rename ");


                break;
            }
            case :menu_delete: {
                System.println("WAYPOINT MENU ==> Delete");
                break;
            }
            default: {
                System.println("WAYPOINT MENU ==> Unsupported menu item: " + item.getId());
            }
        }

    }

}
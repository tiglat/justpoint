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

        var value = WPCtrl.getWaypoint(name);

        if (value == null) {
            throw new NoWaypointException("No such waypoint");
        }

        mPositionFormat = value.getFormat();
        mLatitude = value.getLatitude();
        mLongitude = value.getLongitude();
    }

    function onBack() {
        //remove waipoint menu and main menu to update the main menu
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onSelect(item) {

        switch (item.getId()) {
            case :menu_edit_lat: {
                System.println("WAYPOINT MENU ==> Edit latitude");
                editPosition($.LATITUDE, mPositionFormat);
                break;
            }
            case :menu_edit_lon: {
                System.println("WAYPOINT MENU ==> Edit longitude");
                editPosition($.LONGITUDE, mPositionFormat);
                break;
            }
            case :menu_rename: {
                System.println("WAYPOINT MENU ==> Rename ");

                switch (mPositionFormat) {
                    case Position.GEO_DEG:
                    {
                        Storage.setValue($.ID_LAST_LAT_DD, mLatitude);
                        Storage.setValue($.ID_LAST_LON_DD, mLongitude);
                        Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                        var picker = new WaypointNamePicker();
                        WatchUi.pushView(picker, new NamePickerEditWaypointDelegate(picker, Position.GEO_DEG), WatchUi.SLIDE_IMMEDIATE);

                        break;
                    }
                    case Position.GEO_DM:
                    {
                        Storage.setValue($.ID_LAST_LAT_DM, mLatitude);
                        Storage.setValue($.ID_LAST_LON_DM, mLongitude);
                        Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                        var picker = new WaypointNamePicker();
                        WatchUi.pushView(picker, new NamePickerEditWaypointDelegate(picker, Position.GEO_DM), WatchUi.SLIDE_IMMEDIATE);

                        break;
                    }
                    case Position.GEO_DMS:
                    {
                        Storage.setValue($.ID_LAST_LAT_DMS, mLatitude);
                        Storage.setValue($.ID_LAST_LON_DMS, mLongitude);
                        Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                        var picker = new WaypointNamePicker();
                        WatchUi.pushView(picker, new NamePickerEditWaypointDelegate(picker, Position.GEO_DMS), WatchUi.SLIDE_IMMEDIATE);

                        break;
                    }
                }

                break;
            }
            case :menu_delete: {
                System.println("WAYPOINT MENU ==> Delete");

                Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);
                var prompt = WatchUi.loadResource(Rez.Strings.txt_delete);

                WatchUi.pushView(
                    new WatchUi.Confirmation(prompt + " " + mWaypointName + "?"),
                    new DeleteWaypointConfirmationDelegate(mWaypointName),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }
            default: {
                System.println("WAYPOINT MENU ==> Unsupported menu item: " + item.getId());
            }
        }

    }

    private function editPosition(type, format) {

        switch (format) {
            case Position.GEO_DEG:
            {
                Storage.setValue($.ID_LAST_LAT_DD, mLatitude);
                Storage.setValue($.ID_LAST_LON_DD, mLongitude);
                Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                WatchUi.pushView(
                    new DegCoordinatePicker(type),
                    new DegCoordinatePickerEditWaypointDelegate(type),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }

            case Position.GEO_DM:
            {
                Storage.setValue($.ID_LAST_LAT_DM, mLatitude);
                Storage.setValue($.ID_LAST_LON_DM, mLongitude);
                Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                WatchUi.pushView(
                    new DmCoordinatePicker(type),
                    new DmCoordinatePickerEditWaypointDelegate(type),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }

            case Position.GEO_DMS:
            {
                Storage.setValue($.ID_LAST_LAT_DMS, mLatitude);
                Storage.setValue($.ID_LAST_LON_DMS, mLongitude);
                Storage.setValue($.ID_LAST_WP_NAME, mWaypointName);

                WatchUi.pushView(
                    new DmsCoordinatePicker(type),
                    new DmsCoordinatePickerEditWaypointDelegate(type),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }
        }
    }

}
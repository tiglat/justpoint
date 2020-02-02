using Toybox.System;
using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;


class DegCoordinatePickerAddWaypointDelegate extends WatchUi.PickerDelegate {

    var mType;

    function initialize(type) {
        PickerDelegate.initialize();
        mType = type;
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var coordinate = (values[0].equals("N") || values[0].equals("E") ? "+" : "-")
            //+ (values[1] == 0 ? "" : values[1])
            //+ (values[2] == 0 ? "" : values[2])
            + values[1]
            + values[2]
            + values[3]
            + "."
            + values[5]
            + values[6]
            + values[7]
            + values[8]
            + values[9];

        if (mType == $.LATITUDE) {
            Storage.setValue($.ID_LAST_LAT_DD, coordinate);

            WatchUi.pushView(
                new DegCoordinatePicker($.LONGITUDE),
                new DegCoordinatePickerAddWaypointDelegate($.LONGITUDE),
                WatchUi.SLIDE_IMMEDIATE
            );
        } else {
            Storage.setValue($.ID_LAST_LON_DD, coordinate);

            var picker = new WaypointNamePicker();
            WatchUi.pushView(picker, new NamePickerAddWaypointDelegate(picker, Position.GEO_DEG, 5), WatchUi.SLIDE_IMMEDIATE);

        }

        System.println("coordinate = " + coordinate);
    }

}
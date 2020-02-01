using Toybox.System;
using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;


class DmsCoordinatePickerEditWaypointDelegate extends WatchUi.PickerDelegate {

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
            + ":"
            + values[5]
            + values[6]
            + ":"
            + values[8]
            + values[9]
            + "."
            + values[11]
            + values[12];

        if (mType == $.LATITUDE) {
            Storage.setValue($.ID_LAST_LAT_DMS, coordinate);
        } else {
            Storage.setValue($.ID_LAST_LON_DMS, coordinate);
        }

        System.println("coordinate = " + coordinate);

        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        var prompt = WatchUi.loadResource(Rez.Strings.txt_save);

        WatchUi.pushView(
            new WatchUi.Confirmation(prompt + " " + coordinate),
            new SaveWaypointConfirmationDelegate(Position.GEO_DMS),
            WatchUi.SLIDE_IMMEDIATE
        );
    }

}
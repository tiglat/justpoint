using Toybox.System;
using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;


class DegCoordinatePickerEditWaypointDelegate extends WatchUi.PickerDelegate {

    var mType;

    function initialize(type) {
        PickerDelegate.initialize();
        mType = type;
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onAccept(values) {
        System.println("DegreesCoordinatePickerEditWaypointDelegate.onAccept");

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
        } else {
            Storage.setValue($.ID_LAST_LON_DD, coordinate);
        }

        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        System.println("Updated coordinate = " + coordinate);

        var prompt = WatchUi.loadResource(Rez.Strings.txt_save);

        WatchUi.pushView(
            new WatchUi.Confirmation(prompt + " " + coordinate),
            new SaveWaypointConfirmationDelegate(Position.GEO_DEG),
            WatchUi.SLIDE_IMMEDIATE
        );
        return true;
    }

}
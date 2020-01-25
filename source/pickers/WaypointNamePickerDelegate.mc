using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class WaypointNamePickerDelegate extends WatchUi.PickerDelegate {
    private var mPicker;
    private var mType;

    function initialize(picker, type) {
        PickerDelegate.initialize();
        mPicker = picker;
        mType = type;
    }

    function onCancel() {
        if(0 == mPicker.getTitleLength()) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
        else {
            mPicker.removeCharacter();
        }
    }

    function onAccept(values) {
        if (!mPicker.isDone(values[0])) {
            mPicker.addCharacter(values[0]);
        } else if (mPicker.getTitle().length() > 0){
            Storage.setValue(ID_LAST_WP_NAME, mPicker.getTitle());
            System.println("Waypoint name = " + mPicker.getTitle());

            // remove all picker views
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            var lat = "";
            var lon = "";

            if (mType == Position.GEO_DEG) {
                lat = Storage.getValue(ID_LAST_LAT_DD);
                lon = Storage.getValue(ID_LAST_LON_DD);
            }

            WatchUi.pushView(
                new WatchUi.Confirmation(Rez.Strings.txt_save + " " +lat + ", " + lon),
                new SaveWaypointConfirmationDelegate(mType),
                WatchUi.SLIDE_IMMEDIATE
            );

        }
    }

}


class SaveWaypointConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    private var mType;

    function initialize(type) {
        ConfirmationDelegate.initialize();
        mType = type;
    }

    function onResponse(response) {
        if (response == CONFIRM_YES) {
            if (mType == Position.GEO_DEG) {
                WPCtrl.saveDegrees();
            }

        }
    }

}

using Toybox.WatchUi;
using Utils;
using Toybox.Application.Storage as Storage;

class NamePickerAddWaypointDelegate extends WatchUi.PickerDelegate {
    private var mPicker;
    private var mFormat;
    private var mPopViewsNumber;

    function initialize(picker, format, popNumber) {
        PickerDelegate.initialize();
        mPicker = picker;
        mFormat = format;
        mPopViewsNumber = popNumber;
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

            // return to the Main View
            for (var i = 0; i < mPopViewsNumber; i++) {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }

            var lat = Utils.getLastLatitude(mFormat);
            var lon = Utils.getLastLongitude(mFormat);

            var prompt = WatchUi.loadResource(Rez.Strings.txt_save);

            WatchUi.pushView(
                new WatchUi.Confirmation(prompt + " " +lat + ", " + lon),
                new SaveWaypointConfirmationDelegate(mFormat),
                WatchUi.SLIDE_IMMEDIATE
            );

        }
    }

}



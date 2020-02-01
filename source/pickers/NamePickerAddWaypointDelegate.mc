using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class NamePickerAddWaypointDelegate extends WatchUi.PickerDelegate {
    private var mPicker;
    private var mFormat;
    private var mShouldPopViews;

    function initialize(picker, format, shouldPopViews) {
        PickerDelegate.initialize();
        mPicker = picker;
        mFormat = format;
        mShouldPopViews = shouldPopViews;
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

            if (mShouldPopViews) {
                // bring main view to foreground in order to update its content
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }

            var lat = getLastLatitude(mFormat);
            var lon = getLastLongitude(mFormat);

            var prompt = WatchUi.loadResource(Rez.Strings.txt_save);

            WatchUi.pushView(
                new WatchUi.Confirmation(prompt + " " +lat + ", " + lon),
                new SaveWaypointConfirmationDelegate(mFormat),
                WatchUi.SLIDE_IMMEDIATE
            );

        }
    }

}



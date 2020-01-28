using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class NamePickerAddWaypointDelegate extends WatchUi.PickerDelegate {
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

            // bring main view to foreground in order to update its content
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            var lat = "";
            var lon = "";

            switch (mType) {
                case Position.GEO_DEG: {
                    lat = Storage.getValue(ID_LAST_LAT_DD);
                    lon = Storage.getValue(ID_LAST_LON_DD);
                    break;
                }

                case Position.GEO_DM: {
                    lat = Storage.getValue(ID_LAST_LAT_DM);
                    lon = Storage.getValue(ID_LAST_LON_DM);
                    break;
                }
            }

            var prompt = WatchUi.loadResource(Rez.Strings.txt_save);

            WatchUi.pushView(
                new WatchUi.Confirmation(prompt + " " +lat + ", " + lon),
                new SaveWaypointConfirmationDelegate(mType),
                WatchUi.SLIDE_IMMEDIATE
            );

        }
    }

}



using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class WaypointNamePickerDelegate extends WatchUi.PickerDelegate {
    hidden var mPicker;

    function initialize(picker) {
        PickerDelegate.initialize();
        mPicker = picker;
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
            WPCtrl.saveDegrees();                        
            System.println("Waypoint name = " + mPicker.getTitle());
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }

}

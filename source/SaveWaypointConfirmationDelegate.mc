using Toybox.WatchUi;
using Toybox.Position;


class SaveWaypointConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    private var mFormat as Position.CoordinateFormat;

    function initialize(format as Position.CoordinateFormat) {
        ConfirmationDelegate.initialize();
        mFormat = format;
    }

    function onResponse(response) {
        if (response == CONFIRM_YES) {
            WPCtrl.save(mFormat);
            WatchUi.requestUpdate();
        }
        return true;
    }

}

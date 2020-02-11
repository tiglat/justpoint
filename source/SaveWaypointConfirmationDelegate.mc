using Toybox.WatchUi;
using Toybox.Position;


class SaveWaypointConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    private var mFormat;

    function initialize(format) {
        ConfirmationDelegate.initialize();
        mFormat = format;
    }

    function onResponse(response) {
        if (response == CONFIRM_YES) {
            WPCtrl.save(mFormat);
            WatchUi.requestUpdate();
        }
    }

}

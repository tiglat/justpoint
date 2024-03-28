using Toybox.WatchUi;

class GpsPositionProgressDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() {
        System.println("GpsPositionProgressDelegate: onBack");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}
using Toybox.WatchUi;

class GpsPositionViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onKey(keyEvent) {
        System.println("GpsPositionViewDelegate: onKey");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
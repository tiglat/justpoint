using Toybox.WatchUi;

class GpsPositionViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() {
        System.println("GpsPositionViewDelegate: onBack");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onSelect() {
        System.println("GpsPositionViewDelegate: onSelect");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        var picker = new WaypointNamePicker();
        WatchUi.pushView(picker, new NamePickerAddWaypointDelegate(picker, Position.GEO_DEG, 3), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}
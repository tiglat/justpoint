using Toybox.WatchUi;

class JustWaypointsDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new JustWaypointsMenuDelegate(), WatchUi.SLIDE_RIGHT);
        return true;
    }

}
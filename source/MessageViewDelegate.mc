using Toybox.WatchUi;

class MessageViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onKey(keyEvent) {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
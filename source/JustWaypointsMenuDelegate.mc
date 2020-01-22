using Toybox.WatchUi;
using Toybox.System;

class JustWaypointsMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
    
        switch (item.getId()) {
            case :menu_add: {
                System.println("Add");
                WatchUi.pushView(new Rez.Menus.AddMenu(), new AddMenuDelegate(), WatchUi.SLIDE_RIGHT);
                break;
            }
            case :delete_all: {
                System.println("Delete all");
                break;
            }
            case :menu_exit_app: {
                WatchUi.popView(WatchUi.SLIDE_LEFT);
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }
            default: {
                System.println("Unsupported menu item: " + item.getId());
            }
        }
        
    }

}
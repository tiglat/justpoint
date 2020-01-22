using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage as Storage;

class JustWaypointsMenuDelegate extends WatchUi.Menu2InputDelegate {

    private var _addNewWaypointMenu;
    private var _clearStorageConfirmText; 

    function initialize() {
        Menu2InputDelegate.initialize();
        
        _addNewWaypointMenu = new Rez.Menus.AddMenu();
        _clearStorageConfirmText = WatchUi.loadResource(Rez.Strings.txt_clear_storage);
    }

    function onSelect(item) {
    
        switch (item.getId()) {
            case :menu_add: {
                System.println("Add");
                WatchUi.pushView(_addNewWaypointMenu, new AddMenuDelegate(), WatchUi.SLIDE_RIGHT);
                break;
            }
            case :menu_delete_all: {
                System.println("Delete all");
                break;
            }
            case :menu_clean_storage: {
                System.println("Clean storage");
                WatchUi.pushView(new WatchUi.Confirmation(_clearStorageConfirmText), new ClearStorageConfirmationDelegate(), WatchUi.SLIDE_UP);               
                break;
            }
            case :menu_exit_app: {
                WatchUi.popView(WatchUi.SLIDE_LEFT);
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
                break;
            }
            default: {
                System.println("Unsupported menu item: " + item.getId());
            }
        }
        
    }

}

class ClearStorageConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    function initialize() {
        ConfirmationDelegate.initialize();
    }
    
    function onResponse(response) {
        if (response == CONFIRM_YES) {
            //Storage.clearValues();
            System.println("Storage is cleaned");
        }
    }
    
}
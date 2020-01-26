using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage as Storage;

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {

    private var mAddNewWaypointMenu;
    private var mEditWaypointMenu;
    private var mClearStorageConfirmText;

    function initialize() {
        Menu2InputDelegate.initialize();

        mAddNewWaypointMenu = new Rez.Menus.AddMenu();
        mClearStorageConfirmText = WatchUi.loadResource(Rez.Strings.txt_clear_storage);
    }

    function onSelect(item) {

        var commandId = item.getId();

        if (commandId == :menu_add_id) {

            System.println("MAIN MENU ==> Add");
            WatchUi.pushView(mAddNewWaypointMenu, new AddMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);

        } else if (commandId == :menu_delete_all_id) {

            System.println("MAIN MENU ==> Delete all");
            WPCtrl.saveDegrees();

        } else if (commandId == :menu_clean_storage_id) {

            System.println("MAIN MENU ==> Clean storage");
            WatchUi.pushView(new WatchUi.Confirmation(mClearStorageConfirmText), new ClearStorageConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);

        } else if (commandId == :menu_exit_app_id) {

            System.println("MAIN MENU ==> Exit App");
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        } else {

            var waypointName = item.getLabel();

            System.println("MAIN MENU ==> Waypoint selected: " + waypointName);

            mEditWaypointMenu = new Rez.Menus.WaypointMenu();
            mEditWaypointMenu.setTitle(waypointName);

            WatchUi.pushView(mEditWaypointMenu, new WaypointMenuDelegate(waypointName), WatchUi.SLIDE_IMMEDIATE);

        }

    }

    //exit app
    function onBack() {
        System.println("MainMenuDelegate.onBack()");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}

class ClearStorageConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == CONFIRM_YES) {
            Storage.clearValues();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            System.println("Storage is cleaned");
        }
    }

}
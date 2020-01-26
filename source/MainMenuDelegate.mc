using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage as Storage;

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {

    private var mAddNewWaypointMenu;
    private var mClearStorageConfirmText;

    function initialize() {
        Menu2InputDelegate.initialize();

        mAddNewWaypointMenu = new Rez.Menus.AddMenu();
        mClearStorageConfirmText = WatchUi.loadResource(Rez.Strings.txt_clear_storage);
    }

    function onSelect(item) {

        var commandId = item.getId();

        if (commandId == :menu_add_id) {

            System.println("Add");
            WatchUi.pushView(mAddNewWaypointMenu, new AddMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);

        } else if (commandId == :menu_delete_all_id) {

            System.println("Delete all");
            WPCtrl.saveDegrees();

        } else if (commandId == :menu_clean_storage_id) {

            System.println("Clean storage");
            WatchUi.pushView(new WatchUi.Confirmation(mClearStorageConfirmText), new ClearStorageConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);

        } else if (commandId == :menu_exit_app) {

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        } else {
            System.println("Unsupported menu item: " + item.getId());
        }

    }

    //exit app
    function onBack() {
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
            System.println("Storage is cleaned");
        }
    }

}
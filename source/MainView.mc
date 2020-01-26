using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class MainView extends WatchUi.View {

    private var mMainMenu;
    private var mWaypointsMenuDelegate;
    private var mMainMenuTitle;


    function initialize() {
        View.initialize();
        mMainMenuTitle = WatchUi.loadResource(Rez.Strings.menu_title_main);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        updateMenu();
        System.println("MainView onShow");
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        System.println("MainView onUpdate");
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    function updateMenu() {

        mMainMenu = new WatchUi.Menu2({:title=>mMainMenuTitle});

        var points = Storage.getValue($.ID_WAYPOINTS_LIST);

        if (points != null && !points.isEmpty()) {
            var wpNames = points.keys();

            for (var i = 0; i < wpNames.size(); i++) {
                var position = points.get(wpNames[i]);
                var formatSeparatorIndex = position.find(",");
                var label = position.substring(formatSeparatorIndex + 1, position.length());

                mMainMenu.addItem(
                    new WatchUi.MenuItem(
                        wpNames[i],
                        label,
                        wpNames[i],
                        {}
                    )
                );
            }
        }

        mMainMenu.addItem(new WatchUi.MenuItem(Rez.Strings.menu_label_add, null, :menu_add_id, {}));
        mMainMenu.addItem(new WatchUi.MenuItem(Rez.Strings.menu_label_delete_all, null, :menu_delete_all_id, {}));
        mMainMenu.addItem(new WatchUi.MenuItem(Rez.Strings.menu_label_clean_storage, null, :menu_clean_storage_id, {}));
        mMainMenu.addItem(new WatchUi.MenuItem(Rez.Strings.menu_label_exit_app, null, :menu_exit_app_id, {}));

        WatchUi.pushView(mMainMenu, new MainMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }

}




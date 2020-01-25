using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class JustWaypointsView extends WatchUi.View {

    private var mWaypointsMenu;
    private var mWaypointsMenuDelegate;
    private var mWaypointsMenuTitle;


    function initialize() {
        View.initialize();
        mWaypointsMenuTitle = WatchUi.loadResource(Rez.Strings.menu_title_waypoints);
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        updateMenu();
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    function updateMenu() {

        mWaypointsMenu = new WatchUi.Menu2({:title=>mWaypointsMenuTitle});

        var points = Storage.getValue($.ID_WAYPOINTS_LIST);

        if (points == null || points.isEmpty()) {
            return;
        }

        var wpNames = points.keys();

        for (var i = 0; i < wpNames.size(); i++) {
           mWaypointsMenu.addItem(
                new MenuItem(
                    wpNames[i],
                    points.get(wpNames[i]),
                    wpNames[i],
                    {}
                )
            );
        }

        WatchUi.pushView(mWaypointsMenu, new WaypointsMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }

}




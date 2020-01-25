using Toybox.WatchUi;

class JustWaypointsView extends WatchUi.View {

    private var _waypointsMenu;
    private var _waypointsMenuDelegate;


    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
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

//        waypointsMenu = new WatchUi.Menu();
//        waypointsMenu.setTitle(menuTitleStr);
//
//        var pointsIt = PersistedContent.getWaypoints();
//
//        var point = pointsIt.next();
//
//        while (point != null) {
//            waypointsMenu.addItem(point.getName(), point.getId());
//            point = pointsIt.next();
//        }
//
//        waypointsMenu.addItem(menuSaveStr, :item_save);
//        waypointsMenu.addItem(menuExitStr, :item_exit);


    }

}

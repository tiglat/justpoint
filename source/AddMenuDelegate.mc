using Toybox.WatchUi;
using Toybox.System;
using Toybox.Position;

class AddMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
     }

    function onSelect(item) {

        switch (item.getId()) {
            case :menu_degrees: {

                System.println("ADD NEW WAYPOINT MENU ==> Add in DD.DDDDD");

                WatchUi.pushView(
                    new DegCoordinatePicker($.LATITUDE),
                    new DegCoordinatePickerAddWaypointDelegate($.LATITUDE),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }
            case :menu_minutes: {
                System.println("ADD NEW WAYPOINT MENU ==> Add in DD DD.DDDD");

                WatchUi.pushView(
                    new DmCoordinatePicker($.LATITUDE),
                    new DmCoordinatePickerAddWaypointDelegate($.LATITUDE),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }
            case :menu_seconds: {
                System.println("ADD NEW WAYPOINT MENU ==> Add in DD MM SS.SS");

                WatchUi.pushView(
                    new DmsCoordinatePicker($.LATITUDE),
                    new DmsCoordinatePickerAddWaypointDelegate($.LATITUDE),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }
            case :menu_current: {
                System.println("ADD NEW WAYPOINT MENU ==> Current location");
                var prompt = WatchUi.loadResource(Rez.Strings.txt_wait_gps);
                var progressBar = new WatchUi.ProgressBar(prompt, 0.0);
                WatchUi.pushView(new GpsPositionView(progressBar), new GpsPositionViewDelegate(), WatchUi.SLIDE_IMMEDIATE);
                WatchUi.pushView(progressBar, new GpsPositionProgressDelegate(), WatchUi.SLIDE_IMMEDIATE);

                break;
            }
            default: {
                System.println("Unsupported menu item: " + item.getId());
            }
        }

    }


}
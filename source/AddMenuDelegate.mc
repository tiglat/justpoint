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
                    new DegreesCoordinatePicker(DegreesCoordinatePicker.LATITUDE),
                    new DegreesCoordinatePickerAddWaypointDelegate(DegreesCoordinatePicker.LATITUDE),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }
            case :menu_minutes: {
                System.println("ADD NEW WAYPOINT MENU ==> Add in DD DD.DDDD");

                WatchUi.pushView(
                    new MinutesCoordinatePicker(DegreesCoordinatePicker.LATITUDE),
                    new MinutesCoordinatePickerAddWaypointDelegate(DegreesCoordinatePicker.LATITUDE),
                    WatchUi.SLIDE_IMMEDIATE
                );

                break;
            }
            case :menu_seconds: {
                System.println("Selected menu seconds");
                break;
            }
            case :menu_current: {
                System.println("Selected menu current location");
                break;
            }
            default: {
                System.println("Unsupported menu item: " + item.getId());
            }
        }

    }

}
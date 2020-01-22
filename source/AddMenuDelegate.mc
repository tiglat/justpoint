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
                
                WatchUi.pushView(
                    new DegreesCoordinatePicker(DegreesCoordinatePicker.LATITUDE),  
                    new DegreesCoordinatePickerDelegate(DegreesCoordinatePicker.LATITUDE), 
                    WatchUi.SLIDE_LEFT
                );
                
                break;
            }
            case :menu_minutes: {
                System.println("Selected menu minutes");
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
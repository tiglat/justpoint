using Toybox.System;
using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;


class DegreesCoordinatePickerDelegate extends WatchUi.PickerDelegate {

    var _type;

    function initialize(type) {
        PickerDelegate.initialize();
        _type = type;
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var coordinate = (values[0].equals("N") || values[0].equals("E") ? "+" : "-") 
            //+ (values[1] == 0 ? "" : values[1]) 
            //+ (values[2] == 0 ? "" : values[2])
            + values[1]
            + values[2]
            + values[3]
            + "."
            + values[5]
            + values[6]
            + values[7]
            + values[8]
            + values[9];
    
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

        if (_type == DegreesCoordinatePicker.LATITUDE) {
            Storage.setValue(ID_LAST_LAT_DD, coordinate);
            
	        WatchUi.pushView(
	            new DegreesCoordinatePicker(DegreesCoordinatePicker.LONGITUDE), 
	            new DegreesCoordinatePickerDelegate(DegreesCoordinatePicker.LONGITUDE), 
	            WatchUi.SLIDE_LEFT
	        );
        } else {
            Storage.setValue(ID_LAST_LON_DD, coordinate);
            
            var picker = new WaypointNamePicker();
            WatchUi.pushView(picker, new WaypointNamePickerDelegate(picker), WatchUi.SLIDE_LEFT);
            
        }
        
        System.println("coordinate = " + coordinate);    
    }

}
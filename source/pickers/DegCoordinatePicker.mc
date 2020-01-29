using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

const DEG_FACTORY_COUNT = 10;

class DegCoordinatePicker extends WatchUi.Picker {

    private const LAT_DIRECTIONS = "NS";
    private const LON_DIRECTIONS = "EW";

    private var _type;

    function initialize(type) {

        _type = type;

        var titleStr;

        if (_type == LATITUDE) {
            titleStr = Rez.Strings.picker_title_lat;
        } else {
            titleStr = Rez.Strings.picker_title_lon;
        }

        var title = new WatchUi.Text(
            {
                :text=>titleStr,
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM,
                :color=>Graphics.COLOR_WHITE
            }
        );

        var factories = new [DEG_FACTORY_COUNT];

        if (_type == LATITUDE) {
            factories[0] = new CharPickerFactory(LAT_DIRECTIONS, {});
        } else {
            factories[0] = new CharPickerFactory(LON_DIRECTIONS, {});
        }

        factories[1] = new NumberPickerFactory(0, 9, 1, {});
        factories[2] = new NumberPickerFactory(0, 9, 1, {});
        factories[3] = new NumberPickerFactory(0, 9, 1, {});

        factories[4] = new WatchUi.Text(
            {
                :text=>".",
                :font=>Graphics.FONT_MEDIUM,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
                :color=>Graphics.COLOR_WHITE
            }
        );

        factories[5] = new NumberPickerFactory(0, 9, 1, {});
        factories[6] = new NumberPickerFactory(0, 9, 1, {});
        factories[7] = new NumberPickerFactory(0, 9, 1, {});
        factories[8] = new NumberPickerFactory(0, 9, 1, {});
        factories[9] = new NumberPickerFactory(0, 9, 1, {});

        var defaults = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        var coordinate = _type == LATITUDE ? Storage.getValue(ID_LAST_LAT_DD) : Storage.getValue(ID_LAST_LON_DD);

        if (coordinate != null) {
            var charArray = coordinate.toCharArray();

            for (var i = 0; i < charArray.size(); i++) {
               if (charArray[i] == '-') {
                   defaults[i] = 1;
               } else if (charArray[i] == '+') {
                   defaults[i] = 0;
               } else if (charArray[i] == '.') {
                   continue;
               } else {
                   var digit = charArray[i].toString();
                   defaults[i] = factories[i].getIndex(digit.toNumber());
               }
            }
        }

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
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

}

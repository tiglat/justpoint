using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class WaypointNamePicker extends WatchUi.Picker {

    const CHAR_SET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345678790._-+*@#&<>";
    const MAX_TEXT_LEN = 15;

    private var _TypedText;
    private var _Factory;

    function initialize() {
        _Factory = new CharPickerFactory(CHAR_SET, {:addOk=>true});
        _TypedText = "";

        var lastName = Storage.getValue(ID_LAST_WP_NAME);
        var titleText = Rez.Strings.picker_title_name;
        var defaults = null;

        if (lastName != null) {
            _TypedText = lastName;
            titleText = lastName;
            //defaults = [_Factory.getIndex(lastName.substring(lastName.length()-1, lastName.length()))];
        }

        mTitle = new WatchUi.Text(
            {
                :text=>titleText,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM,
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_TINY
            }
        );

        Picker.initialize({:title=>mTitle, :pattern=>[_Factory], :defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

    function addCharacter(character) {
        if (_TypedText.length() < MAX_TEXT_LEN) {
            _TypedText += character;
            mTitle.setText(_TypedText);
        }
    }

    function removeCharacter() {
        _TypedText = _TypedText.substring(0, _TypedText.length() - 1);

        if (_TypedText.length() == 0) {
            mTitle.setText(WatchUi.loadResource(Rez.Strings.picker_title_name));
        }
        else {
            mTitle.setText(_TypedText);
        }
    }

    function getTitle() {
        return _TypedText.toString();
    }

    function getTitleLength() {
        return _TypedText.length();
    }

    function isDone(value) {
        return _Factory.isDone(value);
    }
}

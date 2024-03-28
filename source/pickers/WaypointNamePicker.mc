using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

class WaypointNamePicker extends WatchUi.Picker {

    const CHAR_SET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345678790._-+*@#&<>";
    const MAX_TEXT_LEN = 15;

    private var mTypedText;
    private var mFactory;

    function initialize() {
        mFactory = new CharPickerFactory(CHAR_SET, {:addOk=>true});
        mTypedText = "";

        var lastName = Storage.getValue(ID_LAST_WP_NAME);
        var titleText = Rez.Strings.picker_title_name;
        var defaults = null;

        if (lastName != null) {
            mTypedText = lastName;
            titleText = lastName;
            //defaults = [mFactory.getIndex(lastName.substring(lastName.length()-1, lastName.length()))];
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

        Picker.initialize({:title=>mTitle, :pattern=>[mFactory], :defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

    function addCharacter(character) {
        if (mTypedText.length() < MAX_TEXT_LEN) {
            mTypedText += character;
            (mTitle as WatchUi.Text).setText(mTypedText);
        }
    }

    function removeCharacter() {
        mTypedText = mTypedText.substring(0, mTypedText.length() - 1);

        if (mTypedText.length() == 0) {
            (mTitle as WatchUi.Text).setText(WatchUi.loadResource(Rez.Strings.picker_title_name));
        }
        else {
            (mTitle as WatchUi.Text).setText(mTypedText);
        }
    }

    function getTitle() {
        return mTypedText.toString();
    }

    function getTitleLength() {
        return mTypedText.length();
    }

    function isDone(value) {
        return mFactory.isDone(value);
    }
}

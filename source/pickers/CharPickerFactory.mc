using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Lang;

class CharPickerFactory extends WatchUi.PickerFactory {
    hidden var mCharacterSet;
    hidden var mAddOk;
    const DONE = -1;

    function initialize(characterSet, options) {
        PickerFactory.initialize();
        mCharacterSet = characterSet;
        mAddOk = (null != options) and (options.get(:addOk) == true);
    }

    function getIndex(value) {
        var index = mCharacterSet.find(value);
        return index;
    }

    function getSize() {
        return mCharacterSet.length() + ( mAddOk ? 1 : 0 );
    }

    function getValue(index) {
        if(index == mCharacterSet.length()) {
            return DONE;
        }

        return mCharacterSet.substring(index, index+1);
    }

    function getDrawable(index, selected) {
        if(index == mCharacterSet.length()) {
            return new WatchUi.Text(
                {
                    :text=>Rez.Strings.picker_char_ok,
                    :color=>Graphics.COLOR_WHITE,
                    :font=>Graphics.FONT_LARGE,
                    :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                    :locY=>WatchUi.LAYOUT_VALIGN_CENTER
                });
        }

        return new WatchUi.Text(
            {
                :text=>getValue(index) as Lang.String,
                :color=>Graphics.COLOR_WHITE,
                :font=> Graphics.FONT_LARGE,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            });
    }

    function isDone(value) {
        return mAddOk and (value == DONE);
    }
}

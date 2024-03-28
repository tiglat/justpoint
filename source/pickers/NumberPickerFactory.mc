using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Lang;

class NumberPickerFactory extends WatchUi.PickerFactory {
    hidden var mStart as Lang.Number;
    hidden var mStop as Lang.Number;
    hidden var mIncrement as Lang.Number;
    hidden var mFormatString;
    hidden var mFont;

    function initialize(start, stop, increment, options) {
        PickerFactory.initialize();

        mStart = start;
        mStop = stop;
        mIncrement = increment;

        if(options != null) {
            mFormatString = options.get(:format);
            mFont = options.get(:font);
        }

        if(mFont == null) {
            mFont = Graphics.FONT_NUMBER_HOT;
        }

        if(mFormatString == null) {
            mFormatString = "%d";
        }
    }

    function getDrawable(index, selected) {
        var value = getValue(index) as Lang.Number;
        return new WatchUi.Text(
            {
                :text=>value.format(mFormatString),
                :color=>Graphics.COLOR_WHITE,
                :font=> mFont,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_CENTER
            }
        );
    }

    function getIndex(value) {
        var index = (value / mIncrement) - mStart;
        return index;
    }

    function getValue(index) {
        return mStart + (index * mIncrement);
    }

    function getSize() {
        return ( mStop - mStart ) / mIncrement + 1;
    }

}

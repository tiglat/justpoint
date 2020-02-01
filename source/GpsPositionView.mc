using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Position;
using Toybox.System;
using Toybox.Application.Storage as Storage;

class GpsPositionView extends WatchUi.View {

    private var mProgressBar;
    private var mTimer;
    private var mProgressCounter;
    private var mPositionInfo;
    private var mPromptLat;
    private var mPromptLon;
    private var mPromptNoInfo;
    private var mPromptAccuracy;

    function initialize(progressBar) {
        View.initialize();
        mProgressCounter = 0;
        mTimer = new Timer.Timer();
        mPromptLat = WatchUi.loadResource(Rez.Strings.picker_title_lat);
        mPromptLon = WatchUi.loadResource(Rez.Strings.picker_title_lon);
        mPromptNoInfo = WatchUi.loadResource(Rez.Strings.txt_no_gps_signal);
        mPromptAccuracy = WatchUi.loadResource(Rez.Strings.txt_gps_accuracy);
        mPositionInfo = null;
        mProgressBar = progressBar;

        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, self.method(:onPosition));
        mTimer.start( self.method(:onTimer), 1000, true );
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        System.println("GpsPositionView: onShow");
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        System.println("GpsPositionView: onUpdate");

        // Set background color
        dc.setColor( Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK );
        dc.clear();
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
        var string;
        if( mPositionInfo != null ) {
            string = mPromptLat + " = " + mPositionInfo.position.toDegrees()[0].toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 40), Graphics.FONT_SMALL, string, Graphics.TEXT_JUSTIFY_CENTER );
            string = mPromptLon + " = " + mPositionInfo.position.toDegrees()[1].toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 20), Graphics.FONT_SMALL, string, Graphics.TEXT_JUSTIFY_CENTER );
            string = mPromptAccuracy + " - " + getAccuracyDesc(mPositionInfo.accuracy);
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2)), Graphics.FONT_SMALL, string, Graphics.TEXT_JUSTIFY_CENTER );
        } else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Graphics.FONT_SMALL, mPromptNoInfo, Graphics.TEXT_JUSTIFY_CENTER );
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }


    function onPosition(info) {
        var myLocation = info.position.toDegrees();
        System.println("GpsPositionView.onPosition: " + myLocation[0] + "," + myLocation[1]);

        if (info.accuracy >= Position.QUALITY_USABLE) {
            Position.enableLocationEvents(Position.LOCATION_DISABLE, self.method(:onPosition));
            System.println("GpsPositionView.onPosition: got good accuracy");
            Storage.setValue($.ID_LAST_LAT_DD, myLocation[0]);
            Storage.setValue($.ID_LAST_LON_DD, myLocation[1]);
            mPositionInfo = info;
            mTimer.stop();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE); // slide out ProgressBar view
            WatchUi.requestUpdate();
        }
    }

    function onTimer() {

        mProgressCounter++;
        System.println("GpsPositionView.onTimer: " + mProgressCounter.toString());

        if (mProgressCounter > 100) {
            mProgressCounter = 0;
        }

        mProgressBar.setProgress(mProgressCounter);

    }

    private function getAccuracyDesc(accuracy) {

        switch(accuracy) {
            case Position.QUALITY_NOT_AVAILABLE: return "Not available";
            case Position.QUALITY_LAST_KNOWN: return "Last known";
            case Position.QUALITY_POOR: return "Poor";
            case Position.QUALITY_USABLE: return "Usable";
            case Position.QUALITY_GOOD: return "Good";
            default: return "Unknown";
        }

    }
}




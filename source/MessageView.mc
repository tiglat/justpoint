using Toybox.WatchUi;

class MessageView extends WatchUi.View {

    var mText;

    function initialize(msg) {
        View.initialize();

        mText = new WatchUi.Text(
            {
                :text=>msg,
                :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM,
                :color=>Graphics.COLOR_WHITE,
                :font=>Graphics.FONT_SYSTEM_TINY
            }
        );
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
        dc.clear();
        mText.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}

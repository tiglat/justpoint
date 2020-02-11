using Toybox.Lang;


class NoWaypointException extends Lang.Exception {
    var mErrorMessage;
    function initialize(msg) {
        Exception.initialize();
        mErrorMessage = msg;
    }

    function getErrorMessage() {
        return mErrorMessage;
    }
}


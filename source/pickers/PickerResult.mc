using Toybox.Position;

class PickerResult {

    enum {
        OK,
        CANCEL,
        REWRITE,
        NO_STATUS
    }

    var name;
    var position;
    var result;

    function initialize() {
        name = "";
        position = null;
        result = NO_STATUS;
    }
}
using Toybox.Position;
using Toybox.Lang;

class Waypoint {
    var mLatitude;
    var mLongitude;
    var mFormat;

    function initialize(lat, lon, format) {

        if (lat == null || lon == null) {
            throw new Lang.InvalidValueException("Coordinates are empty");
        }

        if (format != Position.GEO_DEG && format != Position.GEO_DM && format != Position.GEO_DMS) {
            throw new Lang.InvalidValueException("Coordinates format is wrong");
        }

        mLatitude = lat;
        mLongitude = lon;
        mFormat = format;
    }

    function getPosition() {
        return mLatitude + "," + mLongitude;
    }

    function getFormat() {
        return mFormat;
    }

    function getFormatChar() {
        if (mFormat == Position.GEO_DEG) {
            return "D";
        } else if (mFormat == Position.GEO_DM) {
            return "M";
        } else {
            return "S";
        }
    }

    function getLatitude() {
        return mLatitude;
    }

    function getLongitude() {
        return mLongitude;
    }

    function getLocation() {

        var latFloat = 0.0;
        var lonFloat = 0.0;

        switch (mFormat) {
            case Position.GEO_DEG:
            {
                latFloat = mLatitude.toFloat();
                lonFloat = mLongitude.toFloat();
                break;
            }
            case Position.GEO_DM:
            {
                latFloat = convertDm(mLatitude);
                lonFloat = convertDm(mLongitude);
                break;
            }
            case Position.GEO_DMS:
            {
                latFloat = convertDms(mLatitude);
                lonFloat = convertDms(mLongitude);
                break;
            }
        }

        if (latFloat == null || lonFloat == null) {
            System.println("Could not convert latitude or longitude to float.");
            return null;
        }

        var location = new Position.Location(
            {
                :latitude => latFloat,
                :longitude => lonFloat,
                :format => :degrees
            }
        );

        if (location == null) {
            System.println("Could not build location");
            return null;
        }

        return location;
    }

    function serialize() {
        return getFormatChar() + "," + mLatitude + "," + mLongitude;
    }

    // convert coordinate from GEO_DM format to GEO_DEG
    private function convertDm(pos) {

        var index = pos.find(":");

        if (index == null) {
            return 0;
        }

        var signChar = pos.substring(0, 1);
        var sign = signChar.equals("-") ? -1 : 1;

        var deg = pos.substring(0, index);
        var degFloat = deg.toFloat();

        var min = pos.substring(index + 1, pos.length());
        var minFloat = min.toFloat();
        var minInDeg = minFloat / 60.0;

        return degFloat + sign * minInDeg;
    }

    // convert coordinate from GEO_DMS format to GEO_DEG
    private function convertDms(pos) {

        var index = pos.find(":");
        if (index == null) {
            return 0;
        }

        var signChar = pos.substring(0, 1);
        var sign = signChar.equals("-") ? -1 : 1;

        var deg = pos.substring(0, index);
        var degFloat = deg.toFloat();

        var remain = pos.substring(index + 1, pos.length());

        index = remain.find(":");
        if (index == null) {
            return 0;
        }

        var min = remain.substring(0, index);
        var minFloat = min.toFloat();
        var minInDeg = minFloat / 60.0;

        var sec = remain.substring(index + 1, remain.length());
        var secFloat = sec.toFloat();
        var secInDeg = secFloat / 3600.0;

        return degFloat + sign * minInDeg + sign * secInDeg;

    }
}
using Toybox.System;
using Toybox.Position;

function parsePosition(position, format) {

    if (position == null) {
        System.println("Position is null");
        return null;
    }

    if (format != Position.GEO_DEG && format != Position.GEO_DM && format != Position.GEO_DMS) {
        System.println("Wrong format");
        return null;
    }

    var index = position.find(",");
    if (index == null) {
        System.println("Wrong format");
        return null;
    }

    var latStr = position.substring(0, index);
    var lonStr = position.substring(index + 1, position.length());

    var latFloat = 0.0;
    var lonFloat = 0.0;

    switch (format) {
        case Position.GEO_DEG:
        {
            latFloat = lat.toFloat();
            lonFloat = lon.toFloat();

            if (latFloat == null || lonFloat == null) {
                System.println("Could not convert latitude or longitude to float.");
                return null;
            }

            break;
        }
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
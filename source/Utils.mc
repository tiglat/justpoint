using Toybox.System;
using Toybox.Position;
using Toybox.PersistedContent;

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
            latFloat = latStr.toFloat();
            lonFloat = lonStr.toFloat();

            if (latFloat == null || lonFloat == null) {
                System.println("Could not convert latitude or longitude to float.");
                return null;
            }

            break;
        }
        case Position.GEO_DM:
        {
            latFloat = convertDm(latStr);
            lonFloat = convertDm(lonStr);

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

// convert coordinate from GEO_DM format to GEO_DEG
function convertDm(pos) {

    var index = pos.find(":");

    if (index == null) {
        return 0;
    }

    var deg = pos.substring(0, index);
    var degFloat = deg.toFloat();
    var min = pos.substring(index + 1, pos.length());

    var minFloat = min.toFloat();
    var minInDeg = minFloat / 60.0;

    var posFloat = degFloat + minInDeg;

    return posFloat;
}

function getPersistedContentItem(name) {

    var iter = PersistedContent.getAppWaypoints();

    var item = iter.next();

    while (item != null) {
        if (item.getName().equals(name)) {
            return item;
        }
        item = iter.next();
    }

    return null;
}

function removeWaypointFromPersistedContent(name) {
    var point = $.getPersistedContentItem(name);

    if (point != null) {
        System.println("removeWaypointFromPersistedContent: point is removed");
        point.remove();
    } else {
        System.println("removeWaypointFromPersistedContent: Could not delete because the point is absent.");
    }
}
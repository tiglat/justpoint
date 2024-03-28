using Toybox.System;
using Toybox.Position;
using Toybox.PersistedContent;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Storage as Storage;

module Utils {

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
        var point = getPersistedContentItem(name);

        if (point != null) {
            System.println("removeWaypointFromPersistedContent: point is removed");
            point.remove();
        } else {
            System.println("removeWaypointFromPersistedContent: Could not delete because the point is absent.");
        }
    }

    function removeAllWaypointsFromPersistedContent() {
        var iter = PersistedContent.getAppWaypoints();

        var item = iter.next();

        while (item != null) {
            item.remove();
            item = iter.next();
        }
    }

    function getLastLatitude(format) {
        switch (format) {
            case Position.GEO_DEG: {
                return Storage.getValue(ID_LAST_LAT_DD);
            }
            case Position.GEO_DM: {
                return Storage.getValue(ID_LAST_LAT_DM);
            }
            case Position.GEO_DMS: {
                return Storage.getValue(ID_LAST_LAT_DMS);
            }
        }

        return null;
    }

    function getLastLongitude(format) {
        switch (format) {
            case Position.GEO_DEG: {
                return Storage.getValue(ID_LAST_LON_DD);
            }
            case Position.GEO_DM: {
                return Storage.getValue(ID_LAST_LON_DM);
            }
            case Position.GEO_DMS: {
                return Storage.getValue(ID_LAST_LON_DMS);
            }
        }
        return null;
    }

    function getDateString() {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        return Lang.format(
            "$1$:$2$:$3$ $4$ $5$ $6$ $7$",
            [
                today.hour,
                today.min,
                today.sec,
                today.day_of_week,
                today.day,
                today.month,
                today.year
            ]
        );
    }
}
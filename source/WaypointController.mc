using Toybox.PersistedContent;
using Toybox.Position;
using Toybox.Application.Storage as Storage;

class WaypointController {

    var waypoints;

    function initialize() {
        waypoints = Storage.getValue(ID_WAYPOINTS_LIST);
        
        if (waypoints == null) {
            waypoints = {};
        }
    }    

    function saveDegrees() {
        var name = Storage.getValue(ID_LAST_WP_NAME);
        var lat  = Storage.getValue(ID_LAST_LAT_DD);
        var lon  = Storage.getValue(ID_LAST_LON_DD);
        
        if (name == null || lat == null || lon == null) {
            return;
        }
        
        var coordinates = lat + "," + lon;
        waypoints.put(name, coordinates);
        Storage.setValue(ID_WAYPOINTS_LIST, waypoints);
        
        exportWaypointToSavedLocations(name, coordinates); 
    }
    
//    function update() {
//    }
//
//    function delete() {
//    }
//    
//    function deleteAll() {
//    }
    
    function exportWaypointToSavedLocations(name, coordinates) {
		var location = Position.parse(coordinates, Position.GEO_DEG);  
		
		var coords = location.toDegrees();
		System.println("Converted coordinates: " + coords[0] + ", " + coords[1]);      
        
        PersistedContent.saveWaypoint(location, {:name => name});
    }
    
}
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  
  static Future<String> getCurrentCity() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "GPS Disabled";
    }

    // 2. Check/Request Permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Permission Denied";
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return "Location Blocked";
    }

    // 3. Get Coordinates
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low // Low accuracy saves battery
    );

    // 4. Convert Coordinates to City Name
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, 
        position.longitude
      );
      
      if (placemarks.isNotEmpty) {
        return placemarks[0].locality ?? "Unknown City";
      }
    } catch (e) {
      return "Error fetching city";
    }

    return "Location Not Found";
  }
}
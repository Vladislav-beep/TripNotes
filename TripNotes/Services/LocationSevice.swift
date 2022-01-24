//
//  LocationSevice.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 22.01.2022.
//

import Foundation
import MapKit

class LocationService {
    
    let locationManager = CLLocationManager()
    private var placeCoordinate: CLLocationCoordinate2D?
    private let regionInMeters = 1000.00
    
    
    func showUserLocation() -> MKCoordinateRegion {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        guard let location = locationManager.location?.coordinate else {
            return MKCoordinateRegion() }
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: regionInMeters,
                                            longitudinalMeters: regionInMeters)
            
          //  mapView.setRegion(region, animated: true)
        return region
    }
    
    func showUserLocation2(mapView: MKMapView) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let location = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: regionInMeters,
                                            longitudinalMeters: regionInMeters)
            
            mapView.setRegion(region, animated: true)

    }
    
//    func getDirections(for mapView: MKMapView, previousLocation: (CLLocation) -> ()) {
//        
//        guard let location = locationManager.location?.coordinate else {
//            showAlert(title: "Error", message: "Current location is not found")
//            return
//        }
//        
//        locationManager.startUpdatingLocation()
//        previousLocation(CLLocation(latitude: location.latitude, longitude: location.longitude))
//        
//        guard let request = createDirectionsRequest(from: location) else {
//            showAlert(title: "Error", message: "Destination is not found")
//            return
//        }
//        
//        let directions = MKDirections(request: request)
//        resetMapView(withNew: directions, mapView: mapView)
//        
//        directions.calculate { (response, error) in
//            
//            if let error = error {
//                print(error)
//                return
//            }
//            
//            guard let response = response else {
//                self.showAlert(title: "Error", message: "Directions is not available")
//                return
//            }
//            
//            for route in response.routes {
//                mapView.addOverlay(route.polyline)
//                mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//                
//                let distance = String(format: "%.1f", route.distance / 1000)
//                let timeInterval = route.expectedTravelTime
//                
//                print("\(distance), \(timeInterval)")
//            }
//        }
//    }
    
    func startTrackingUserLocation(for mapView: MKMapView, and location: CLLocation?, closure: (_ currentLocation: CLLocation) -> ()) {
        
        guard let location = location else { return }
        let center = getCenterLocation(for: mapView)
        guard center.distance(from: location) > 50 else { return }
        closure(center)
    }
    
  
     func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
}

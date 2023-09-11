//
//  LocationViewModel.swift
//  RollaDemo
//
//  Created by Omer Rahmanovic on 11. 9. 2023..
//

import Foundation
import Combine
import CoreLocation
import MapKit

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.335748, longitude: 18.068457), latitudinalMeters: 500, longitudinalMeters: 500)
    @Published var journeyStarted = false
    @Published var lastLocation: CLLocation?
    @Published var currentSpeed = 0.0
    
    var locationManager = CLLocationManager()
    
    // Calculate speed
    func speedometer(currentLocation: CLLocation) {
        guard lastLocation != nil else {
            lastLocation = currentLocation
            return
        }
        
        var speed = currentLocation.speed
        if (speed > 0) {
            currentSpeed = speed * 3.6
            debugPrint("Speed (km/h): \(currentSpeed)")
            debugPrint("Current speed: \(speed)")
        } else {
            speed = lastLocation!.distance(from: currentLocation) / (currentLocation.timestamp.timeIntervalSince(lastLocation!.timestamp))
            debugPrint("Speed (mps): \(speed)")
        }
        lastLocation = currentLocation
    }
    
    func handleLocationUpdate() {
        if journeyStarted {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    // MARK: - Setup location service
    func setupLocationServices() {
        Task(priority: .background) {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.allowsBackgroundLocationUpdates = true
                self.locationManager.showsBackgroundLocationIndicator = true
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.distanceFilter = 1.0
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            debugPrint("Location restricted")
        case .denied:
            debugPrint("Location denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = MKCoordinateRegion(center: location.coordinate, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
        for location in locations {
            speedometer(currentLocation: location)
        }
        debugPrint("Location: \(location)")
    }
}

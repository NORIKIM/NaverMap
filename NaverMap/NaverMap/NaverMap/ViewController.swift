//
//  ViewController.swift
//  NaverMap
//
//  Created by 김지나 on 2020/02/05.
//  Copyright © 2020 김지나. All rights reserved.
//

import UIKit
import NMapsMap
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var isEnabled = false
    var mapView = NMFMapView()
    var marker = NMFMarker()
    var locationManager = CLLocationManager()
    
    //MARK: override ------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //현재위치 가져오기
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        let coor = locationManager.location?.coordinate
//        print("latitude : " + String(describing: coor!.latitude) + "/ longitude : " + String(describing: coor!.longitude))
        
//        let locationOverlay = mapView.locationOverlay
//        locationOverlay.location = NMGLatLng(lat: coor!.latitude, lng: coor!.longitude)
        view = mapView
        

        move(at: coor)

        
    }

    //MARK: function ------------------------------------------------------------------------

}

extension ViewController {
    func move(at coordinate: CLLocationCoordinate2D?) {
        guard let coordicate = coordinate else { return }
        
        let latitude = coordinate?.latitude
        let longitude = coordinate?.longitude
        
        let camera = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude!, lng: longitude!), zoomTo: 14.0)
        mapView.moveCamera(camera)

        marker.position = NMGLatLng(lat: latitude!, lng: longitude!)
        let locationOverlay = mapView.locationOverlay
        locationOverlay.location = NMGLatLng(lat: latitude!, lng: longitude!)
        marker.mapView = mapView
    }
}

extension ViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else { return }
        move(at: firstLocation.coordinate)
    }
}

//
//  MapView.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 5/30/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import MapKit




class MapView: UIViewController, CLLocationManagerDelegate {
    var selected: Int = 0
    var selectedReligion: String = ""
    var locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }
        let islam = islamLocation().location
        //var religion: [[String]] = []
        //religion.append(islam)
        super.viewDidLoad()
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let UWBCoor = CLLocationCoordinate2D(latitude: 47.7589, longitude: -122.1906)
        let UWBregion = MKCoordinateRegion(center: UWBCoor, span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.35))
        
        mapView.addAnnotations(islam)
        mapView.setRegion(UWBregion, animated: true)
        self.title = selectedReligion
       
    }
    
    
}

extension MapView: MKMapViewDelegate{
    func mapView(_ mapVIew: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let Annonation = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView
        {
            Annonation.animatesWhenAdded = true
            Annonation.titleVisibility = .adaptive
            Annonation.subtitleVisibility = .adaptive
            
            return Annonation
        }
        return nil
    }
    }



    


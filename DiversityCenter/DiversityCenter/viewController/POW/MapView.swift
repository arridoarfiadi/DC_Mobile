//
//  MapView.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 5/30/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import MapKit

class annotation:NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title: String?, subtitle: String?,coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
    var region: MKCoordinateRegion{
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}



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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

class islamLocation: NSObject{
    var location = [annotation]()
    override init(){
        location += [annotation(title: "Islamic Center of Bothell", subtitle: "3300 Monte Villa Pkwy, Bothell, WA 98201. Telp: (512) 222-6996 ", coordinate: CLLocationCoordinate2D(latitude: 47.7589 ,longitude: -122.1906))]
        location += [annotation(title: "Masjid Umar Al-Farooq", subtitle: "5507 238th St SW, Mountlake Terrace, WA 98043. Telp: (425) 776-6162", coordinate: CLLocationCoordinate2D(latitude: 47.7831 ,longitude: -122.3081))]
        location += [annotation(title: "Idris Mosque", subtitle: "1420 NE Northgate Way, Seattle, WA 98125. Telp: (206) 363-3013", coordinate: CLLocationCoordinate2D(latitude: 47.7087 ,longitude: -122.3128))]
        location += [annotation(title: "IMAN Mosque", subtitle: "512 State St S, Kirkland, WA 98033. Telp: (206) 202-4626", coordinate: CLLocationCoordinate2D(latitude: 47.671695 ,longitude: -122.202659))]
        location += [annotation(title: "Muslim Association of Puget Sound", subtitle: "17550 NE 67th Ct, Redmond, WA 98052. Telp: (425) 861-9555", coordinate: CLLocationCoordinate2D(latitude: 47.672136 ,longitude: 122.094514))]
        location += [annotation(title: "Islamic Center of Eastside", subtitle: "14230 NE 21st St, Bellevue, WA 98007. Telp: (425) 746-0398", coordinate: CLLocationCoordinate2D(latitude: 47.629287 ,longitude: -122.150091))]
    }
}

    


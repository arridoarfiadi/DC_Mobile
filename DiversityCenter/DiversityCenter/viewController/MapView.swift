//
//  MapView.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 5/30/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import MapKit

final class annotation:NSObject, MKAnnotation{
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

class MapView: UIViewController {
    var selected: Int = 0
    var selectedReligion: String = ""
    

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        
        var islam: [[String]] = []
        
        islam.append(["Islamic Center of Bothell", "Nothing ", "47.7589" ,"-122.1906"])
        islam.append(["Masjid Umar Al-Farooq", "Nothing ", "47.7831" ,"-122.3081"])
        var religion: [[[String]]] = []
        religion.append(islam)
        super.viewDidLoad()
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let UWBCoor = CLLocationCoordinate2D(latitude: 47.7589, longitude: -122.1906)
        let UWBregion = MKCoordinateRegion(center: UWBCoor, span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.35))
        
       print(selected)
        
        for places in religion[selected]{
            let coordinates = CLLocationCoordinate2D(latitude: Double(places[2])!, longitude: Double(places[3])!)
            mapView.addAnnotation(annotation(title: places[0],subtitle: places[1], coordinate: coordinates))
        }
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
    


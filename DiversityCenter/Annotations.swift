//
//  Annotations.swift
//  DiversityCenter
//
//  Created by Arrido Arfiadi on 9/1/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import Foundation
import MapKit

class Annotations:NSObject, MKAnnotation{
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

class islamLocation: NSObject{
    var location = [Annotations]()
    override init(){
        location += [Annotations(title: "Islamic Center of Bothell", subtitle: "3300 Monte Villa Pkwy, Bothell, WA 98201. Telp: (512) 222-6996 ", coordinate: CLLocationCoordinate2D(latitude: 47.7589 ,longitude: -122.1906))]
        location += [Annotations(title: "Masjid Umar Al-Farooq", subtitle: "5507 238th St SW, Mountlake Terrace, WA 98043. Telp: (425) 776-6162", coordinate: CLLocationCoordinate2D(latitude: 47.7831 ,longitude: -122.3081))]
        location += [Annotations(title: "Idris Mosque", subtitle: "1420 NE Northgate Way, Seattle, WA 98125. Telp: (206) 363-3013", coordinate: CLLocationCoordinate2D(latitude: 47.7087 ,longitude: -122.3128))]
        location += [Annotations(title: "IMAN Mosque", subtitle: "512 State St S, Kirkland, WA 98033. Telp: (206) 202-4626", coordinate: CLLocationCoordinate2D(latitude: 47.671695 ,longitude: -122.202659))]
        location += [Annotations(title: "Muslim Association of Puget Sound", subtitle: "17550 NE 67th Ct, Redmond, WA 98052. Telp: (425) 861-9555", coordinate: CLLocationCoordinate2D(latitude: 47.672136 ,longitude: 122.094514))]
        location += [Annotations(title: "Islamic Center of Eastside", subtitle: "14230 NE 21st St, Bellevue, WA 98007. Telp: (425) 746-0398", coordinate: CLLocationCoordinate2D(latitude: 47.629287 ,longitude: -122.150091))]
    }
}



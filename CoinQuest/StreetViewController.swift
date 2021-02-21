//
//  StreetViewController.swift
//  CoinQuest
//
//  Created by Matias Cevallos on 2/21/21.
//  Copyright © 2021 Matias Cevallos. All rights reserved.
//

import UIKit
import GoogleMaps
import Foundation
import CoreLocation
import MapKit

class StreetViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panoView = GMSPanoramaView(frame: .zero)
        self.view = panoView

        panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312))

        getData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        GMSServices.provideAPIKey("AIzaSyA3MAU6SFUGLzM2qqbHiYv3Uz5gblpVtGw")

        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 5.0)
        let size = view.frame(forAlignmentRect: CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height))
        let mapView = GMSMapView.map(withFrame: size , camera: camera)
        view.addSubview(mapView)
        // Creates a marker in the center of the map.
        let mainMarker = GMSMarker()
        mainMarker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        mainMarker.title = "You"
        mainMarker.map = mapView
        mainMarker.icon = GMSMarker.markerImage(with: .red)
        createMarker(lat: locValue.latitude, lon: locValue.longitude)
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 37.620186, longitude: -122.0897881)
        marker1.title = "ATM"
        marker1.icon = GMSMarker.markerImage(with: .black)
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func getData(){
        
        struct Address: Codable {
            let id: Int?
            let lat: Double?
            let lon: Double?
            let category: String?
            let name: String?
            let created_on: Double?
            let geolocation_degrees: String?
        }
        
        struct User: Codable {
            let address: Address
        }
        

        let url = URL(string: "https://raw.githubusercontent.com/matiascevallos/Projects/master/Venues")!
        URLSession.shared.dataTask(with: url) { (data, _
            , _) in
            if let data = data{
                let users = try? JSONDecoder().decode([User].self, from: data)
                
                print(users)
                print(users?[0].address.id)
            }
        }.resume()
        
    }
    
    func createMarker(lat: Double, lon: Double) {
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: lat+0.2, longitude: lon-0.4)
        marker1.title = "ATM"
        marker1.icon = GMSMarker.markerImage(with: .black)
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: lat+0.4, longitude: lon-0.8)
        marker2.title = "ATM"
        marker2.icon = GMSMarker.markerImage(with: .black)
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: lat+0.7, longitude: lon-0.13)
        marker3.title = "Store"
        marker3.icon = GMSMarker.markerImage(with: .blue)
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2D(latitude: lat+0.1, longitude: lon-1.4)
        marker4.title = "Store"
        marker4.icon = GMSMarker.markerImage(with: .blue)
            
        
        
    }


}

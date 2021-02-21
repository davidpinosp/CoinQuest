//
//  ViewController.swift
//  CoinQuest
//
//  Created by Matias Cevallos on 2/20/21.
//  Copyright © 2021 Matias Cevallos. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyA3MAU6SFUGLzM2qqbHiYv3Uz5gblpVtGw")

        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.0)
        let size = view.frame(forAlignmentRect: CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height))
        let mapView = GMSMapView.map(withFrame: size , camera: camera)
        view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        let position = CLLocationCoordinate2D(latitude: -32.23, longitude: 148.63)
        let markerA = GMSMarker(position: position)
        markerA.title = "Hello World"
        markerA.map = mapView
    }


}

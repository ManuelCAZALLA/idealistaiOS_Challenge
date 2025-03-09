//
//  MapViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 8/3/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var property: DetailsModel?
    var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        if let property = property {
            showPropertyLocation(property)
        }
    }

    func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }

    func showPropertyLocation(_ property: DetailsModel) {
        let location = CLLocationCoordinate2D(latitude: property.ubication.latitude, longitude: property.ubication.longitude)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Inmueble en \(property.moreCharacteristics.flatLocation)"
       
        mapView.addAnnotation(annotation)

        let region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: true)
    }
}

//
//  MapCell.swift
//  tipi
//
//  Created by Jamal on 7/11/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapCell: UICollectionViewCell, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var location = CLLocationCoordinate2D()

    var activity: UserActivity? {
        didSet{
           setup()
        }
    }
    
    func setup(){
        mapView.delegate = self
        setLoaction()
        setRegion()
       // setAnnotation()
        createCricle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//MARK: handling map
extension MapCell{
    
    func setLoaction(){
        let lat = Double(activity?.location?.lat ?? "0") ?? 0
        let lon = Double(activity?.location?.lon ?? "0") ?? 0
        location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    func setRegion(){
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func setAnnotation(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = activity?.title ?? "somePlace"
        annotation.subtitle = activity?.description ?? "someWhere"
        mapView.addAnnotation(annotation)
    }
    
    func createCricle(){
        let circle = MKCircle(center: location, radius: 1100)
        mapView.add(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let render = MKCircleRenderer(overlay: circleOverlay)
            render.fillColor = UIColor(red:0.16, green:0.85, blue:0.80, alpha:0.2)
            return render
        }
        return MKOverlayRenderer()
    }
    
}

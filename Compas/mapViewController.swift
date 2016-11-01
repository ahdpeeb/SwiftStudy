//
//  ViewController.swift
//  Compas
//
//  Created by Nikola Andriiev on 25.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

let SpanDistance: CLLocationDistance = 500;
let TitleForPoint = "My current location"
let imageURL = "https://cdn1.iconfinder.com/data/icons/dinosaur/154/small-dino-dinosaur-dragon-walk-48.png"

extension mapViewController {
    public var rootView: ANSRootView! {
        get {
            if self.isViewLoaded && self.view.isMember(of: ANSRootView.self) {
                return self.view as! ANSRootView
            }
            
            return nil
        }
    }
}

class mapViewController: UIViewController {
    
    // MARK: Properties / accsessors
    private var locationManager: CLLocationManager! {
        didSet {
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 5 //meters
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    private var annotationPoint:MKPointAnnotation! {
        didSet {
            annotationPoint.title = TitleForPoint
            rootView.mapView.addAnnotation(annotationPoint)
        }
    }
    
// MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: Private methods
     func addPin(withLocation location:CLLocation) {
        if (annotationPoint == nil) {
            annotationPoint = MKPointAnnotation()
        }

        annotationPoint.coordinate = location.coordinate
    }
    
     func addresFromPlacemark(placemark: CLPlacemark) -> String {
        let country = placemark.country
        let city = placemark.locality
        let postIndex = placemark.postalCode
        let street = placemark.thoroughfare
        let streetInfo = placemark.subThoroughfare
        let fullAdress = "Country: \(country ?? "not found") \n" +
            "city: \(city ?? "not found") \n" +
            "postIndex: \(postIndex ?? "not found") \n" +
            "street: \(street ?? "not found") \n" +
            "streetInfo: \(streetInfo ?? "none")"
        
        return fullAdress
    }
}

// MARK: CLLocationManagerDelegate
extension mapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if CLLocationManager.locationServicesEnabled() {
            guard let location: CLLocation = locations.last else {
                return
            }
            //first call//if annotationPoint == nil/ or distanсe filter
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, SpanDistance, SpanDistance);
            rootView.mapView.setRegion(region, animated: true)
            
            self.addPin(withLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if CLLocationManager.headingAvailable() {
            // manage heading
        }
    }
}

// MARK: Private MKMapViewDelegate
extension mapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "identifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotationView = annotationView {
            //customize annotation View
            annotationView.canShowCallout = true
            //loading image in foreground!
            let loader = ImageLoader(ulr: imageURL)
            loader.loadImage().subscribe(onNext: { (image:UIImage) in
                annotationView.image = image
            })
            //
            annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
            annotationView.leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return annotationView
        }
        
        return nil
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if view.rightCalloutAccessoryView!.isEqual(control) {
            if let annotation = view.annotation {
                let coordinate = annotation.coordinate
                let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: { ( placemarks : [CLPlacemark]?, error : Error?) in
                        if let placemarks = placemarks {
                            let placemark = placemarks.last
                            if let placemark = placemark {
                                let text = self.addresFromPlacemark(placemark: placemark)
                                self.rootView.fillAddressWithText(text: text, animationDuration: 0)
                            }
                        }})
            }
        }
            
        if let leftButton = view.leftCalloutAccessoryView {
            if leftButton.isEqual(control) {
                print(leftButton)
            }
        }
    }
    
    public func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let rootView = self.rootView {
            rootView.fillAddressWithText(text: "", animationDuration: 1);
        }
    }
    
    // MARK: END
}

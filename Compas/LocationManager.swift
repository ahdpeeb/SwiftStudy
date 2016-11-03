//
//  LocationManager.swift
//  Compas
//
//  Created by Nikola Andriiev on 02.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

typealias CompletionBlock = (_ observable: PublishSubject<CLLocation>) -> Void

class LocationManager: NSObject {
        //Private properties
    private let locationManager        =   CLLocationManager()
    private (set) var   locationUpdate1 : Driver<CLLocation> //driver, control property, control event
    private (set) var   locationUpdate =   PublishSubject<CLLocation>()
    private (set) var   headingUpdate  =   PublishSubject<CLHeading>()
    private (set) var   regionUpdate   =   PublishSubject<CLRegion>()
    
    // MARK:Private methods
    private func standartSettings() {
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter  = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK:Initialization and deallocation
    required override public init () {
        super.init()
        self.standartSettings()
        self.locationManager.rx
    }
    
    deinit {
        self.stopUpdatingLocation()
        self.stopUpdatingHeading()
    }
    
    // MARK: Variables for notification subscribing

    
    // MARK: Public properties
//    public var distanceFilter: CLLocationDistance {
//        let manager = self.locationManager
//        set {
//            manager.distanceFilter = distanceFilter
//        }
//        get {
//            manager.distanceFilter
//        }
//    }
//    
//    public var accuracyFilter: CLLocationAccuracy {
//        let manager = self.locationManager
//        set {
//            manager.desiredAccuracy = accuracyFilter
//        }
//        
//        get  {
//            return manager.desiredAccuracy
//        }
//    }
    
    public var backgroundMode: Bool = false {
        willSet(newValue) {
            if newValue == true {
                self.locationManager.requestAlwaysAuthorization()
            } 
        }
    }
    
    // MARK:Public Methods
    public func updateLocationWithBlock(block: CompletionBlock) {
        self.locationManager.startUpdatingLocation()
        block(locationUpdate)
    }
    
    public func startUpdateHeading() {
        self.locationManager.startUpdatingHeading()
    }
    
    public func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
        self.locationUbdateObservable.onCompleted()
    }
    
    public func stopUpdatingHeading() {
        self.locationManager.stopUpdatingLocation()
        self.headingUbdateObservable.onCompleted()
    }
    
}

// MARK:CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        if let location = location {
            self.locationUbdateObservable.onNext(location)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationUbdateObservable.onError(error)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.headingUbdateObservable.onNext(newHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // bla bla bla region UbdateObservable
    }
}

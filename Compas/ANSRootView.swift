//
//  rootView.swift
//  Compas
//
//  Created by Nikola Andriiev on 26.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class ANSRootView: UIView {
    @IBOutlet internal var mapView: MKMapView!
    @IBOutlet internal var textLaber: UILabel!
    
    private (set) var isAddressVisible: Bool = false
    public func fillAddressWithText(text: String, animationDuration duration: TimeInterval ) {
        self.isAddressVisible = (text != "")
        UIView.animate(withDuration: duration, animations: {
            self.textLaber.alpha = self.isAddressVisible ? 1 : 0
        }) { (value: Bool) in
            if let textLaber = self.textLaber {
                textLaber.text = text
                textLaber.sizeToFit()
            }
        }
    }
    // test commit
    // MARK: END
}

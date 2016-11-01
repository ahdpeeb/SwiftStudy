//
//  UIViewController + Extension.swift
//  Compas
//
//  Created by Nikola Andriiev on 01.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func getView<view>() -> view? {
        if self.isViewLoaded && self.view.isMember(of: view.self as! AnyClass) {
            return self.view as? view
        }
        
        return nil;
    }
}

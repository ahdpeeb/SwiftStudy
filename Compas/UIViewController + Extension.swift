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
    func getView<T>() -> T? {
        if self.isViewLoaded && self.view.isMember(of: T.self) {
            return self.view as? T
        }
    }
}

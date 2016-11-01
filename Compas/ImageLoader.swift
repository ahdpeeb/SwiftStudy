//
//  imageLoader.swift
//  Compas
//
//  Created by Nikola Andriiev on 01.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import Foundation

class ImageLoader: NSObject {
    var url: String
    
    public init(ulr: String) {
        self.url = ulr
    }
    
    func loadImage() -> Observable<UIImage> {
        Observable<UIImage>.create
        
        let session = NSURLSession.sharedSession()
        
    }
}

//
//  imageLoader.swift
//  Compas
//
//  Created by Nikola Andriiev on 01.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import RxSwift
import Foundation

let linkErrorDescription = "Inappropriate image link"

class ImageLoader: NSObject {
    var stringURL: String
    
    public init(stringURL: String) {
        self.stringURL = stringURL
    }

    func loadImage() -> Observable<UIImage> {
        return Observable<UIImage>.create { (observer) -> Disposable in
            let session = URLSession.shared
            guard let imageUrl = URL(string: self.stringURL) else {
                let error = NSError(domain: linkErrorDescription,
                                    code: 0,
                                    userInfo: nil)
                observer.onError(error)
                return Disposables.create()
            }
        
            let task = session.downloadTask(with: imageUrl,
                completionHandler: { (url :URL?, responce :URLResponse?, error :Error?) in
                        if let error = error {
                            observer.onError(error)
                        }
                        
                        if let url = url {
                            let imageData = NSData(contentsOf: url)
                            if let image = UIImage(data: imageData as! Data) {
                                observer.onNext(image)
                            }
                            
                            observer.onCompleted()
                        }
                })
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }.observeOn(MainScheduler.asyncInstance)
    }
    
//ImageLoader END
}

//
//  imageLoader.swift
//  Compas
//
//  Created by Nikola Andriiev on 01.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

class ImageLoader: NSObject {
    var url: String
    
    public init(ulr: String) {
        self.url = ulr
    }

    func loadImage() -> Observable<UIImage> {
        return Observable<UIImage>.create { (observer) -> Disposable in
            let session = URLSession.shared
            guard let imageUrl = URL(string: self.url) else {
                NSException(name: NSExceptionName(rawValue: "imageUrl exeprion"),
                            reason: "inappropriate link",
                            userInfo: nil).raise()
                abort()
            }
        
            let task = session.downloadTask(with: imageUrl,
                completionHandler: { (url :URL?, responce :URLResponse?, error :Error?) in
                    DispatchQueue.main.async {
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
                }})
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
//ImageLoader
}

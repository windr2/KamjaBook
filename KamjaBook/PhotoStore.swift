//
//  PhotoStore.swift
//  KamjaBook
//
//  Created by SEO_MAC on 2017. 3. 6..
//  Copyright © 2017년 SEO_MAC. All rights reserved.
//

import Foundation

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

class PhotoStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processPhotosRequest(data: Data? , error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            //print(error!)
            return .failure(error!)
        }
        //print(jsonData)
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        print("send url : \(url)")
        let task = session.dataTask(with: request , completionHandler: {
            (data , response , error) ->  Void in
            
            let result = self.processPhotosRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        })
        task.resume()
    
    }
}

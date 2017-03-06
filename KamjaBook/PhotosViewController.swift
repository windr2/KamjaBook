//
//  PhotosViewController.swift
//  KamjaBook
//
//  Created by SEO_MAC on 2017. 3. 6..
//  Copyright © 2017년 SEO_MAC. All rights reserved.
//

import Foundation

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store = PhotoStore()
        store.fetchInterestingPhotos { (photosResult) -> Void in
           
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
            case let .failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

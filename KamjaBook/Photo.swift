//
//  Photo.swift
//  KamjaBook
//
//  Created by SEO_MAC on 2017. 3. 6..
//  Copyright © 2017년 SEO_MAC. All rights reserved.
//

import Foundation

class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, photoID: String , remoteURL: URL , dateTaken: Date){
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}

//
//  MashapeHeadersAdapter.swift
//  KamjaBook
//
//  Created by SEO_MAC on 2017. 3. 5..
//  Copyright © 2017년 SEO_MAC. All rights reserved.
//

import Foundation

import Alamofire

class MashapeHeadersAdapter: RequestAdapter {
    
    let mClinetId = "TaISxeXgHRiBicGDXWO4"
    let mClientSecret = "Ez02PbIXHM"

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue( mClinetId,  forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.setValue( mClientSecret,  forHTTPHeaderField: "X-Naver-Client-Secret")
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
    }
}

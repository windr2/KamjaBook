//
//  ViewController.swift
//  KamjaBook
//
//  Created by SEO_MAC on 2017. 3. 5..
//  Copyright © 2017년 SEO_MAC. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class ViewController: UIViewController ,UITableViewDataSource{
    
   // var bookList = []

    @IBOutlet var tableView: UITableView!
    
    let bookList = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellReuseIdentifier = "booklistcell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initRes();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다. 
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! BookListCell

        cell.titleLabel?.text = bookList[indexPath.row]
        
        return cell
    }
  
    
    func initRes(){
        print("init...........")
        
        /*
        let request = Alamofire.request("https://openapi.naver.com/v1/search/book.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1", headers: headers)
            .responseJSON { response in
                debugPrint("<<<res strat====================================================")
                debugPrint(response)
                
                //let str = String(UTF8String: response.cStringUsingEncoding(String.Encoding.utf8))
                
                debugPrint("<<<res end====================================================")

        }
        debugPrint(">>>req start====================================================")
        debugPrint(request)
        debugPrint(">>>req end====================================================")
        */
      /*
        let request = Alamofire.request( "https://openapi.naver.com/v1/search/book.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1", headers: headers)
            .responseString(encoding: String.Encoding.utf8) { ( response) -> Void in
               
            debugPrint("<<<res strat====================================================")
            let statusCode = (response.response?.statusCode)!
            debugPrint("status: \(statusCode)")
            debugPrint(response)
            debugPrint("<<<res end====================================================")
                
        }
        debugPrint(">>>req start====================================================")
        debugPrint(request)
        debugPrint(">>>req end====================================================")
        */
        
  
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = MashapeHeadersAdapter()
        
        // make calls with the session manager
        let request = sessionManager.request("https://openapi.naver.com/v1/search/book.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1")
            //.responseString( encoding: String.Encoding.utf8 ){( response) -> Void in
            .responseJSON { response in
            debugPrint("<<<res strat====================================================")
            let statusCode = (response.response?.statusCode)!
            debugPrint("status: \(statusCode)")
            debugPrint(type(of: response))
                
            //debugPrint(response)
            //self.parseJSONResults( jsonData: String( describing: response) )
            
            guard let object = response.result.value else {
                print("Oh, no!!!")
                return
            }
            
            /*
            guard let object = response.result.value as? [[String: AnyObject]] else {
                print("didn't get todo objects as JSON from API")
                    //completionHandler(.failure(BackendError.objectSerialization(reason: "Did not get JSON array in response")))
                return
            }
            */
            //let json = JSON(object)
               
            let  json  =  JSON ( object )
            let total = json["total"]
                
            debugPrint("total: \(total)")
                
            
            for item in json["items"].arrayValue{
                debugPrint(item["title"])
            }
                
            debugPrint(object)
         
                
            debugPrint("<<<res end====================================================")
            
            //.responseJSON { response in
            //    debugPrint("res================================")
            //    debugPrint(response)
        }
       
        debugPrint(request)
 
    }
    
    
    func parseJSONResults(jsonData value:String ) {
        //var json
        do {
            let data = value.data(using: .utf8)!
            if  value != "" {
              //  let json = try JSONSerialization.jsonObject(with: value, options: []) as! [String: AnyObject]
                let allContacts = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                if let arrJSON = allContacts["items"] {
                    for index in 0...arrJSON.count-1 {
                        let aObject = arrJSON[index] as! [String : AnyObject]
                        //names.append(aObject["title"] as! String)
                        //contacts.append(aObject["author"] as! String)
                        //contacts.append(aObject["publisher"] as! String)
                        var title = aObject["title"] as! String
                        debugPrint(title)

                    }
                }
                //return items
            } else {
                print("No Data :/")
            }
        } catch {
            // 실패한 경우, 오류 메시지를 출력합니다.
            print("Error, Could not parse the JSON request")
        }
        
       // return nil
    }
    
    
    func reqBookSearc(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


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
    
    var bookData = [BookData]()
    
    //let bookList = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellReuseIdentifier = "booklistcell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initRes();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다. 
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! BookListCell

        cell.titleLabel?.text = bookData[indexPath.row].title
        cell.subTitleLabel?.text = bookData[indexPath.row].author
        cell.authorLabel?.text = bookData[indexPath.row].pubdate
        return cell
    }
  
    
    func initRes(){
        print("init...........")
  
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
                
            guard let object = response.result.value else {
                print("Oh, no!!!")
                return
            }
            //debugPrint(type(of: object))
            //debugPrint(object)
         
            let  json  =  JSON ( object )

            let total = json["total"]
                
            //debugPrint(json)
            debugPrint("total: \(total)")
                
            for item in json["items"].arrayValue{
                //debugPrint(item["title"])
                
                let book = BookData()
                book.title = item["title"].string!
                book.author =  item["author"].string!
                book.link =  item["link"].string!
                book.image =  item["image"].string!
                book.price =  item["price"].string!
                book.discount =  item["discount"].string!
                book.publisher =  item["publisher"].string!
                book.pubdate =  item["pubdate"].string!
                book.isbn =  item["isbn"].string!
                book.description =  item["description"].string!
                
                self.bookData.append(book)
            }
                
            debugPrint(self.bookData.count)
                
            //let book = BookData()
            //book.insert(obj: object as AnyObject)
                
            debugPrint("<<<res end====================================================")
                
            self.tableView.reloadData()
        }
       
        debugPrint(request)
 
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  Network.swift
//  EODAssignment
//
//  Created by Harish Pathak on 16/08/18.
//  Copyright © 2018 CRMNEXT. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    
    class func callAPI(url: String, completion: @escaping (_ data: Data)->Void){
        
        
        Alamofire.request(url).responseJSON { response in

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                completion(data)
            }else{
                print("Something went wrong !!!")
            }
        }
        
    }
    
    
}

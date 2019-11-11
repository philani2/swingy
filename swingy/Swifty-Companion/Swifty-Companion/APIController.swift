//
//  APIController.swift
//  Swifty-Companion
//
//  Created by Bazil Philani GUMEDE on 2019/10/17.
//  Copyright © 2019 Bazil Philani GUMEDE. All rights reserved.
//

import Foundation
import JSONParserSwift
import SwiftyJSON


struct globals {
    static var token: String!
    static var jsonResponse: JSON!
}

var token_ = "?"

class APIController: NSObject {
    
 
    func requestToken() {
        
        let UID = "315dfd8ea5c52e894fe045f1aa81c269c8e9a9c4d16240501b203a437635a776"
        let SECRET = "43953a0c774deb1ae186bbae9ac69d181148d81e95b8d62e1ae95ca8ffda367f"
        let BEARER = ((UID + ":" + SECRET).data(using: String.Encoding.utf8, allowLossyConversion: true))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {return}
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    if let token = json["access_token"]
                    {
                        print("1st token = \(token)")
                        globals.token = token as? String
                        print(globals.token)
                        token_ = token as! String
                    }
                } catch {
                    print(error)
                }
            }
        })
        
        task.resume()
    }
    
    /*  Getting the user info */
    func getUserInfo(userlogin: String, token: String?, completionBlock: @escaping (JSON?, Error?) -> Void) -> (result: Bool, message: String?){
        print("Started connection")
        
        /* check for token valididty */
        guard let token_check = token else {
            print("Token problem!")
            return (false, "Token Problem!")
        }
        
        let authEndPoint: String = "https://api.intra.42.fr/v2/users/\(userlogin)"
        
        guard let url = URL(string: authEndPoint) else {return (false, "Login not found!")}
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token_check)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let requestGET = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    
                    let json = try JSON(data: data)
                    globals.jsonResponse = json /* save */
                    
                    /* check if user is available */
                    if userlogin == json["login"].stringValue {
                        
                        print(userlogin)
                        print(token_check)
                        
                        completionBlock(json, nil); /* return true if successful */
                    }
                    else {
                        completionBlock(nil, error)  /* return false if fail */
                    }
                    
                } catch {
                    print(error)
                }
            }
            else {
                print("Data is null")
            }
        }
        requestGET.resume()
        
        print("End token")
        return (true, "Success!")
    }
    
}

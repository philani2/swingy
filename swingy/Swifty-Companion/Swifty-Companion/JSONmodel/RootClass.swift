////
////  RootClass.swift
////  Swifty-Companion
////
////  Created by Khomotjo MODIPA on 2018/10/18.
////  Copyright © 2018 Khomotjo. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//
//struct RootClass {
//    
//    let email: String?
//    let login: String?
//    let firstName: String?
//    let lastName: String?
//    let url: String?
//    let phone: Any?
//    let displayname: String?
//    let imageUrl: String?
//    let correctionPoint: Int?
//    let poolMonth: String?
//    let poolYear: String?
//    let location: Any?
//    let wallet: Int?
//    let cursusUsers: [CursusUsers]?
//    let projectsUsers: [ProjectsUsers]?
//
//    
//    init(_ json: JSON) {
//
//        email = json["email"].stringValue
//        login = json["login"].stringValue
//        firstName = json["first_name"].stringValue
//        lastName = json["last_name"].stringValue
//        url = json["url"].stringValue
//        phone = json["phone"]
//        displayname = json["displayname"].stringValue
//        imageUrl = json["image_url"].stringValue
//        correctionPoint = json["correction_point"].intValue
//        poolMonth = json["pool_month"].stringValue
//        poolYear = json["pool_year"].stringValue
//        location = json["location"]
//        wallet = json["wallet"].intValue
//        cursusUsers = json["cursus_users"].arrayValue.map { CursusUsers($0) }
//        projectsUsers = json["projects_users"].arrayValue.map { ProjectsUsers($0) }
//    }
//    
//}

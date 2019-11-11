//
//  ViewController.swift
//  swift_companion
//
//  Created by Bazil Philani GUMEDE on 2019/10/24.
//  Copyright © 2019 Bazil Philani GUMEDE. All rights reserved.
//

import UIKit
import JSONParserSwift
import SwiftyJSON

class ViewController: UIViewController {

    
    /*  Stuct Properties */
    var baseResbonse = [BaseResponse]()
    var cursusUsers = [Cursus_users]()
    var skills = [Skills]()
    var projectUsers = [Projects_users]()
    var project = [Project]()
    
    /* API Controller instance */
    var apiController: APIController = APIController()
    
    /* UI Properties */
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!	
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var campusLabel: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var user: String? /* Info comes from the textField specified in the EntrViewController */
    
    var deToken = ""
    var topicsBackup: [Dictionary<String,Any>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storeUserInfo()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//    }
    
    /*  Getting the user info */
    func storeUserInfo() {
        print("Started saving user data")
        
        let json = globals.jsonResponse!
        
        let skills = json["cursus_users"][0]["skills"]
        let projectUsers = json["projects_users"]
        let cursusUsers = json["cursus_users"]
        
        /* Getting Cursus_users */
        for element in cursusUsers.arrayValue {
            self.cursusUsers.append(Cursus_users(element))
        }
        
        /* Getting Project_users */
        for element in projectUsers.arrayValue {
            self.projectUsers.append(Projects_users(element))
        }
        
        /* Getting the BaseResponds */
        self.baseResbonse.append(BaseResponse(json))
        
        /* Getting Skills */
        for element in skills.arrayValue {
            self.skills.append(Skills(element))
        }
        
        DispatchQueue.main.async {
            _ = self.displayUserInfo(baseResbonse: self.baseResbonse, cursusUsers: self.cursusUsers, skills: self.skills, projectUsers: self.projectUsers, project: self.project)
        }
        
    }
    
    /* Display user info */
    func displayUserInfo(baseResbonse: [BaseResponse], cursusUsers: [Cursus_users], skills: [Skills], projectUsers: [Projects_users], project: [Project]) {
        
      
        let str = String(Float((self.cursusUsers[0].level)) - Float(Int(self.cursusUsers[0].level)))
        let index = str.index(str.startIndex, offsetBy: 1) /* Start at index 1 '.XX' */
        let suffix = str[index...]
        
        DispatchQueue.main.async {
            self.userNameLabel.text = self.baseResbonse[0].login
            self.phoneLabel.text = "0\(String(self.baseResbonse[0].phone))"
            self.walletLabel.text = "Wallet: " + String(self.baseResbonse[0].wallet)
            self.correctionLabel.text = "CPoints: " + String(self.baseResbonse[0].correction_point)
            self.levelLabel.text = "Level: \(String(Int(self.cursusUsers[0].level)))\(suffix)%"
            self.progressBar.progress = Float((self.cursusUsers[0].level)) - Float(Int(self.cursusUsers[0].level))
            self.campusLabel.text = self.baseResbonse[0].campus
            
            if let url = URL(string: self.baseResbonse[0].image_url)
            {
                self.imageView.layer.borderWidth = 2
                self.imageView.layer.borderColor = UIColor.white.cgColor
                self.imageView.layer.cornerRadius = self.imageView.layer.bounds.height / 2
                self.imageView.clipsToBounds = true
                self.downloadImage(from: url)
                
            }
        }
    }
    

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL)
    {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "s&p" {
            let destination = segue.destination as? secondViewController
            destination?.baseResbonse = self.baseResbonse
            destination?.cursusUsers = self.cursusUsers
            destination?.skills = self.skills
            destination?.projectUsers = self.projectUsers
            destination?.project = self.project
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


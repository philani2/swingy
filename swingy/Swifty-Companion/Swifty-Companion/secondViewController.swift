//
//  secondViewController.swift
//  Swifty-Companion
//
//   Created by Bazil Philani GUMEDE on 2019/10/18.
//  Copyright © 2019 Bazil Philani GUMEDE. All rights reserved.
//

import UIKit
import JSONParserSwift
import SwiftyJSON

class secondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    /*  Stuct Properties */
    var baseResbonse = [BaseResponse]()
    var cursusUsers = [Cursus_users]()
    var skills = [Skills]()
    var projectUsers = [Projects_users]()
    var project = [Project]()
    
    /* skills table properties*/
    
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var projectTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == skillsTableView)
        {
            return (self.skills.count)
        }
        else
        {
            return (self.projectUsers.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == skillsTableView)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skills") as! SkillsTableViewCell
        cell.skill = self.skills[indexPath.row]
        print(self.skills.count)
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "projects") as! ProjectsTableViewCell
            cell.project = self.projectUsers[indexPath.row]
//            print(self.skills.count)
            return cell
        }
    }
}

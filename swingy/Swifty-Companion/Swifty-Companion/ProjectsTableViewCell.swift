//
//  ProjectsTableViewCell.swift
//  Swifty-Companion
//
//  Created by Bazil Philani GUMEDE on 2019/10/23.
//  Copyright © 2019 Bazil Philani GUMEDE. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var projectLabel: UILabel!
    
    @IBOutlet weak var projectPercentageLabel: UILabel!
    
    var project : (Projects_users)?
    {
        didSet{
            if let s = project {
                projectLabel.text = s.project?.name
                projectPercentageLabel.text = String(s.final_mark)
            }
        }
    }
}

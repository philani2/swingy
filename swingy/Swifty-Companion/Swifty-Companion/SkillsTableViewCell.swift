//
//  SkillsTableViewCell.swift
//  Swifty-Companion
//
//  Created by Bazil Philani GUMEDE on 2019/10/19.
//  Copyright © 2019 Bazil Philani GUMEDE. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var skillsPercentageLabel: UILabel!
    @IBOutlet weak var skillsProgressBar: UIProgressView!
    
    
    var skill : (Skills)? {
        didSet {
            if let s = skill {
                skillsLabel?.text = s.name
                skillsPercentageLabel?.text = String(s.level)
                skillsProgressBar?.progress = Float(s.level) - Float(Int(s.level))
            }
        }
    }
}


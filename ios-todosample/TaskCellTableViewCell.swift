//
//  TaskCellTableViewCell.swift
//  ios-todosample
//
//  Created by garicchi on 2017/10/18.
//  Copyright © 2017年 ryotatogai. All rights reserved.
//

import Foundation
import UIKit

class TaskCellTableViewCell:UITableViewCell{
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var labelDeadline: UILabel!
    
    func setCell(task:Task){
        self.labelTitle.text = task.title
        self.labelDetail.text = task.detail
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self.labelDeadline.text = formatter.string(from: task.deadline)
    }
    
}

//
//  NewTaskViewController.swift
//  ios-todosample
//
//  Created by garicchi on 2017/10/18.
//  Copyright © 2017年 ryotatogai. All rights reserved.
//

import Foundation
import UIKit

class NewTaskViewController:UIViewController{
    
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textDetail: UITextField!
    @IBOutlet weak var dateDeadline: UIDatePicker!
    
    @IBAction func onSave(_ sender: Any) {
        let id = UUID().uuidString
        let title = textTitle.text!
        let detail = textDetail.text!
        let deadline = dateDeadline.date
        let task = Task(id: id, title: title, detail: detail, deadline: deadline)
        SaveData.load()
        SaveData.add(task: task)
        SaveData.save()
        navigationController?.popViewController(animated: true)
    }
    
}

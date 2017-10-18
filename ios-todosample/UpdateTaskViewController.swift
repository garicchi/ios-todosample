//
//  UpdateTaskViewController.swift
//  ios-todosample
//
//  Created by garicchi on 2017/10/18.
//  Copyright © 2017年 ryotatogai. All rights reserved.
//

import Foundation
import UIKit

class UpdateTaskViewController:UIViewController{
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textDetail: UITextField!
    @IBOutlet weak var dateDeadline: UIDatePicker!
    @IBAction func onSave(_ sender: Any) {
        SaveData.load()
        let newTask = Task(id: self._task!.id, title: textTitle.text!, detail: textDetail.text!, deadline: dateDeadline.date)
        SaveData.update(task: newTask)
        SaveData.save()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        textTitle.text = self._task!.title
        textDetail.text = self._task!.detail
        dateDeadline.date = self._task!.deadline
    }
    
    var _task:Task? = nil
    
    func setTask(task:Task){
        
        self._task = task
    }
}

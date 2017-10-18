//
//  ViewController.swift
//  ios-todosample
//
//  Created by garicchi on 2017/10/18.
//  Copyright © 2017年 ryotatogai. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    // TableViewに表示するデータの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SaveData.size()
    }
    
    // TableViewのindexPath番目に表示する内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCellTableViewCell
        let task = SaveData.at(index: indexPath.item)
        cell.setCell(task: task)
        return cell
    }
    
    var selectedId:String? = nil
    
    // TableViewのindexPath番目が選択されたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = SaveData.at(index: indexPath.item)
        selectedId = task.id
        performSegue(withIdentifier: "segueUpdateTask", sender: self)
    }
    
    // segueで画面遷移する時に呼ばれる。遷移先の画面に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueUpdateTask"){
            let vc = segue.destination as! UpdateTaskViewController
            let task = SaveData.get(id: selectedId!)
            vc.setTask(task:task)
        }
        
    }
    
    // TableViewをスワイプした時に呼ばれる
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = SaveData.at(index: indexPath.item)
            SaveData.remove(task: task)
            tableView.reloadData()
        }
    }
    

    @IBOutlet weak var todoTableView: UITableView!
    
    @IBAction func onAddTask(_ sender: Any) {
        performSegue(withIdentifier: "segueNewTask", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.todoTableView.dataSource = self
        self.todoTableView.delegate = self
        //self.todoTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SaveData.load()
        self.todoTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SaveData.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  SaveData.swift
//  ios-todosample
//
//  Created by garicchi on 2017/10/18.
//  Copyright © 2017年 ryotatogai. All rights reserved.
//

import Foundation

class SaveData{
    static var todo:Todo = Todo()
    static let saveFileName = "data.json"
    
    static func save(){
        let json = try? JSONEncoder().encode(todo)
        let dirUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let saveUrl = URL(string: saveFileName, relativeTo: dirUrl)!
        try? json?.write(to: saveUrl)
    }
    
    static func load(){
        let dirUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let saveUrl = URL(string: saveFileName, relativeTo: dirUrl)!
        do{
            let _todo = try JSONDecoder().decode(Todo.self, from: Data(contentsOf: saveUrl))
            self.todo = _todo
        }catch{
            /*
            self.todo = Todo()
            let task1 = Task(id: UUID().uuidString, title: "テストタスク1", detail: "テスト1", deadline: Date())
            let task2 = Task(id: UUID().uuidString, title: "テストタスク2", detail: "テスト2", deadline: Date())
            self.todo.tasks.append(task1)
            self.todo.tasks.append(task2)
             */
        }
    }
    
    static func add(task:Task){
        todo.tasks.append(task)
    }
    
    static func remove(task:Task){
        var counter:Int = 0
        for e in todo.tasks {
            if task.id == e.id {
                break
            }
            counter += 1
        }
        todo.tasks.remove(at: counter)
    }
    
    static func get(id:String) -> Task{
        var counter:Int = 0
        for e in todo.tasks {
            if id == e.id {
                break
            }
            counter += 1
        }
        return todo.tasks[counter]
    }
    
    static func update(task:Task){
        var counter:Int = 0
        for e in todo.tasks {
            if task.id == e.id {
                break
            }
            counter += 1
        }
        todo.tasks[counter] = task
    }
    
    static func at(index:Int) -> Task{
        return todo.tasks[index]
    }
    
    static func size() -> Int{
        return todo.tasks.count
    }
}

// TODOデータの定義
// Codableを継承することでjsonへとマップできる
struct Todo:Codable{
    var tasks:Array<Task> = []
}

struct Task:Codable{
    var id:String
    var title:String
    var detail:String
    var deadline:Date
}

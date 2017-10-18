# ios TODO SAMPLE

## 環境

|name|varsion|
|:--:|:--:|
|XCode|9.0.1|
|Swift|4|

## プロジェクトを作成する
XCodeで[File]>[New]>[Project]

SinglePageAppのプロジェクトを作成する

## Navigation Controllerを追加する
Main.storyboardを開いてメニューバーから[Editor]>[Embed In]>[Navigation Controller]をクリックしてNavigationControllerを配置。

![1](./img/1.png)


## TODO画面を作る

Main.storyboardを開いて初期からあるViewControllerにの中心にTableViewを配置する。
右側のSizeInspectorで[View]>[Arrange]からFill Container HorizontallyとFill ContainerVerticallyを設定してTableViewを全画面に引き伸ばす。

右下のObject LibraryからNavigation BarをViewControllerに配置する。TitleをTODOにする。

右下のObject LibraryからButtonをNavigation Barの右側に配置する。右側のAttribute InspectorからSystem ItemをAddにする。

右下のObject LibraryからTable View CellをTableViewに配置する。
Table View Cellにlabelを配置してStackViewなどで調整する。

![2](./img/2.png)

配置したTable View Cellを選択して右側のAttribute Inspectorから[Identifier]の項目に[TaskCell]という名前を入力する。この識別子は後でコードから参照するために設定する。

![4](./img/4.png)

右上のAssistan Editor(横2画面分割のやつ)を開いて右側にView Controller.swiftを表示する。
TableViewをCtrlを押しながらView Controllerにドラッグ・アンド・ドロップしてIBOutletとして紐付ける。
右上の[+]ボタンもCtrlを押しながらView Controllerにドラッグ・アンド・ドロップしてIBActionのfunctionを作成する。

![3](./img/3.png)

ViewControllerのsuper classとしてUITableViewDelegate、UITableViewDataSourceを指定する。

tableView関数を3つ追加する。

viewDidLoad関数でtodoTableViewのdataSourceとdelegateにselfを指定する。

```swift
import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    // TableViewに表示するデータの個数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    // TableViewのindexPath番目に表示する内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    // TableViewのindexPath番目が選択されたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

    @IBOutlet weak var todoTableView: UITableView!
    
    @IBAction func onAddTask(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


```

この時点ではtableView関数などからエラーがでてビルドできないが気にしない。

## データを管理するクラスを作る
iosアプリケーションでデータを管理するにはlocal databaseのCore DataやRealmなどがあるがcore dataはxcodeのバージョンによって使い方が変わったりめんどくさいのでjsonで保存することにする。

XCodeで[SaveData.swift]というファイルを作る。

中身はこんな感じ

```swift
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
            self.todo = Todo()
            let task1 = Task(id: UUID().uuidString, title: "テストタスク1", detail: "テスト1", deadline: Date())
            let task2 = Task(id: UUID().uuidString, title: "テストタスク2", detail: "テスト2", deadline: Date())
            self.todo.tasks.append(task1)
            self.todo.tasks.append(task2)
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


```

## TODO画面にデータを表示する


ViewController.swiftを開く。

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


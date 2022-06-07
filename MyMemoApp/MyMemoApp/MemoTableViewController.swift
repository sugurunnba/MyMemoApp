//
//  MemoTableViewController.swift
//  MyMemoApp
//
//  Created by 高木克 on 2022/05/31.
//

import UIKit

class MemoTableViewController: UITableViewController {
    
//    UserDefaults
//    userDefaulesのインスタンス取得
//    「UserDefaults」とは？
//    ユーザーのデフォルトデータベースへのインターフェイスです。
//    アプリの起動時にキーと値のペアを永続的に保存します。
//
//    一言でいうと「簡単に使えるキーバリュー型のDB」です。
    let userDefaults = UserDefaults.standard

//    var memos = ["シャケ", "おかか", "梅"]
    var memos = [String]()
    
//    saveボタンが押された時のメソッド(渡ってきたメモをListに追加する)
//    @IBAction = storyboard上で発生したイベントを関連づけるときに使用する
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue)
        {
        guard let sourceVC = sender.source as? MemoViewController,
              let memo = sourceVC.memo else
            {
            return
        }
//        編集されるセルが選択されている場合の分岐、つまり編集して保存する時にはここが走る
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.memos[selectedIndexPath.row] = memo
        } else {
//          　メモをListに追加
            self.memos.append(memo)
        }
//        userDefaultsに登録
        self.userDefaults.set(self.memos, forKey: "memos")
//        tableVIewを再読み込み
        self.tableView.reloadData()
//        その後、saveボタンをexitに接続する(巻き戻る処理をここで設定)
    }
    
//        Mapの場合(styleでsubtitleの場合)
//        ["title": "t1", "detail": "d1"],
//        ["title": "t2", "detail": "d2"],
//        ["title": "t3", "detail": "d3"]
//        セル設定のTableViewメソッドで下記を設定する
//        cell.textLabel?.text = self.memos[indexPath.row]["title"]
//        cell.detailTextLabel?.text = self.memos[indexPath.row]["detail"]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if self.userDefaults.object(forKey:  "memos") != nil {
//            stringArray ->　キーにある配列を返す
            self.memos = self.userDefaults.stringArray(forKey: "memos")!
        } else {
            self.memos = ["memo1", "memo2", "memo3"]
        }
    }

    // MARK: - Table view data source

//    リストがいくつのセクション(配列)に分かれているか
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

//    セルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.配列[何個目の配列].配列の中の何番目か
        return self.memos.count
    }

//    セルの内容を設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)
//        self.配列[indexPathがもつsection][indexPathがもつrow]
        cell.textLabel?.text = self.memos[indexPath.row]
        cell.detailTextLabel?.text = self.memos[indexPath.row]
        return cell
    }
    
//    セクションのヘッダーを設定
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "section-\(section)"
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

//    スワイプして削除ボタンが表示されるメソッド
    // Override to support editing the table view.
//    indexPathにスワイプされた行のインデックスが入る
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.memos.remove(at: indexPath.row)
//            userDefaultsに登録
            self.userDefaults.set(self.memos, forKey: "memos")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

//    編集するために、セルを押した時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo" {
//            遷移先のビューコントローラーを取得
            let memoVC = segue.destination as! MemoViewController
//            memoVCのmemoプロパティに、選択されている行のセルを指定する
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
//            ここから飛ばされた値は、MemoViewControllerのviewDidLoadで取得できる
        }
    }

}

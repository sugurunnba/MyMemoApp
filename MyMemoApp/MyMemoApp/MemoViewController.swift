//
//  MemoViewController.swift
//  MyMemoApp
//
//  Created by 高木克 on 2022/06/02.
//

import UIKit

class MemoViewController: UIViewController {

    var memo: String?
    
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        画面起動時、セーブボタンを押せないようにする
        self.saveButton.isEnabled = false
        
        if let memo = self.memo {
            self.memoTextField.text = memo
//            タイトル変更
            self.navigationItem.title = "Edit Memo"
        }
        self.updateSaveButtonState()
    }
    
    
    private func updateSaveButtonState() {
//        ??はnilガード。左辺がnilの場合、右辺を代入する
        let memo = self.memoTextField.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
//    textFieldに文字が入ったとき、Saveボタンが押せるようにする
//    右クリック→EditingChangedを引っ張ってくる
    @IBAction func memoTextField(_ sender: Any) {
        self.updateSaveButtonState()
    }
    
//    キャンセルボタンを設定
//    Cancelボタンをcontrol +ドラックでメソッドを設定
    @IBAction func cancel(_ sender: Any) {
//        モーダルで表示した時、presentingViewControllerには今のViewControllerを表示しているViewControllerがセットされる
          if self.presentingViewController is UINavigationController {
//          completion->終わった後の処理
//          dismiss -> モーダルウィンドウを閉じる処理
          self.dismiss(animated: true, completion: nil)
        } else {
//            popViewController -> showしたセグエを逆に戻る
            self.navigationController?.popViewController(animated: true)
        }

    }
//    画面遷移する前に起動するメソッド
//    saveボタンが押された時、senderに情報が入ってくる。
//    segueが巻き戻る前に、memoへtextFieldに入力されたデータをセットする
//    segueを巻き戻すと言うのはモーダルウィンドウのSaveボタンを押してTableViewに戻った時と言う事です。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        === 同じオブジェクトを参照しているかどうか
        guard let button = sender as? UIBarButtonItem, button
                === self.saveButton else {
//            画面へ返して処理を終了する
            return
        }
//        ?? = nil-coalescing(演算子)
//        optionalValueに値がある場合、アンラップする
//        optionalValueがnilの場合、デフォルト値""を返す
        self.memo = self.memoTextField.text ?? ""
    }

}

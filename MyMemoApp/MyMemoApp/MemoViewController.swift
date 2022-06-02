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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        === 同じオブジェクトを参照しているかどうか
        guard let button = sender as? UIBarButtonItem, button
                === self.saveButton else {
            return
        }
        self.memo = self.memoTextField.text ?? ""
    }

}

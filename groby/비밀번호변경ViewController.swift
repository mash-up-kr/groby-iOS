//
//  비밀번호확인ViewController.swift
//  groby
//
//  Created by YunHee Lee on 2018. 8. 18..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class 비밀번호변경ViewController: UIViewController {
    @IBAction func 닫기버튼(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setCustomTitle("비밀번호 변경")
        
    }
    @IBAction func 확인버튼(_ sender: Any) {
        // 코드
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

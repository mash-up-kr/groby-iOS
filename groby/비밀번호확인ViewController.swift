//
//  비밀번호변경ViewController.swift
//  groby
//
//  Created by YunHee Lee on 2018. 8. 18..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class 비밀번호확인ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("비밀번호 확인")
    }

    @IBAction func 닫기버튼(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func 다음버튼(_ sender: Any) {
        // 코드
        guard let storyboard = storyboard else { return }
        let viewController = storyboard.instantiateViewController(withIdentifier: "비밀번호변경ViewController")
        navigationController?.pushViewController(viewController, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

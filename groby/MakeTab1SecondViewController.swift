//
//  MakeTap1SecondViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setCustomTitle("내용 작성")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        guard let makeTab1ThirdTableTableViewController = storyboard?.instantiateViewController(withIdentifier: "MakeTab1ThirdTableTableViewController") as? MakeTab1ThirdTableTableViewController else { return }
        navigationController?.pushViewController(makeTab1ThirdTableTableViewController, animated: true)
    }
}

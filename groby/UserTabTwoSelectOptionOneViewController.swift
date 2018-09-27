//
//  UserTabTwoSelectOptionOneViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 26/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class UserTabTwoSelectOptionOneViewController: UIViewController {

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionAddOption(_ sender: UIButton) {
        // 모달
    }
}

extension UserTabTwoSelectOptionOneViewController: UITableViewDelegate {
    
}

extension UserTabTwoSelectOptionOneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserSelectOptionCell", for: indexPath) as? UserSelectOptionCell else {
            return UITableViewCell()
        }
        return cell
    }
}

class UserSelectOptionCell:
UITableViewCell {
    @IBOutlet weak var deleteOptionButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var countMinusButton: UIButton!
    @IBOutlet weak var countPlusButton: UIButton!
    
    var price: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func actionMinus(_ sender: UIButton) {
        if let countText = countLabel.text, let count = Int(countText) {
            if count <= 1 {
                
                if countMinusButton.isEnabled {
                    countMinusButton.isEnabled = false
                }
                return
            }
            let nextCount = count - 1
            let price = nextCount * self.price
            countLabel.text = "\(nextCount)"
            totalPriceLabel.text = "\(price) 원"
        }
    }
    
    @IBAction func actionPlus(_ sender: UIButton) {
        if let countText = countLabel.text, let count = Int(countText) {
            if !countMinusButton.isEnabled {
                countMinusButton.isEnabled = true
            }
            
            let nextCount = count + 1
            let price = nextCount * self.price
            countLabel.text = "\(nextCount)"
            totalPriceLabel.text = "\(price) 원"
        }
    }
}

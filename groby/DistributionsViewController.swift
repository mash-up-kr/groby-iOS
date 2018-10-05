//
//  DistributionViewController.swift
//  groby
//
//  Created by byungtak on 04/10/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class DistributionsViewController: UIViewController {

    private var distributions: [Distribution] = []
    private let cellIdentifier = "distribution_cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDistributions(itemId: "1")
    }
    
    private func fetchDistributions(itemId: String) {
        let path: String = "\(GrobyURL.base)\(GrobyURL.item.rawValue)\(itemId)/userlist"
        let requestData = RequestData(path: path, method: .get)

        DistributionsApi(requestData).execute(onSuccess: { [weak self] (distribution: DistributionJSON) in
            guard let `self` = self else {
                return
            }
            
            self.distributions = distribution.returnJson
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error: Error) in
            print("errorr \(error.localizedDescription)")
        }
    }
}

extension DistributionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distributions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DistributionsTableViewCell else {
            return UITableViewCell()
        }
        
        let distribution = distributions[indexPath.row]
        
        cell.userId.text = distribution.userName
        cell.itemCount.text = String(distribution.amount)
        cell.itemSum.text = String(distribution.price)
        
        return cell
    }

}


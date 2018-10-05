//
//  DummyTableViewCell.swift
//  groby
//
//  Created by Daeyun Ethan Kim on 11/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class DummyTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }

    var showItemViewClouser: ((Item?) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Collection View Delegate

extension DummyTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let itemId = CommonDataManager.share.mainItems?.popularItemList[indexPath.row].itemId else {
            return
        }

        let path: String = "\(GrobyURL.base)\(GrobyURL.item.rawValue)\(itemId)"
        let requestData: RequestData = RequestData(path: path)
        ItemAPI(requestData).execute(onSuccess: { [weak self] itemJSON in            print("\(itemJSON.returnJson)")
            guard let `self` = self else {
                return
            }

            CommonDataManager.share.item = nil
            self.showItemViewClouser?(itemJSON.returnJson)
        }) { error in
            print("ItemAPI: \(error)")
        }
    }
}

// MARK: - Collection View Data Source

extension DummyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = CommonDataManager.share.mainItems?.recentItemList.count else {
            return 0
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCollectionViewCell", for: indexPath) as? DummyCollectionViewCell, let item = CommonDataManager.share.mainItems?.recentItemList[indexPath.row] else {
            return UICollectionViewCell()
        }

        if let url = URL(string: item.thumnailURL) {
            cell.configure(item.title)
            cell.itemImageView?.kf.setImage(with: url)
        }

        return cell
    }
}

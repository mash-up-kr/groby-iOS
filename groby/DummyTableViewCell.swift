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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Collection View Delegate

extension DummyTableViewCell: UICollectionViewDelegate {

}

// MARK: - Collection View Data Source

extension DummyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCollectionViewCell", for: indexPath) as? DummyCollectionViewCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}

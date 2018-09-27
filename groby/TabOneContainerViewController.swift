//
//  TabOneContainerViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 16/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class TabOneContainerViewController: UIViewController, TabContainerSettable {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var tabOneData: TabOne?
    var tabType: CommonTabViewController.TabType = .tabOne

    override func viewDidLoad() {
        super.viewDidLoad()

        var location: String?
        var content: String?
        if let tabOne = CommonDataManager.share.itemForPost?.tabOne {
            location = tabOne.location
            content = tabOne.contents
        } else {
            location = CommonDataManager.share.item?.tabOne?.location
            content = CommonDataManager.share.item?.tabOne?.contents
        }
        locationLabel.text = location
        contentLabel.text = content
    }
}

extension TabOneContainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension TabOneContainerViewController: UICollectionViewDelegate {

}

class TabOneItemImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func configure(_ image: UIImage) {
        imageView.image = image
    }
}

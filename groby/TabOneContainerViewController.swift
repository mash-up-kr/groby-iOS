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

    var item: Item?
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
            location = tabOneData?.location
            content = tabOneData?.contents
        }
        locationLabel.text = location
        contentLabel.text = content
    }
}

extension TabOneContainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let imageURLs = CommonDataManager.share.imageURLs {
            return imageURLs.count
        } else if let imageURL = item?.imgPathList?.filter({ $0.tab == 1 }) {
            return imageURL.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabOneItemImageCell", for: indexPath) as? TabOneItemImageCell else {
            return UICollectionViewCell()
        }

        if let imageURLs = CommonDataManager.share.imageURLs, !imageURLs.isEmpty {
            let imageURL = imageURLs[indexPath.row]

            if let url = URL(string: imageURL) {
                cell.imageView?.kf.setImage(with: url)
            }
        } else if let imageURL = item?.imgPathList?.filter({ $0.tab == 1 }) {
            if let url = URL(string: imageURL[indexPath.row].img_path) {
                cell.imageView?.kf.setImage(with: url)
            }
        }

        return cell
    }
}

extension TabOneContainerViewController: UICollectionViewDelegate {

}

class TabOneItemImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func configure(_ image: UIImage?) {
        imageView.image = image
    }
}

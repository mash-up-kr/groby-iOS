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
        if let imageURLs = CommonDataManager.share.imageURLs {
            return imageURLs.count
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
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else {
                        return
                    }

                    DispatchQueue.main.async {
                        cell.configure(UIImage(data: data))
                    }
                }
                task.resume()
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

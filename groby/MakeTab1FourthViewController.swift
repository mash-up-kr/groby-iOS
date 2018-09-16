//
//  MakeTab1FourthViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1FourthViewController: UIViewController {

    @IBOutlet weak var tapMenuView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var minimumCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet var tapButtons: [UIButton]!
    @IBOutlet var tapButtonSelectedViews: [UIView]!
    @IBOutlet var headerTapButtons: [UIButton]!
    @IBOutlet var headerTapButtonSelectedViews: [UIView]!

    var tapNumber: Int? = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("글 미리보기")

        //        CommonDataManager.share.item?.tabOne?.contents
        //        CommonDataManager.share.item?.tabOne?.location

        titleLabel.text = CommonDataManager.share.item?.itemTitle
        nicknameLabel.text = CommonDataManager.share.userInfo?.userName
        minimumCountLabel.text = CommonDataManager.share.item?.itemAmountLimit
        endDateLabel.text = CommonDataManager.share.item?.tabOne?.endDate

        if let userId = CommonDataManager.share.userInfo?.userId {
            CommonDataManager.share.item?.userId = "\(userId)"
        }
        CommonDataManager.share.item?.imgPathList = ["String"]

        if let tapNumber = tapNumber {
            tapButtons[tapNumber].titleLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
                //.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1), for: .normal)
            tapButtonSelectedViews[tapNumber].backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
            headerTapButtons[tapNumber].titleLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1) //.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1), for: .normal)
             headerTapButtonSelectedViews[tapNumber].backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        }
    }

    @IBAction private func actionPostItem(_ sender: UIButton) {
        do {
            let jsonEncoder = JSONEncoder()
            if let item = CommonDataManager.share.item,
            let data = try? jsonEncoder.encode(item),
            let params = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
                let path = "\(GrobyURL.base)\(GrobyURL.item.rawValue)"

                print(params)
                let requestData = RequestData(path: path, method: .post, params: params)
                ItemAPI(requestData).execute(onSuccess: { [weak self] _ in
                    guard let `self` = self else {
                        return
                    }
                    self.dismiss(animated: true, completion: nil)
                }) { _ in
                    assertionFailure("ItemAPI Error")
                }
            }
        } catch let error {
            assertionFailure("JSONEncoder Error")
        }
    }
}

// MARK: -

extension MakeTab1FourthViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 532 {
            tapMenuView.isHidden = false
        } else {
            tapMenuView.isHidden = true
        }
        print("scrollViewDidScroll: \(scrollView.contentOffset.y)")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 532 {
            tapMenuView.isHidden = false
        } else {
            tapMenuView.isHidden = true
        }
        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.y)")
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        navigationController?.navigationBar.isHidden = false
    }
}

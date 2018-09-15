//
//  MakeTab1FourthViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1FourthViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var minimumCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("글 미리보기")

        //        CommonDataManager.share.item?.tabOne?.contents
        //        CommonDataManager.share.item?.tabOne?.location

        titleLabel.text = CommonDataManager.share.item?.itemTitle
        nicknameLabel.text = CommonDataManager.share.userInfo?.userName
        minimumCountLabel.text = CommonDataManager.share.item?.itemAmountLimit
        endDateLabel.text = CommonDataManager.share.item?.tab1?.endDate

        if let userId = CommonDataManager.share.userInfo?.userId {
            CommonDataManager.share.item?.userId = "\(userId)"
        }
        CommonDataManager.share.item?.imgPathList = ["String"]
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
                ItemAPI(requestData).execute(onSuccess: { item in
                    print(item)
                }) { _ in
                    assertionFailure("ItemAPI Error")
                }
            }
        } catch let error {
            assertionFailure("JSONEncoder Error")
        }
    }
}

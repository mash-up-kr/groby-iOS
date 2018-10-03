//
//  CommonTabViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 24/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

protocol TabContainerSettable: class {
    var tabType: CommonTabViewController.TabType { get set }
}

class CommonTabViewController: UIViewController {

    static let addPostNotificationName = Notification.Name("addPostNotification")

    enum TabType: Int {
        case tabOne
        case tabTwo
        case tabThree
        case tabFour
        case tabFive

        var storyboard: String {
            switch self {
            case .tabOne:
                return "TabOneContainerView"
            case .tabTwo:
                return "TabTwoContainerView"
            case .tabThree:
                return "TabThreeContainerView"
            case .tabFour:
                return "TabFourContainerView"
            case .tabFive:
                return "TabFiveContainerView"
            }
        }
    }

    @IBOutlet weak var tabMenuView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var minimumCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet var tabButtons: [UIButton]!
    @IBOutlet var tabButtonSelectedViews: [UIView]!
    @IBOutlet var headerTabButtons: [UIButton]!
    @IBOutlet var headerTabButtonSelectedViews: [UIView]!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoriteButtonView: UIView!

    var pageViewController: UIPageViewController?
    var tabNumber: Int? = 0
    var item: Item?
    var selectedTabType: TabType = .tabOne
    var nextTabType: TabType = .tabOne

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        navigationController?.navigationItem.backBarButtonItem = backButtonItem
        navigationController?.isNavigationBarHidden = false

        titleLabel.text = item?.itemTitle
        nicknameLabel.text = item?.writerId
        minimumCountLabel.text = "\(item?.numOfLike ?? 0)"

        if let date = item?.tabOne?.endDate?.split(separator: " ").first?.description {
            endDateLabel.text = date
        }

//        CommonDataManager.share.item?.imgPathList = ["String"]

        if let tabNumber = tabNumber {
            tabButtons[tabNumber].titleLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
            //.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1), for: .normal)
            tabButtonSelectedViews[tabNumber].backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
            headerTabButtons[tabNumber].titleLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1) //.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1), for: .normal)
            headerTabButtonSelectedViews[tabNumber].backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        }
        setViewController(type: .tabOne, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? UIPageViewController {
            self.pageViewController = pageViewController
            self.pageViewController?.dataSource = self
            self.pageViewController?.delegate = self
        }
    }

    func viewController(at index: Int) -> UIViewController? {
        if let tab = TabType(rawValue: index), let viewController = UIStoryboard(name: tab.storyboard, bundle: nil).instantiateInitialViewController() {
            return viewController
        }
        return nil
    }

    func setViewController(type: TabType, animated: Bool) {
        guard let viewController = viewController(at: type.rawValue) else {
            return
        }

        pageViewController?.setViewControllers([viewController], direction: .forward, animated: animated, completion: { finished in
            if finished {
                DispatchQueue.main.async { [weak self] in
                    self?.pageViewController?.setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
                }
            }
        })
    }

    @IBAction private func actionTab(_ sender: UIButton) {
        guard let tabType = TabType(rawValue: sender.tag) else {
            return
        }

        setViewController(type: tabType, animated: false)
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

    @IBAction private func actionNext(_ sender: UIButton) {

    }
}

// MARK: -

extension CommonTabViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 532 {
            tabMenuView.isHidden = false
            favoriteButtonView.isHidden = false
        } else {
            tabMenuView.isHidden = true
            favoriteButtonView.isHidden = true
        }
        print("scrollViewDidScroll: \(scrollView.contentOffset.y)")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 532 {
            tabMenuView.isHidden = false
            favoriteButtonView.isHidden = false
        } else {
            tabMenuView.isHidden = true
            favoriteButtonView.isHidden = true
        }
        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.y)")
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        navigationController?.navigationBar.isHidden = false
    }
}

extension CommonTabViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let viewController = pendingViewControllers.last as? TabContainerSettable {
            nextTabType = viewController.tabType
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            selectedTabType = nextTabType
        }
    }
}

extension CommonTabViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let containerViewController = viewController as? TabContainerSettable {
            var index = containerViewController.tabType.rawValue
            if index == 0 || index == NSNotFound {
                return nil
            }
            index -= 1
            return self.viewController(at: index)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let containerViewController = viewController as? TabContainerSettable {
            var index = containerViewController.tabType.rawValue
            if index == 0 || index >= TabType.tabFive.rawValue {
                return nil
            }
            index += 1
            return self.viewController(at: index)
        }
        return nil
    }
}

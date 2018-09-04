//
//  MenuViewController.swift
//  groby
//
//  Created by Daeyun Ethan Kim on 11/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit


class MenuViewController: UITableViewController {
    
    private var categories: [Category]?
    
    @IBOutlet weak var wroteButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBAction func mypageButton(_ sender: Any) {
        let myPageStoryBoard = UIStoryboard(name: "MyPage", bundle: nil)
        let myPageNavigationController = myPageStoryBoard.instantiateViewController(withIdentifier: "MyPageViewController")
        navigationController?.pushViewController(myPageNavigationController, animated: true)
        
    }
    
    @IBAction func tappedMyPost(_ sender: UIButton) {
        let menuStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
        let menuViewController = menuStoryBoard.instantiateViewController(withIdentifier: "MyPostTableViewController")
        navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    @IBAction func tappedJoinedPost(_ sender: UIButton) {
        let menuStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
        let menuViewController = menuStoryBoard.instantiateViewController(withIdentifier: "JoinedPostTableViewController")
        navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setCustomTitle("Groby")
        
        setProperties()
        
        fetchCategories()
    }
    
    private func fetchCategories() {
        FetchCategoryJson().execute(
            onSuccess: { (categoryJson: CategoryJson) in
                self.categories = categoryJson.returnJson
                
                for category in self.categories! {
                    print("\(category.categotyId) , \(category.category)")
                }
        },
            onError: { (error: Error) in
                print("errorr \(error.localizedDescription)")
        })
        
    }
    
    private func setProperties() {
        wroteButton.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        wroteButton.layer.borderWidth = 1.0
        wroteButton.layer.cornerRadius = 8.0
        
        bookmarkButton.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        bookmarkButton.layer.borderWidth = 1.0
        bookmarkButton.layer.cornerRadius = 8.0
    }
    
    // MARK: - Actions
    
    @IBAction func actionClose(_ sender: UIButton) {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

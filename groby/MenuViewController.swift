//
//  MenuViewController.swift
//  groby
//
//  Created by Daeyun Ethan Kim on 11/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    @IBOutlet weak var wroteButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
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

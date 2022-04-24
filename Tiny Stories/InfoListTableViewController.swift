//
//  ViewController.swift
//  Tiny Stories
//
//  Created by Wills Blake on 4/23/22.
//

import UIKit

class InfoListTableViewController: UITableViewController {
    
    let stories = ["Story1", "Story2", "Story3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.Titles.mainTableTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.resuableCellIdentifier, for: indexPath)
        
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = stories[indexPath.row]
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


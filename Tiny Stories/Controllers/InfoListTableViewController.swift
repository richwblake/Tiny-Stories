//
//  ViewController.swift
//  Tiny Stories
//
//  Created by Wills Blake on 4/23/22.
//

import UIKit

class InfoListTableViewController: UITableViewController {
    
    var stories: [HNStory] = []
    
    var networkManager = NetworkManager(K.URL.frontPageHNUrl)

    @objc func refresh(_ sender: AnyObject) {
        refreshControl?.attributedTitle = NSAttributedString(string: "Updating...")
        networkManager.fetchData()
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.Titles.mainTableTitle
        networkManager.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: K.Sort.sortButtonNameFrontPage, image: nil, primaryAction: nil, menu: createBarButtonContextSortMenu())
        networkManager.fetchData()
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.resuableCellIdentifier, for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        let points = stories[indexPath.row].points == 1 ? "point" : "points"
        cellConfig.text = stories[indexPath.row].title
        cellConfig.secondaryText = "\(stories[indexPath.row].points) \(points)"
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func createBarButtonContextSortMenu() -> UIMenu {
        let menuItems = [
            UIAction(title: K.Sort.frontPageTitle, image: UIImage(systemName: K.Sort.frontPageImage), handler: { _ in
                self.updateManagerUrlAndFetchData(with: K.URL.frontPageHNUrl)
                self.navigationItem.rightBarButtonItem?.title = K.Sort.sortButtonNameFrontPage
                
            }),
            UIAction(title: K.Sort.newPostsTitle, image: UIImage(systemName: K.Sort.newPostsImage), handler: { _ in
                self.updateManagerUrlAndFetchData(with: K.URL.newPostsHNUrl)
                self.navigationItem.rightBarButtonItem?.title = K.Sort.sortButtonNameNew
            })
        ]
        
        return UIMenu(image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    private func updateManagerUrlAndFetchData(with url: String) {
        self.networkManager.url = url
        self.networkManager.fetchData()
    }
}

extension InfoListTableViewController: NetworkManagerDelegate {
    func didCompleteFetchRequest(with results: [HNStory]) {
        stories = results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

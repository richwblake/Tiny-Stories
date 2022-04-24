//
//  NetworkManager.swift
//  Tiny Stories
//
//  Created by Wills Blake on 4/23/22.
//

import Foundation

protocol NetworkManagerDelegate {
    func didCompleteFetchRequest(with results: [HNStory])
}

class NetworkManager {
    var url: String
    var posts: [HNStory] = []
    var delegate: NetworkManagerDelegate?
    
    init(_ url: String) {
        self.url = url
    }
    
    internal func fetchData() {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, resp, err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(HNResults.self, from: safeData)
                            self.delegate?.didCompleteFetchRequest(with: results.hits)
                        } catch {
                            print(error)
                        }
                        
                    }
                    
                    
                }
            }
            task.resume()
        }
    }
}

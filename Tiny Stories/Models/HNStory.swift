//
//  HNStory.swift
//  Tiny Stories
//
//  Created by Wills Blake on 4/23/22.
//

import Foundation

struct HNStory: Decodable {
    var id: String {
        objectID
    }
    let objectID: String
    let title: String
    let points: Int
    let url: String?
    let author: String
    let num_comments: Int
    let created_at_i: Int
    
    internal func getDate() -> Date {
        let postedTime = Date(timeIntervalSince1970: TimeInterval(created_at_i))
        print(postedTime.formatted(date: .abbreviated, time: .shortened))
        return postedTime
    }
    
    internal func getRelativeTime() -> Int {
        let diffDate = Calendar.current.dateComponents([.hour], from: Date(timeIntervalSince1970: Double(created_at_i)), to: Date())
        return diffDate.hour!
    }
}

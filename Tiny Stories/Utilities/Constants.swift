//
//  Constants.swift
//  Tiny Stories
//
//  Created by Wills Blake on 4/23/22.
//

import Foundation

struct K {
    struct Titles {
        static let mainTableTitle = "Tiny Stories"
    }
    
    struct Sort {
        static let sortButtonNameFrontPage = "Sorting by Front Page"
        static let sortButtonNameNew = "Sorting by New"
        static let frontPageTitle = "Front Page"
        static let frontPageImage = "flame"
        static let newPostsTitle = "New Posts"
        static let newPostsImage = "clock.arrow.circlepath"
    }
    
    struct URL {
        static let frontPageHNUrl = "http://hn.algolia.com/api/v1/search?tags=front_page"
        static let newPostsHNUrl = "https://hn.algolia.com/api/v1/search_by_date?tags=story&hitsPerPage=100"
    }
    
    static let resuableCellIdentifier = "TinyStoryCell"
}

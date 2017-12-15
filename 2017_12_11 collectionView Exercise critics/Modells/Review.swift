//
//  Review.swift
//  2017_12_11 collectionView Exercise critics
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct ReviewData: Codable {
    let results: [Review]
}
struct Review: Codable {
    let displayTitle: String?
    let headline: String?
    let summaryShort: String?
    enum CodingKeys: String, CodingKey {
        case displayTitle = "display_title"
        case headline
        case summaryShort = "summary_short"
    }
}

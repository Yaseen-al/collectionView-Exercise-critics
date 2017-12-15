//
//  Critics.swift
//  2017_12_11 collectionView Exercise critics
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation

struct CriticData: Codable {
    let results: [Critic]
}
struct Critic: Codable {
    let displayName: String
    let bio: String?
    let multimedia: MultimedieaWrapper?
    let status: String?
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case bio
        case multimedia
        case status
    }
}
struct MultimedieaWrapper: Codable {
    let resource: ImageWrapper
}
struct ImageWrapper: Codable {
    let src: String
}

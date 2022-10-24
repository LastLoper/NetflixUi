//
//  Content.swift
//  NetflixUI
//
//  Created by Walter J on 2022/10/23.
//

import UIKit

struct Content: Decodable {
    let sectionType: SectionType
    let contentName: String
    let contentItems: [Item]
    
    enum SectionType: String, Decodable {
        case main
        case basic
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}

//
//  Genre.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class Genre {
    var title = ""
    var featuredImage: UIImage!
    
    init(title: String, image: UIImage) {
        self.title = title
        self.featuredImage = image
    }
    
    static func createGenres() -> [Genre] {
        return [
            Genre(title: "Romance", image: UIImage(named: "romance_ipc.jpg")!),
            Genre(title: "Relax", image: UIImage(named: "relaxing.png")!),
            Genre(title: "Selfie", image: UIImage(named: "selfie.jpg")!),
            Genre(title: "Sensual", image: UIImage(named: "sensual_kiss.jpg")!),
            Genre(title: "Everyday", image: UIImage(named: "everyday.jpg")!),
            Genre(title: "Thriller", image: UIImage(named: "thriller.jpg")!)
        ]
    }
}

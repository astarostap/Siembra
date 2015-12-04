//
//  HomeCollectionViewGenreCell.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class HomeCollectionViewGenreCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var genreTitleLabel: UILabel!
    
    
    var genre: Genre! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        featuredImageView?.image! = genre.featuredImage
        genreTitleLabel?.text! = genre.title
    }
}

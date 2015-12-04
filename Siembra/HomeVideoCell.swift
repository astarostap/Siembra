//
//  HomeVideoCell.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class HomeVideoCell: UICollectionViewCell {

    @IBOutlet weak var featuredImage: UIImageView!
    
    @IBOutlet weak var videoTitle: UILabel!
    
    var videoUrl = ""
    
    var video: Video! {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        featuredImage?.image! = video.featuredImage
        videoTitle?.text! = video.title
        self.videoUrl = video.videoUrl
    }
}

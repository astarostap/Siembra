//
//  HomeViewController.swift
//  Siembra
//
//  Created by Abraham Starosta on 12/1/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    
    private var genres = Genre.createGenres()
    private var videos = Video.createVideos()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.scrollEnabled = true
    }

    private struct Storyboard {
        static let CallIdentifier = "Genre Cell"
        static let VideoIdentifier = "Video Cell"
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.restorationIdentifier == "VideoCollectionView") {
            return videos.count
        } else {
            return genres.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (collectionView.restorationIdentifier == "VideoCollectionView") {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.VideoIdentifier, forIndexPath: indexPath) as! HomeVideoCell
            let video = self.videos[indexPath.item]
            cell.video = video
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CallIdentifier, forIndexPath: indexPath) as! HomeCollectionViewGenreCell
            let genre = self.genres[indexPath.item]
            cell.genre = genre
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if (collectionView.restorationIdentifier == "VideoCollectionView") {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HomeVideoCell
            performSegueWithIdentifier("videoSegue", sender: cell)
        } else {
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc: UIViewController? = segue.destinationViewController
        if let videoViewController = destinationvc as? YoutubeVideoViewController {
            if let cell = sender as? HomeVideoCell {
                videoViewController.videoUrl = cell.videoUrl
            }
        }
    }
}
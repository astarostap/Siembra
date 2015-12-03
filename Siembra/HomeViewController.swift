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
    
    
    
    private var genres = Genre.createGenres()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.scrollEnabled = true
    }

    private struct Storyboard {
        static let CallIdentifier = "Genre Cell"
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CallIdentifier, forIndexPath: indexPath) as! HomeCollectionViewGenreCell
        let genre = self.genres[indexPath.item]
        cell.genre = genre
        return cell
    }
    
}
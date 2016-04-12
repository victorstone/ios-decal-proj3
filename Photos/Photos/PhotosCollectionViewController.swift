//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos : [Photo]!
    var current_cell : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    let imageCache = NSCache()
    
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        if let image = imageCache.objectForKey(photo.url) as? UIImage {
            imageView.image = image
        } else {
            let url = NSURL(string: photo.url)!
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if error == nil {
                    let imageToDisplay = UIImage(data: data!)
                    imageView.image = imageToDisplay
                    self.imageCache.setObject(imageToDisplay!, forKey: photo.url)
                }
            }
            task.resume()
        }
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(newPhotos: [Photo]) {
        self.photos = newPhotos
        self.collectionView!.reloadData()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (photos != nil) {
            return photos.count
        }
        return 10
        
    }
    
    //3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! imageCell
        cell.imageCellPicture.image = UIImage(named: "loading.gif")
        if (cell.imageLoaded == false) {
            if (photos != nil) {
                loadImageForCell(photos![indexPath.row], imageView: cell.imageCellPicture)
                cell.imageLoaded = true
            }
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectedPhoto" && photos != nil {
            let indexPath = self.collectionView?.indexPathsForSelectedItems()?.first?.row
            let destination = segue.destinationViewController as! SelectedPhotoViewController
            let cell = photos[indexPath!]
            print(imageCache.objectForKey(photos[indexPath!].url))
            if (destination.asdf == nil) {
                destination.asdf_delegation = UIImageView(image: self.imageCache.objectForKey(cell.url) as? UIImage)
                destination.numLikes_delegation = cell.likes
                destination.username_delegate = cell.username
                destination.date_delegation = cell.date
            }
            
        }
    }
    
}
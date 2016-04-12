//
//  SelectedPhotoViewController.swift
//  Photos
//
//  Created by Victor Stone on 4/11/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import Foundation
import UIKit

class SelectedPhotoViewController : UIViewController {
    

    @IBOutlet weak var username: UITextView!
    @IBOutlet weak var asdf: UIImageView!
    @IBOutlet weak var date: UITextView!
    @IBOutlet weak var numLikes: UITextView!
    
    @IBOutlet weak var likeButton: UIButton!
    var username_delegate = ""
    var asdf_delegation = UIImageView()
    var date_delegation = NSDate()
    var numLikes_delegation = 0
    var pressed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.text = username_delegate
        self.asdf.image = imageWithSize(asdf_delegation.image!, size: CGSize(width: 400, height: 400))
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh/mm/yy hh:mm a"
        self.date.text = dateFormatter.stringFromDate(date_delegation)
        self.numLikes.text = String(numLikes_delegation)
        self.likeButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
    }
    func pressed(sender: UIButton!) {
        if self.pressed {
            sender.setImage(UIImage(named: "unlike.jpg"), forState: UIControlState.Normal)
            self.numLikes_delegation -= 1
        } else {
            sender.setImage(UIImage(named: "like.jpg"), forState: UIControlState.Normal)
            self.numLikes_delegation += 1
        }
        self.numLikes.text = String(numLikes_delegation)
        self.pressed = !self.pressed
    }
    
    override func viewWillDisappear(animated: Bool) {
        <#code#>
    }
    /* Got aspect fit code from stackoverflow since I could not get Apple's implementation to work */
    
    func imageWithSize(originalImage: UIImage, size:CGSize) -> UIImage
    {
        var scaledImageRect = CGRect.zero;
        
        let aspectWidth:CGFloat = size.width / originalImage.size.width;
        let aspectHeight:CGFloat = size.height / originalImage.size.height;
        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight);
        
        scaledImageRect.size.width = originalImage.size.width * aspectRatio;
        scaledImageRect.size.height = originalImage.size.height * aspectRatio;
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        
        originalImage.drawInRect(scaledImageRect);
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return scaledImage;
    }


    
    
}

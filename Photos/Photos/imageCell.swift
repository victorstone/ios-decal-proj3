//
//  imageCell.swift
//  Photos
//
//  Created by Victor Stone on 4/11/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import Foundation
import UIKit

class imageCell : UICollectionViewCell {
    
    @IBOutlet weak var imageCellPicture: UIImageView!
    var imageLoaded = false 
    
    override func prepareForReuse() {
        imageLoaded = false
    }
}
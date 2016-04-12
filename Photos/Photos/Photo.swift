//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* Url to thumbnail */
    var thumbnail : String!
    /* The username of the photographer. */
    var username : String!
    /* Date created */
    var date : NSDate!
    
    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
        self.likes = (data.valueForKey("likes") as! NSDictionary).valueForKey("count") as! Int
        self.url = ((data.valueForKey("images") as! NSDictionary).valueForKey("standard_resolution") as! NSDictionary).valueForKey("url") as! String
        self.thumbnail = ((data.valueForKey("images") as! NSDictionary).valueForKey("thumbnail") as! NSDictionary).valueForKey("url") as! String
        self.username = (data.valueForKey("user") as! NSDictionary).valueForKey("username") as! String
        self.date = NSDate(timeIntervalSince1970: Double((data.valueForKey("created_time") as! String))!)

    }

}
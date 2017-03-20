//
//  ParseClient.swift
//  Instify
//
//  Created by Rajjwal Rawal on 3/20/17.
//  Copyright © 2017 Rajjwal Rawal. All rights reserved.
//

import UIKit
import Parse

class ParseClient: NSObject {
    
    class func getMostRecentPosts(numberOfPosts: Int, completion: @escaping ([PFObject]) -> Void) {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "creationTime")
        query.limit = numberOfPosts
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                completion(posts)
            } else {
                print(error?.localizedDescription ?? "Unknown error")
            }
        }
    }


}

//
//  Post.swift
//  Instify
//
//  Created by Rajjwal Rawal on 3/20/17.
//  Copyright © 2017 Rajjwal Rawal. All rights reserved.
//

import UIKit
import Parse


class Post: NSObject {
    
    var dateStr: String?
    let media: PFFile?
    let username: String?
    let caption: String?
    
    init(pfObject: PFObject) {
        print(pfObject)
        
        if let postDate = pfObject.createdAt{
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.day,.hour,.minute,.second], from: postDate, to: Date())
            let day = components.day!
            let hour = components.hour!
            let minute = components.minute!
            let second = components.second!
            
            if day > 0{
                if day > 1{
                    dateStr = "\(day) days ago"
                }
                else{
                    dateStr = "1 day ago"
                }
            }
            else if hour > 0{
                if hour > 1{
                    dateStr = "\(hour) hours ago"
                }
                else{
                    dateStr = "1 hours ago"
                }
            }
            else if minute > 0{
                if minute > 1{
                    dateStr = "\(minute) minutes ago"
                }
                else{
                    dateStr = "1 minutes ago"
                }
            }
            else{
                dateStr = "\(second) seconds ago"
            }
        }
        
        media = pfObject["media"] as? PFFile
        username = pfObject["username"] as? String
        caption = pfObject["caption"] as? String
    }

    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["creationTime"] = Date.timeIntervalSinceReferenceDate
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["username"] = PFUser.current()?.username! // Pointer column type that points to PFUser
        post["caption"] = caption ?? "My photography skills"
        

        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            if let resizedImage = resize(image: image, newScale: 0.5) {
                // get image data and check if that is not nil
                if let imageData = UIImagePNGRepresentation(resizedImage) {
                    return PFFile(name: "image.png", data: imageData)
                }
            }
        }
        return nil
    }
    
    private class func resize(image: UIImage, newScale: CGFloat) -> UIImage? {
        let size = image.size
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width * newScale, height: size.height * newScale))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

}

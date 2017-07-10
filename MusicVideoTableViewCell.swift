//
//  MusicVideoTableViewCell.swift
//  MusicApp
//
//  Created by TAE experts on 09/02/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    
    @IBOutlet var musicImage: UIImageView!
    @IBOutlet var rankLbl: UILabel!
    @IBOutlet var musicTitleLbl: UILabel!

    
    func updateCell() {
        
        musicTitleLbl.text = ("\(video!.vName) - \(video!.vArtist)")
       
        //musicImage.image = UIImage(named: "SorryImage")
        
        //If image is not nil get from array else get from API
        //This is to stop API making the calls over and over and getting same data
        if video!.vImageData != nil {
            //print("get image")
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            getVideoImage(video!, imageView: musicImage)
        }
        
    }
    
    func getVideoImage(video: Videos, imageView: UIImageView) {
        
        /*
        * @constant DISPATCH_QUEUE_PRIORITY_HIGH
        * Items dispatched to the queue will run at high priority,
        * i.e. the queue will be scheduled for execution before
        * any default priority or low priority queue.
        *
        * @constant DISPATCH_QUEUE_PRIORITY_DEFAULT
        * Items dispatched to the queue will run at the default
        * priority, i.e. the queue will be scheduled for execution
        * after all high priority queues have been scheduled, but
        * before any low priority queues have been scheduled.
        *
        * @constant DISPATCH_QUEUE_PRIORITY_LOW
        * Items dispatched to the queue will run at low priority,
        * i.e. the queue will be scheduled for execution after all
        * default priority and high priority queues have been
        * scheduled.
        */
        
        //Get image from URL in the background queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            //Grab the imageURL
            let data = NSData(contentsOfURL: NSURL(string: video.vImageURL)!)
            
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //Back tomain queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
            
        }
        
    }


}

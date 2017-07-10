//
//  DetailViewController.swift
//  MusicApp
//
//  Created by TAE experts on 09/02/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DetailViewController: UIViewController {

    @IBOutlet var vNameLbl: UILabel!
    @IBOutlet var videoImage: UIImageView!
    @IBOutlet var vGenreLbl: UILabel!
    @IBOutlet var vPriceLbl: UILabel!
    @IBOutlet var vRightsLbl: UILabel!
    
    var videos:Videos!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        vNameLbl.text = ("\(videos.vName) - \(videos.vArtist)")
        vGenreLbl.text = videos.vGenre
        vPriceLbl.text = videos.vPrice
        vRightsLbl.text = videos.vRights
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        } else {
            videoImage.image = UIImage(named: "SorryImage")
        }
    }

    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        //URL of the video stream
        let url = NSURL(string: videos.vVideoURL)!
        
        //Pass the player the URL
        let player = AVPlayer(URL: url)
        
        //Create a playerVC
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        self.presentViewController(playerVC, animated: true) {
            playerVC.player?.play()
        }
        
        
    }

}

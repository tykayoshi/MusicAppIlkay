//
//  ViewController.swift
//  MusicApp
//
//  Created by TAE experts on 24/01/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    var videos = [Videos]()

    @IBOutlet var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add observer to check for internet connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        //Call method to change label depending on connection
        reachabilityStatusChanged()
        
        //Call API
        //Gets the videos and passes it into the didLoadData method
        let api = APIManager()
        api.loadData("https:/itunes.apple.com/gb/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        //Reload data and show info
        tableView.reloadData()
        
    }
    
    //Change label and background depending on connection
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "WIFI Connected"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Mobile Data Connected"
        default:return
        }
    }
    
    //Remove observer if we are not in this view controller
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    private struct storyboard {
        static let cellID = "myCell"
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellID, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        //Grab all the videos in each index
        cell.video = videos[indexPath.row]
        
        cell.rankLbl.text = ("#\(indexPath.row + 1)")

        
        return cell
        
    }
    

}



//        //Print Index of array
//        for(index, item) in videos.enumerate() {
//            print("\(index) name = \(item.vName)")
//        }



//        ALERT CONTROLLER
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//
//        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
//            //Do Something
//        }
//
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion: nil)


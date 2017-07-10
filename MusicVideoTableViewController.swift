//
//  MusicVideoTableViewController.swift
//  MusicApp
//
//  Created by TAE experts on 07/02/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import UIKit

class MusicVideoTableViewController: UITableViewController {

    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add observer to check for internet connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        //Call method to change label depending on connection
        reachabilityStatusChanged()
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        //Reload data and show info
        self.tableView.reloadData()
        
        /* for item in videos {
        print("name = \(item.vName)")
        }*/
    }
    
    //Change label and background depending on connection
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()) {
            //No connectivity show alert
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
            
            //Regular Button
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                action -> () in
                print("Cancel")
            }
            //Red Button
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                action -> () in
                print("Delete")
            }
            //Regular Button
            let okAction = UIAlertAction(title: "OK", style: .Default) {
                action -> () in
                print("OK")
                
                //do something
            }
            
            //Add actions
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
            
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0{
                print("Have Info!")
            } else {
                callAPI()
            }
        }
    }
    
    func callAPI() {
        
        //Call API
        //Gets the videos and passes it into the didLoadData method
        let api = APIManager()
        api.loadData("https:/itunes.apple.com/gb/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    //Remove observer if we are not in this view controller
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellID = "myCell"
        static let detailSegueID = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellID, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        //Grab all the videos in each index
        cell.video = videos[indexPath.row]
        
        cell.rankLbl.text = ("#\(indexPath.row + 1)")
        
        
        return cell


    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.detailSegueID {
            if let indexPath = tableView.indexPathForSelectedRow {
                //Select that specific video object
                let video = videos[indexPath.row]
                let dVC = segue.destinationViewController as! DetailViewController
                //Set that object in the detail view controller
                dVC.videos = video
            }
        }
    }



}

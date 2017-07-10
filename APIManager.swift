//
//  APIManager.swift
//  MusicApp
//
//  Created by TAE experts on 24/01/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//
/*Notes:

Always do big downloads in the background queue then move it to the front. Never do it in the view


*/
import Foundation

class APIManager {
    
    
    //Get data from API and print it out, also print out if success or fail
    func loadData(urlString:String, completion: [Videos] -> Void) {
        
        //Bypass caching
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        //Async task
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
                if error != nil {

                    print(error!.localizedDescription)
        
                } else {
                    
                    do {
                        /* .AllowFragments if top level is not an Array or Dictionary*/
                        //Convert the data to JSON using Try/Catch
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                            //Top level part of the JSON
                            feed = json["feed"] as? JSONDictionary,
                            entries = feed["entry"] as? JSONArray {
                                
                                //Create video object
                                var videos = [Videos]()
                                
                                //Go through the array and add the videos
                                for entry in entries {
                                    //Grabs the info from JSON and adds it into the variables
                                    let entry = Videos(data: entry as! JSONDictionary)
                                    //Add to array
                                    videos.append(entry)
                                }
                                
                                let i = videos.count
                                print("Number of videos \(i)")
                                
                                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        //Passing back videos
                                        completion(videos)
                                    }
                                }
                        }
                    } catch {
                            print("Error")
                        }
                                
                }

        }
        
        task.resume()
    }
    }

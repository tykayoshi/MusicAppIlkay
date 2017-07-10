//
//  MusicVideo.swift
//  MusicApp
//
//  Created by TAE experts on 25/01/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import Foundation

class Videos {
    
    //Data Encapsulation
    private var _vName:String
    private var _vImageURL:String
    private var _vVideoURL:String
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
    //Can be nil if we dont have an image
    //If we say this value cant be nil we have to initialise it
    var vImageData:NSData?
    
    
    //Getters and setters
    var vName:String {
        return _vName
    }
    
    var vImageURL:String {
        return _vImageURL
    }
    
    var vVideoURL:String {
        return _vVideoURL
    }
    
    var vRights:String {
        return _vRights
    }
    
    var vPrice:String {
        return _vPrice
    }
    
    var vArtist:String {
        return _vArtist
    }
    
    var vImid:String {
        return _vImid
    }
    
    var vGenre:String {
        return _vGenre
    }
    
    var vLinkToiTunes:String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate:String {
        return _vReleaseDate
    }
    
    
    
    //Parse all the data in the correct format to the variables
    init(data: JSONDictionary) {
        
        //Initialise all properties to avoid error messages
        
        //Video Name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            _vName = vName
        } else  {
            _vName = ""
        }
        
        //Video image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            vImageURL = image["label"] as? String {
                _vImageURL = vImageURL.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageURL = ""
        }
        
        //Video URL
        if let video = data["link"] as? JSONArray,
        vURL = video[1] as? JSONDictionary,
        vHref = vURL["attributes"] as? JSONDictionary,
            vVideoURL = vHref["href"] as? String {
                _vVideoURL = vVideoURL
        } else {
            _vVideoURL = ""
        }
        
        //Video Rights
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
                _vRights = vRights
        } else {
            _vRights = ""
        }
        
        //Video Price
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
                _vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        //Video Artist
        if let artistName = data["im:artist"] as? JSONDictionary,
            vArtist = artistName["label"] as? String {
                _vArtist = vArtist
        } else {
            _vArtist = ""
        }
        
        //Video Artist ID
        if let videoID = data["id"] as? JSONDictionary,
        vid = videoID["attributes"] as? JSONDictionary,
            vImid = vid["im:id"] as? String {
                _vImid = vImid
        } else {
            _vImid = ""
        }
        
        //Video Genre
        if let genre = data["category"] as? JSONDictionary,
        attr1 = genre["attributes"] as? JSONDictionary,
            vGenre = attr1["term"] as? String {
                _vGenre = vGenre
        } else {
            _vGenre = ""
        }
        
        //Video Link to iTunes
        if let link = data["link"] as? JSONArray,
        vLink = link[0] as? JSONDictionary,
        attr1 = vLink["attributes"] as? JSONDictionary,
            vLinkToiTunes =  attr1["href"] as? String {
                _vLinkToiTunes = vLinkToiTunes
        } else {
            _vLinkToiTunes = ""
        }
        
        //Video Release Date
        if let date = data["im:releaseDate"] as? JSONDictionary,
        attr1 = date["attributes"] as? JSONDictionary,
            vReleaseDate = attr1["label"] as? String {
                _vReleaseDate = vReleaseDate
        } else {
            _vReleaseDate = ""
        }
    }

}
    
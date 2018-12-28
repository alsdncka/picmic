//
//  query.swift
//  picmic
//
//  Created by mac on 2018. 9. 2..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation

struct wwurl {
    var urls="http://180.224.166.87:3000"
    let adduser="/user/adduser"
    let signon="/user/signon"
    let signCheck="/user/signcheck"
    let pickImage="/pick/pickimage"
     let library="/pick/getlibrary"
    let uploadFeed="/feed/uploadFeed"
    let loadFeeds="/feed/loadfeeds"
    let loadFeed="/feed/loadfeed"
    let loadfeedimage="/feed/loadfeedimage"
    let getuser="/user/getuser"
    let myimage="/pick/getmypick"
    let image = "/pick/getImage"
    let setedition = "/edition/setedition"
    let getedition = "/edition/getedition"
    let checkedition = "/edition/checkedition"
    let loadedition = "/edition/loadedition"
    let loadmyfeed = "/feed/loadmyfeed"
    let updateuser = "/user/updateuser"
    
    func updateUser()->String{
        return urls+updateuser
    }
    
    func getEdidtion()->String{
        return urls+getedition
    }
    
    func loadEdition()->String{
        return urls+loadedition
    }
    
    func setEdidtion()->String{
        return urls+setedition
    }
    
    func getImage()->String{
        return urls+image
    }
    
    func getMyImage()->String{
        return urls+myimage
    }
    
    func getAddUser()->String{
        return urls+adduser
    }
    
    func getUser()->String{
        return urls+getuser
    }
    
    func getSignon()->String{
        return urls+signon
    }
    func getSignCheck()->String{
        return urls+signCheck
    }
    func getPickImage()->String{
        return urls+pickImage
    }
    func getLibrary()->String{
        return urls+library
    }
    func getUploadFeed()->String{
        return urls+uploadFeed
    }
    func getLoadFeeds()->String{
        return urls+loadFeeds
    }
    func getLoadMyFeeds()->String{
        return urls+loadmyfeed
    }
    func getLoadFeed()->String{
        return urls+loadFeed
    }
    func getloadfeedimage()->String{
        return urls+loadfeedimage
    }
 
    func getCheckEdition()->String{
        return urls+checkedition
    }

    
}

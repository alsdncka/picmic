//
//  ST_MYPAGE.swift
//  picmic
//
//  Created by mac on 2018. 12. 27..
//  Copyright © 2018년 mac. All rights reserved.
//

import Foundation

class ST_MYPAGE{
    
    
    let page:String="/mypage"
    let server_url:String=wwurl().urls
    var base_url:String?
    init(){
        base_url=server_url+page
    }
    func myfeedimage()->String{
        return base_url!+"/myfeedimage"
    }
    
    
}


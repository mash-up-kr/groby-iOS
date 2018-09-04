//
//  FetchCategoryJson.swift
//  groby
//
//  Created by byungtak on 2018. 9. 4..
//  Copyright © 2018년 mashup. All rights reserved.
//

import Foundation

struct FetchCategoryJson: RequestType {
    typealias ResponseType = CategoryJson
    
    var data: RequestData {
        return RequestData(path: "http://ec2-13-125-62-50.ap-northeast-2.compute.amazonaws.com/category/")
    }
}

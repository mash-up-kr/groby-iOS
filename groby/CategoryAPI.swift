//
//  CategoryAPI.swift
//  groby
//
//  Created by byungtak on 2018. 9. 4..
//  Copyright © 2018년 mashup. All rights reserved.
//

import Foundation

struct CategoryAPI: RequestType {
    typealias ResponseType = CategoryJson

    var data: RequestData {
        return RequestData(path: "\(GrobyURL.base)\(GrobyURL.category.rawValue)")
    }
}

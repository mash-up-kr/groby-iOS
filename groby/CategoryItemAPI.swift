//
//  CategoryItemAPI.swift
//  groby
//
//  Created by Daeyun Ethan on 16/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct CategoryItemAPI: RequestType {
    typealias ResponseType = CategoryItemJSON

    var requestData: RequestData
    var data: RequestData {
        return requestData
    }

    init(_ requestData: RequestData) {
        self.requestData = requestData
    }
}

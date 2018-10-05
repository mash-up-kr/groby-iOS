//
//  DistributionApi.swift
//  groby
//
//  Created by byungtak on 05/10/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct DistributionsApi: RequestType {
    typealias ResponseType = DistributionJSON
    
    var data: RequestData {
        return RequestData(path: "\(GrobyURL.base)\(GrobyURL.item.rawValue)")
    }
}

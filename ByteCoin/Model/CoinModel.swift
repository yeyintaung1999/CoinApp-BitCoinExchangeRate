//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Ye Yint Aung on 03/03/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
//    var time: String
//    var asset_id_base: String
//    var asset_id_quote: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case rate
    }
}

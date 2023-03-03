//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didPriceUpdate(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "2D9727E1-AD07-4F11-926D-01A673A99964"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate : CoinManagerDelegate?

    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
 
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let price = parseJson(safeData){
                        let priceString = String(format: "%.2f", price)
                        
                       self.delegate?.didPriceUpdate(price: priceString, currency: currency)
                    }
                }
            }
            
            task.resume()
        }
    }

    
    func parseJson(_ safeData: Data)->Double?{
        do{
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CoinData.self, from: safeData)
            return decodedData.rate
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

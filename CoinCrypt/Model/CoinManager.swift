//
//  CoinManager.swift
//  CoinCrypt
//
//  Created by Jaden Hong on 2022-01-16.
//

import UIKit

protocol CoinManagerDelegate {
    func didUpdateData(_ coinModel: CoinModel)
}

struct CoinManager {
    let url = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "?apikey=547744CE-4934-450C-9EAD-6A0949C273DF"
     
    var delegate: CoinManagerDelegate?
    
    func fetchRequest(coin: String, cash: String) {
        let urlString = "\(url)\(coin)/\(cash)\(apiKey)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        if let safeUrl = URL(string: urlString) {
            let request = URLRequest(url: safeUrl)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    print("error")
                }
                if let safeData = data {
                    self.parseJSON(data: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DataModel.self, from: data)
            
            let rate = decodedData.rate
            let time = decodedData.time
            
            let coin = CoinModel(currentTime: time, coinRate: rate)
            
            delegate?.didUpdateData(coin)
            
        } catch {
            print("error")
        }
    }
    
    
    
    
    
    
}

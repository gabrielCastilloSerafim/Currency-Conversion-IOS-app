//
//  Networking.swift
//  Currency Checker
//
//  Created by Gabriel Castillo Serafim on 1/9/22.
//

import Foundation
protocol NetworkingDelegate {
    func receiveProcessedData(networking: Networking, processedData: CurrencyModel)
    func didGetError(error:Error)
}


struct Networking {

    let dataStruct = DataStruct()
    var currencyModel: CurrencyModel?
    var delegate: NetworkingDelegate?
    
    let baseURL = "https://marketdata.tradermade.com/api/v1/convert?api_key=eIlbrEzbuHYUgLEl_w1Z&"
    
    func makeNetworking (currency1:Int, currency2:Int, amount:String) {
        let url = "\(baseURL)from=\(dataStruct.currenciesForRequest[currency1])&to=\(dataStruct.currenciesForRequest[currency2])&amount=\(amount)"
        
        makeRequest(url: url)
    }
    
     func makeRequest(url:String) {
        
        if let safeURL = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: safeURL) { data, response, error in
                if error != nil {
                    delegate?.didGetError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let processedData = self.parseJSON(data: safeData) {
                        //Pass processed data to delegate
                        delegate?.receiveProcessedData(networking: self, processedData: processedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
     func parseJSON(data:Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(DecodeJSON.self, from: data)
            
            let total = decodedData.total
            let rate = decodedData.quote
            let fromCurrency = decodedData.base_currency
            let toCurrency = decodedData.quote_currency
            
            let processedData = CurrencyModel(total: total, rate: rate, fromCurrency: fromCurrency, toCurrency: toCurrency)
            
            return processedData
    
        } catch {
            delegate?.didGetError(error: error)
            return nil
        }
        
    }
}

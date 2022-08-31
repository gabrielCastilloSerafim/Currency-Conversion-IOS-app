//
//  test.swift
//  Currency Checker
//
//  Created by Gabriel Castillo Serafim on 30/8/22.
//

import Foundation
struct test {
    var semaphore = DispatchSemaphore (value: 0)
    
    let url = "https://api.apilayer.com/fixer/convert?to=BRL&from=EUR&amount=5"
    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    request.addValue("GrH51tMJ6wgTEnc3fNWs30Eseum7NTjb", forHTTPHeaderField: "apikey")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
        semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
}

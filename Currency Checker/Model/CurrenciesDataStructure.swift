//
//  CurrenciesData.swift
//  Currency Checker
//
//  Created by Gabriel Castillo Serafim on 1/9/22.
//

import Foundation


struct DataStruct {
    
    let currenciesForDisplay: [String]
    let currenciesForRequest: [String]
    
    init () {
    
    currenciesForDisplay = ["-", "USD 🇺🇸", "EUR 🇪🇺", "BRL 🇧🇷", "CAD 🇨🇦", "GBP 🇬🇧", "HKD 🇭🇰", "ZAR 🇿🇦", "DKK 🇩🇰", "KRW 🇰🇷", "HUF 🇭🇺", "JPY 🇯🇵" ,"CNY 🇨🇳","MXN 🇲🇽" ,"RON 🇷🇴", "CHF 🇨🇭", "PLN 🇵🇱", "NZD 🇳🇿", "INR 🇮🇳", "AUD 🇦🇺", "ARS 🇦🇷", "CLP 🇨🇱", "COP 🇨🇴", "PHP 🇵🇭", "RUB 🇷🇺", "TRY 🇹🇷", "TWD 🇹🇼", "VND 🇻🇳", "SGD 🇸🇬", "SEK 🇸🇪", "NGN 🇳🇬", "KWD 🇰🇼", "ISK 🇮🇸", "HRK 🇭🇷", "MAD 🇲🇦", "NOK 🇳🇴","BHD 🇧🇭", "AED 🇦🇪", "CZK 🇨🇿", "IDR 🇮🇩", "ILS 🇮🇱", "MYR 🇲🇾", "OMR 🇴🇲", "THB 🇹🇭", "PEN 🇵🇪"]
    
    currenciesForRequest = ["-", "USD", "EUR", "BRL", "CAD", "GBP", "HKD", "ZAR", "DKK", "KRW", "HUF", "JPY" ,"CNY","MXN" ,"RON", "CHF", "PLN", "NZD", "INR", "AUD", "ARS", "CLP", "COP", "PHP", "RUB", "TRY", "TWD", "VND", "SGD", "SEK", "NGN", "KWD", "ISK", "HRK", "MAD", "NOK","BHD", "AED", "CZK", "IDR", "ILS", "MYR", "OMR", "THB", "PEN"]
    
    }
       

    
}


//
//  Stock.swift
//  Project1
//
//  Created by Tsz Kit Cheung on 2023-12-04.


import Foundation

class stockTS: Codable {
    var stockID: String
    var date: String
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Int
    var numOfTrades: Int

    init(stockID: String, date: String, open: Double, high: Double, low: Double, close: Double, volume: Int, numOfTrades: Int) {
        self.stockID = stockID
        self.date = date
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
        self.numOfTrades = numOfTrades
    }
}


// Define a class for the top-level JSON
class stockTotalList: Codable {
    var results: [stockTS]

    init(results: [stockTS]) {
        self.results = results
    }
}


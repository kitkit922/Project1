//
//  NetworkingManager.swift
//  Project1
//
//  Created by Tsz Kit Cheung on 2023-12-04.
//

import Foundation


// Result <Sucess,Error>

// return cities
protocol NetworkingDelegate{
    
    // return success
    func networkingDidFinishWithSuccess(stock : stockTS)
    
    // return success
    func networkingDidFinishWithList(stockTotalList : stockTotalList)
    
    // return error
    func networkingDidFinishWithError()
}

// 2 functions
// similar, but inut URL is defferent, output of URL is different
// handling different data types


class NetworkingManager {
    
    // network setup
    var delegate: NetworkingDelegate?
    static var shared = NetworkingManager()
   
    func getStockData(stockName: String, date: String) {
        let apiKey = "MRaFaPpBOMs8Obi5dQgwK6WwxLG6QBvF"
        let urlString = "https://api.polygon.io/v2/aggs/ticker/\(stockName)/range/1/day/\(date)/\(date)?adjusted=true&sort=asc&apiKey=\(apiKey)"
        
        let urlObj = URL(string: urlString)!

        var task: URLSessionDataTask?
        task = URLSession.shared.dataTask(with: urlObj) { [weak self] data, response, error in
            guard let self = self else { return }

            // if error
            if let error = error {
                print("Network error: \(error)")
                self.delegate?.networkingDidFinishWithError()
                return
            }

            // if good response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.delegate?.networkingDidFinishWithError()
                return
            }


            print("success run")
            
  
          

            // Processing data
            if let gooddata = data {
                let decoder = JSONDecoder()
                do {
                    // JSON struture using
                    guard let jsondic = try JSONSerialization.jsonObject(with: gooddata) as? [String: Any],
                          let results = jsondic["results"] as? [[String: Any]] 
                    
                    else {
                        print("Error: Invalid JSON format")
                        self.delegate?.networkingDidFinishWithError()
                        return
                    }

                    // extract results
                    // use first to get first result
                    if let firstResult = results.first,
                       let open = firstResult["o"] as? Double,
                       let high = firstResult["h"] as? Double,
                       let low = firstResult["l"] as? Double,
                       let close = firstResult["c"] as? Double,
                       let volume = firstResult["v"] as? Int,
                       let numOfTrades = firstResult["n"] as? Int {
                        
                        print("stockTS: \(stockName), \(date), \(open), \(high), \(low), \(close), \(volume), \(numOfTrades)")
                        let stockData = stockTS(stockID: stockName, date: date, open: open, high: high, low: low, close: close, volume: volume, numOfTrades: numOfTrades)
                        
                        DispatchQueue.main.async {
                            self.delegate?.networkingDidFinishWithSuccess(stock: stockData)
                        }
                        
                    } else {
                        print("Error: Missing or invalid data in JSON")
                        self.delegate?.networkingDidFinishWithError()
                    }
                    
                    
                } catch {
                    print("Decoding error: \(error)")
                    self.delegate?.networkingDidFinishWithError()
                }
                
                
                
            } else {
                print("Error, no data")
                self.delegate?.networkingDidFinishWithError()
            }
        }
        
        task?.resume()
    }
    
    
    
    
    
    
    
    func getMultiStockData(stockName: String, date1: String, date2: String) {
        let apiKey = "MRaFaPpBOMs8Obi5dQgwK6WwxLG6QBvF"
        let urlString = "https://api.polygon.io/v2/aggs/ticker/\(stockName)/range/1/day/\(date1)/\(date2)?adjusted=true&sort=asc&apiKey=\(apiKey)"
        
        print("aaa")
        
        let urlObj = URL(string: urlString)!

        var task: URLSessionDataTask?
        task = URLSession.shared.dataTask(with: urlObj) { [weak self] data, response, error in
            guard let self = self else { return }

            // if error
            if let error = error {
                print("Network error: \(error)")
                self.delegate?.networkingDidFinishWithError()
                return
            }

            // if good response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.delegate?.networkingDidFinishWithError()
                return
            }


            print("success run")
            
  
          

            // Processing data
            if let gooddata = data {
                let decoder = JSONDecoder()
                do {
                    guard let jsondic = try JSONSerialization.jsonObject(with: gooddata) as? [String: Any],
                          
                          let results = jsondic["results"] as? [[String: Any]]
                    
                    else {
                        print("Error: Invalid JSON format")
                        self.delegate?.networkingDidFinishWithError()
                        return
                    }

                    // extract results
                    // use first to get first result
                    // this is a double list output
                    // a empty list a created for storing lists
                    var stockDataList = [stockTS]()
                    for result in results {
                        if let timestamp = result["t"] as? Int64,
                           let open = result["o"] as? Double,
                           let high = result["h"] as? Double,
                           let low = result["l"] as? Double,
                           let close = result["c"] as? Double,
                           let volume = result["v"] as? Int,
                           let numOfTrades = result["n"] as? Int {
                            
                                // Convert to Date
                                // Convert from milliseconds to seconds
                                let timestampSeconds = TimeInterval(timestamp) / 1000
                                let dateDate = Date(timeIntervalSince1970: timestampSeconds)
                                // To format the date into a readable string
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                let date = dateFormatter.string(from: dateDate)
                                
                                print("stockTS: \(stockName), \(date), \(open), \(high), \(low), \(close), \(volume), \(numOfTrades)")
                                let stockData = stockTS(stockID: stockName, date: date, open: open, high: high, low: low, close: close, volume: volume, numOfTrades: numOfTrades)
                                stockDataList.append(stockData)
                            
                            }
                        }
                    
                    // an instacne of stockTotalList, with inital values
                    let totalStockList = stockTotalList(results: stockDataList)

                    DispatchQueue.main.async {
                        self.delegate?.networkingDidFinishWithList(stockTotalList: totalStockList)
                    }
 
                } catch {
                    print("Decoding error: \(error)")
                    self.delegate?.networkingDidFinishWithError()
                }
                
                
                
            } else {
                print("Error, no data")
                self.delegate?.networkingDidFinishWithError()
            }
        }
        
        task?.resume()
    }
}

//
//  DataObjects.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//Hold the data structs that will fetch latest data from Google Sheets


import Foundation

//Main JSON return with nested values
struct OverviewData: Codable {
    var range: String?
    var majorDimension: String?
    var nestedData: [[String]]?
    
    enum CodingKeys: String, CodingKey {
        case range
        case majorDimension
        case nestedData = "values"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
                                                    CodingKeys.self)
        self.range = try valueContainer.decode(String.self, forKey: CodingKeys.range)
        self.majorDimension = try valueContainer.decode(String.self, forKey: CodingKeys.majorDimension)
        self.nestedData = try valueContainer.decode([[String]].self, forKey: CodingKeys.nestedData)
    }
}


//Fetches week from Google Sheet
func fetchWeek(completion: @escaping (String) -> Void) {
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/13iD11lGlla6gIpSouQgNIkvLidsdskv44Qp5gxHqmZE/values/Data!A2?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let weekUnpacked = dataDecoded.nestedData?.first?.first ?? "Loading..."
            completion(weekUnpacked)
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}


//Fetches undergrad positive count from Google Sheet
//DEPRECATED VERSION- Take last seven integers from fetchNumPositives1 + last seven integers from fetchNumPositives2 to get total undergrad positive count from prior week
//Above method for fall 2020. Current version is updated for new sheet with different math for spring 2021
func fetchNumPositives(completion: @escaping (String) -> Void) {
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/13iD11lGlla6gIpSouQgNIkvLidsdskv44Qp5gxHqmZE/values/Data!C2?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let numPositiveUnpacked = dataDecoded.nestedData?.first?.first  ?? "Loading..."
            completion(numPositiveUnpacked)
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}


//Fetches most recent positivity rate from Google Sheet
func fetchPositivityRate(completion: @escaping (String) -> Void) {
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/13iD11lGlla6gIpSouQgNIkvLidsdskv44Qp5gxHqmZE/values/Data!D2?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let rateStringUnpacked = dataDecoded.nestedData?.first?.first ?? "Loading"
            completion(rateStringUnpacked)
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}


//Fetches last week's positivity rate for comparison for trend
func fetchTrend(completion: @escaping (String) -> Void) {
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/13iD11lGlla6gIpSouQgNIkvLidsdskv44Qp5gxHqmZE/values/Data!E2?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let trendUnpacked = dataDecoded.nestedData?.first?.first ?? "Loading..."
            completion(trendUnpacked)
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}

//NOTE: when fetching in app, return [RESULT].nestedData and first item is the percentage

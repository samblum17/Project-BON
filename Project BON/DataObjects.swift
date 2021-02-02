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

//Fetches most recent positivity rate from Google Sheet
func fetchPositivityRate1(completion: @escaping (String) -> Void) {
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Spring%202021%20Weekly%20Rate!E:E?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let arraySlice = dataDecoded.nestedData?.suffix(1)
            let stringArray = arraySlice?.reduce([], +)
            let rateStringUnpacked = stringArray?.first
            completion(rateStringUnpacked ?? "Loading")
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}

//Fetches last week's positivity rate for comparison for trend
func fetchPositivityRate2(completion: @escaping (String) -> Void) {
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Spring%202021%20Weekly%20Rate!E:E?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let arraySlice = dataDecoded.nestedData?.suffix(2)
            let stringArray = arraySlice?.reduce([], +)
            let rateStringUnpacked = stringArray?.first
            completion(rateStringUnpacked ?? "Loading")
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}

//NOTE: when fetching in app, return [RESULT].nestedData and first item is the percentage



//Fetches undergrad positive count from Google Sheet
//DEPRECATED VERSION- Take last seven integers from fetchNumPositives1 + last seven integers from fetchNumPositives2 to get total undergrad positive count from prior week
//Above method for fall 2020. Current version is updated for new sheet with different math for spring 2021
func fetchNumPositives1(completion: @escaping (String) -> Void) {
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Spring%202021%20Weekly%20Rate!D:D?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let arraySlice = dataDecoded.nestedData?.suffix(1)
            let stringArray = arraySlice?.reduce([], +)
            let numPositivePacked = stringArray?.compactMap { String($0) }
            let numPositiveUnpacked = numPositivePacked?.first ?? "Loading..."
            completion(numPositiveUnpacked)
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}


//Fetches week from Google Sheet
func fetchWeek(completion: @escaping (String) -> Void) {
    
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Spring%202021%20Weekly%20Rate!A:A?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let arraySlice = dataDecoded.nestedData?.suffix(1)
            let decodedDate = arraySlice?.first?.first
            //reformat the date
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-mm-dd"
            let showDate = inputFormatter.date(from: decodedDate ?? "loading...")
            inputFormatter.dateFormat = "MMM dd, yyyy"
            let resultString = inputFormatter.string(from: showDate!)
            completion(resultString)
        } else {
            completion("Loading...")
        }
    }
    task.resume()
}



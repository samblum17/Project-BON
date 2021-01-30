//
//  DataObjects.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import Foundation

//File to hold the few data structs that will retrieve latest data from Google Sheets

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
    
    //Fetches positivity rate from Google Sheet
func fetchPositivityRate(completion: @escaping (OverviewData?) -> Void) {
        
        let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Positivity%20Rate!B2?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
        
        //Decodes JSON returned from API into active Park objects
        
        let task = URLSession.shared.dataTask(with: url) { (data,
                                                            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
                completion(dataDecoded)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    //NOTE: when fetching in app, return [RESULT].nestedData and first item is the percentage



//Fetches undergrad positive count from Google Sheet
//Take last seven integers from fetchNumPositives1 + last seven integers from fetchNumPositives2 to get total undergrad positive count from prior week
func fetchNumPositives1(completion: @escaping (Int?) -> Void) {
    
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Dashboard%20Charts!B:B?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    //Decodes JSON returned from API into active Park objects
    
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let arraySlice = dataDecoded.nestedData?.suffix(7)
            let stringArray = arraySlice?.reduce([], +)
            let intArray = stringArray?.compactMap { Int($0) }
            let firstSum = intArray?.reduce(0, +) ?? 0
            completion(firstSum)
        } else {
            completion(nil)
        }
    }
    task.resume()
}

func fetchNumPositives2(completion: @escaping (Int?) -> Void) {
    
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Dashboard%20Charts!C:C?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    //Decodes JSON returned from API into active Park objects
    
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            let arraySlice = dataDecoded.nestedData?.suffix(7)
            let stringArray = arraySlice?.reduce([], +)
            let intArray = stringArray?.compactMap { Int($0) }
            let secondSum = intArray?.reduce(0, +) ?? 0
            completion(secondSum)
        } else {
            completion(nil)
        }
    }
    task.resume()
}

//Fetches week from Google Sheet
func fetchWeek(completion: @escaping (OverviewData?) -> Void) {
    
    let url = URL(string:"https://sheets.googleapis.com/v4/spreadsheets/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/values/Positivity%20Rate!A2?key=AIzaSyC7YqhHjTh3thjtdDdGNPQvcvWXXTopeYA")!
    
    //Decodes JSON returned from API into active Park objects
    
    let task = URLSession.shared.dataTask(with: url) { (data,
                                                        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
           let dataDecoded = try? jsonDecoder.decode(OverviewData.self, from: data){
            completion(dataDecoded)
        } else {
            completion(nil)
        }
    }
    task.resume()
}



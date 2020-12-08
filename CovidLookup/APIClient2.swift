//
//  APIClient2.swift
//  CovidLookup
//
//  Created by Liubov Kaper  on 12/7/20.
//

import Foundation

struct APIClient2 {
    
    func fetchData(completion: @escaping(Result<[Summary], Error>) -> ()) {
        
        let endpoint = "https://api.covid19api.com/summary"
        
        guard let url = URL(string: endpoint) else {
            print("bad url")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return  completion(.failure(error))
            }
            
            if let jsonData = data {
                do {
                    let countries = try JSONDecoder().decode(SummaryWrapper.self, from: jsonData).countries
                    completion(.success(countries))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}

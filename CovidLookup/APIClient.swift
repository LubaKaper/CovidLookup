//
//  APIClient.swift
//  CovidLookup
//
//  Created by Liubov Kaper  on 12/3/20.
//

import Foundation

struct APIClient {
    
    // communicate retrieved data back to to the viewController
    //ways to do it:
    // closure, completion handler
    // notification center
    // delegation
    //combine
    
    // URLSession is an asynchronous API
    // sychronous code blocks UI
    // asynchronous does not block the main thread, performs request on a background thread
    // @escaping means function returns before closure returns
    func fetchCovidDAta(completion: @escaping (Result<[Summary], Error>) -> ()) {
        //1. endpointURL
        // 2. convert the string to an URL
        // 3. make request using URLSession
        
        let endpointURLString = "https://api.covid19api.com/summary"
        
        guard let url = URL(string: endpointURLString) else {
            print("bad url")
            return
        }
        
        // .shared is a singleton instance on URLSession, comes with basic configs needed for most requests
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
               return completion(.failure(error))
            }
            // TODO
            if let jsonData = data {
                // convert data to our swift model
                do {
                    let countries = try JSONDecoder().decode(SummaryWrapper.self, from: jsonData).countries
                    completion(.success(countries))
                } catch {
                    // decoding error
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
}

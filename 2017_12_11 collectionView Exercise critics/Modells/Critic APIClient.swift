//
//  Critic APIClient.swift
//  2017_12_11 collectionView Exercise critics
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct CriticAPIClient {
    private init() {}
    static let manager = CriticAPIClient()
    func getCritics(for searchTerm: String, completionHandler: @escaping ([Critic]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let apiKey =  "fc9bfdf440f74afc80ca0015d1604607"
        let urlStr = "https://api.nytimes.com/svc/movies/v2/critics/all.json?api-key=\(apiKey)"
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let results = try JSONDecoder().decode(CriticData.self, from: data)
                completionHandler(results.results)
            }
            catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}

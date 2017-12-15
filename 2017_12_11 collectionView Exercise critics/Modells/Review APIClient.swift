//
//  Review APIClient.swift
//  2017_12_11 collectionView Exercise critics
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct ReviewAPIClient {
    private init() {}
    static let manager = ReviewAPIClient()
    func getReviews(for searchTerm: String, completionHandler: @escaping ([Review]) -> Void, errorHandler: @escaping (AppError) -> Void) {
//        let apiKey =  "fc9bfdf440f74afc80ca0015d1604607"
        guard let searchTermModified = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else{return}
        let urlStr = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api_key=fc9bfdf440f74afc80ca0015d1604607&reviewer=\(searchTermModified)"
        print(urlStr)
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            print(urlStr)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                
                let results = try JSONDecoder().decode(ReviewData.self, from: data)
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

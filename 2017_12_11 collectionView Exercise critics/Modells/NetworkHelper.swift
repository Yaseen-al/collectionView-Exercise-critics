//
//  NetworkHelper.swift
//  2017_12_11 collectionView Exercise critics
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case other(rawError: Error)
    case notAnImage
    case codingError(rawError: Error)
    case badData
    case urlError(rawError: Error)
}
class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    //notice that we can give a feedaback on the no data by using the errorHandler
                    errorHandler(AppError.noDataReceived)
                    return
                }
                //check for the error 200
                guard let response = response as? HTTPURLResponse, response.statusCode != 404 else{
                    errorHandler(AppError.badStatusCode)
                    return
                }
                if let error = error {
                    let error = error as NSError
                    //check for no internet connection
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
                        errorHandler(AppError.noInternetConnection)
                    }else{
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}





class Dog {
    private init() {}
    static let origin = "origins"
    static let age = 20
    static let theManager = Dog()
    func getNames() {
        print("hi Magie")
    }
}
//Dog.theManager.getNames()

//// the instance
//let myDog = Dog(name: "sam")
//myDog.name
////the class itself
//Dog.origin







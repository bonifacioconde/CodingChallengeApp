//
//  API.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 28/11/2019.
//  Copyright © 2019 Bonz Condz. All rights reserved.
//

import Foundation
import Result
import Moya

typealias NetworkFailureBlock = ((PresentableError?) -> ())

/// Class responsible of processing and validating the network responses
class BaseNetwork {
    func processResponse<T>(result: Result<Moya.Response, MoyaError>, success: ((T) -> ())?, failure: NetworkFailureBlock?) where T: Codable {
        switch result {
        case let .success(response):
            self.validate(
                response,
                success: { () in
                    do {
                        let data = try response.map(T.self)
                        success?(data)
                    }
                    catch let error {
                        failure?(PresentableError(message: error.localizedDescription))
                    }
                },
                error: { (error) in
                    failure?(error)
                }
            )

        case let .failure(error):
            failure?(PresentableError(message: error.localizedDescription))
        }
    }

    func processResponse(result: Result<Moya.Response, MoyaError>, success: (() -> ())?, failure: NetworkFailureBlock?) {
        switch result {
        case let .success(response):
            self.validate(
                response,
                success: { () in
                    success?()
                },
                error: { (error) in
                    failure?(error)
                }
            )

        case let .failure(error):
            failure?(PresentableError(message: error.localizedDescription))
        }
    }

    func validate(_ response: Response, success: (() -> ()), error: ((PresentableError?) -> ())) {
        if (response.statusCode >= 200) && (response.statusCode < 300) {
            success()
        } else {
            var presentableError: PresentableError? = nil
            do {
                //TO DO: Handle error response and model
                
            }
            catch {
                // Do Nothing
                presentableError = PresentableError(message: "Please contact Administrator")
            }
            
            error(presentableError)
        }
    }
}


extension Decodable {
    static func fromJSON<T:Decodable>(_ fileName: String, fileExtension: String="json", bundle: Bundle = .main) throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorResourceUnavailable)
        }

        let data = try Data(contentsOf: url)

        return try JSONDecoder().decode(T.self, from: data)
    }
}

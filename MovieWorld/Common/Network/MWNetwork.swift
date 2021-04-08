//
//  MWNetwork.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit
import Alamofire

typealias MWNet = MWNetwork

class MWNetwork {
    static let sh = MWNetwork()

    private lazy var session = URLSession(configuration: .default)

    private let sessionManager: Alamofire.Session

    // Alamofire

    private let baseUrl: String = "https://api.themoviedb.org/3/"
    private let imageURL: String = "https://image.tmdb.org/t/p/w200/"

    /// for authorization

    private let apiKey: String = "79d5894567be5b76ab7434fc12879584"


    private lazy var parameters: [String: String] = [
        "api_key": self.apiKey
    ]

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        self.sessionManager = Session.default
    }

    // MARK: - UrlSession

    func requestImage(posterPath: String,
                      completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {

        guard let url = URL(urlString: self.imageURL,
                            path: posterPath) else {

            completion(nil)
            return nil
        }

        let request = URLRequest(url: url)
        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            } else if let data = data,
                      let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...300:
                    DispatchQueue.main.async {
                        completion(UIImage(data: data))
                    }
                default:
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }

        dataTask.resume()

        return dataTask
    }

    func request<T: Decodable>(urlPath: String,
                               parameters: [String: String]? = nil,
                               okHandler: @escaping (T) -> Void,
                               errorHandler: @escaping () -> Void) {
        var urlParameters = self.parameters

        parameters?.forEach {
            urlParameters[$0.key] = $0.value
        }

        guard let url = URL(urlString: self.baseUrl,
                            path: urlPath,
                            params: urlParameters) else {
            return
        }

        let request = URLRequest(url: url)

        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                Swift.debugPrint(error.localizedDescription)
                DispatchQueue.main.async {
                    errorHandler()
                }
            } else if let data = data,
                      let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...300:
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            okHandler(model)
                        }
                    } catch let error {
                        Swift.debugPrint(error.localizedDescription)
                        DispatchQueue.main.async {
                            errorHandler()
                        }
                    }
                case 401, 404:
                    Swift.debugPrint(String(decoding: data, as: UTF8.self))
                    DispatchQueue.main.async {
                        errorHandler()
                    }
                default:
                    DispatchQueue.main.async {
                        errorHandler()

                    }
                }
            }
        }

        dataTask.resume()
    }

    func requestAlamofire<T: Decodable>(urlPath: String,
                                        parameters: [String: String]? = nil,
                                        okHandler: @escaping (T) -> Void,
                                        errorHandler: @escaping (MWNetError) -> Void) {
        var urlParameters = self.parameters
        if let parameters = parameters {
            parameters.forEach { urlParameters[$0.key] = $0.value }
        }

        guard let url = URL(urlString: self.baseUrl,
                            path: urlPath,
                            params: urlParameters) else {

            errorHandler(MWNetError.incorrectUrl)
            return
        }

        self.sessionManager
            .request(url)
            .responseJSON { (response) in
                if let error = response.error {
                    errorHandler(.networkError(error: error))
                    return
                } else if let data = response.data,
                          let httpResponse = response.response {
                    switch httpResponse.statusCode {
                    case 200...300:
                        do {
                            let model = try JSONDecoder().decode(T.self, from: data)
                            okHandler(model)
                        } catch let error {
                            errorHandler(.parsingError(error: error))
                        }
                    case 401, 404:
                        // TODO: - write error response model handling
                        Swift.debugPrint(String(decoding: data, as: UTF8.self))
                        break
                    default:
                        errorHandler(.serverError(statusCode: httpResponse.statusCode))
                    }
                } else {
                    errorHandler(.unknown)
                }
            }
    }
}

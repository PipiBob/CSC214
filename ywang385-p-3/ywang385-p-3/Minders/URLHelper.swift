//
//  URLHelper.swift
//  Minders
//
//  Created by Wang, Yun on 12/5/22.
//
import Foundation
class URLHelper {

    let BorUrl = "https://api.chucknorris.io/"
    private func fmpUrl(parameters: [String: String]) -> URL? {
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        guard var components = URLComponents(string: BorUrl + "/jokes/random") else { return nil }
        components.queryItems = queryItems
        return components.url
    }
    func fetchResult(params: [String: String]) async throws -> element {
        if let url = fmpUrl(parameters: params) {
            let request = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError.BadURL }
            let decoder = JSONDecoder()
            print("start decode");
            let result1 = try decoder.decode(element.self, from: data)
            print("end decode");
            return result1
        }
        return element()}}

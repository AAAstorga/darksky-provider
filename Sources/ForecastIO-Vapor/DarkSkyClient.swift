//
//  DarkSkyClient.swift
//  ForecastIO
//
//  Created by Satyam Ghodasara on 7/22/15.
//  Copyright (c) 2015 Satyam. All rights reserved.
//

import Foundation
import HTTP
import Service

/// A class to interact with the Dark Sky API.
open class DarkSkyClient : Service {
    
    private let apiKey: String
    private let session = URLSession.shared
    private static let darkSkyURL = "https://api.darksky.net/forecast/"
    private let hostname = "api.darksky.net"
    
    /// Units in which the `Forecast` response will be provided. US is the default if no units are specified as per the Dark Sky API docs.
    open var units: Units?
    
    /// Language in which the `Forecast` response's `DataBlock` and `DataPoint`'s `summary` properties will be provided. English is the default if no language is specified as per the Dark Sky API docs.
    open var language: Language?
    
    /// Creates a new `DarkSkyClient` to interact with the Dark Sky API.
    ///
    /// - parameter key: Your Dark Sky API key.
    ///
    /// - returns: A new `DarkSkyClient` configured to interact with the Dark Sky API with your API key.
    public init(apiKey key: String) {
        apiKey = key
    }

    open func getWeather(latitude lat: Double, longitude lon: Double, time: Date?, excludeFields: [Forecast.Field] = [], extendHourly: Bool = false, worker: Worker) throws -> Future<Forecast> {

        let url = buildForecastURL(latitude: lat, longitude: lon, time: time, extendHourly: extendHourly, excludeFields: excludeFields)

        let forecast: Future<Forecast> = HTTPClient.connect(scheme: .https, hostname: hostname, on: worker).flatMap(to: HTTPResponse.self) { client in
            let httpReq = HTTPRequest(method: .GET, url: url)
            return client.send(httpReq)
            }.flatMap(to: Data.self) { res in
                return res.body.consumeData(on: worker)
            }.map(to: Forecast.self) { data in
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .secondsSince1970
                return try jsonDecoder.decode(Forecast.self, from: data)
        }
        return forecast
    }

    private func buildForecastURL(latitude lat: Double, longitude lon: Double, time: Date?, extendHourly: Bool, excludeFields: [Forecast.Field]) -> URL {
        //  Build URL path
        var urlString = DarkSkyClient.darkSkyURL + apiKey + "/\(lat),\(lon)"
        if let time = time {
            let timeString = String(format: "%.0f", time.timeIntervalSince1970)
            urlString.append(",\(timeString)")
        }

        //  Build URL query parameters
        var urlBuilder = URLComponents(string: urlString)!
        var queryItems: [URLQueryItem] = []
        if let units = self.units {
            queryItems.append(URLQueryItem(name: "units", value: units.rawValue))
        }
        if let language = self.language {
            queryItems.append(URLQueryItem(name: "lang", value: language.rawValue))
        }
        if extendHourly {
            queryItems.append(URLQueryItem(name: "extend", value: "hourly"))
        }
        if !excludeFields.isEmpty {
            var excludeFieldsString = ""
            for field in excludeFields {
                if excludeFieldsString != "" {
                    excludeFieldsString.append(",")
                }
                excludeFieldsString.append("\(field.rawValue)")
            }
            queryItems.append(URLQueryItem(name: "exclude", value: excludeFieldsString))
        }
        urlBuilder.queryItems = queryItems

        return urlBuilder.url!
    }
}

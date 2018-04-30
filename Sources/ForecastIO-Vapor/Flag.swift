//
//  Flag.swift
//  ForecastIO
//
//  Created by Satyam Ghodasara on 7/19/15.
//  Copyright (c) 2015 Satyam. All rights reserved.
//

import Foundation

/// A class that contains various metadata information related to a `Forecast` request.
public struct Flag: Codable {
    
    /// The presence of this property indicates that the Dark Sky data source supports the `Forecast`'s location, but a temporary error (such as a radar station being down for maintenance) has made the data unavailable.
    public let darkSkyUnavailable: Bool?
    
    /// Contains the IDs for each radar station used in servicing the `Forecast` request.
    public let darkSkyStations: [String]?
    
    /// Contains the IDs for each `DataPoint` station used in servicing this request.
    public let dataPointStations: [String]?
    
    /// Contains the IDs for each ISD station used in servicing this request.
    public let isdStations: [String]?
    
    /// Contains the IDs for each LAMP station used in servicing this request.
    public let lampStations: [String]?
    
    /// Contains the IDs for each METAR station used in servicing this request.
    public let metarStations: [String]?
    
    /// The presence of this property indicates that data from api.met.no was used to facilitate this request (as per their license agreement).
    public let metnoLicense: Bool?
    
    /// Contains the IDs for each data station used in servicing this request.
    public let sources: [String]
    
    /// The presence of this property indicates which units were used for the data in this request. `US` units are default.
    public let units: Units
    
    /// Temperature's in The Sentence and app appear as apparent temperatures ("feels like") by defult. 'false' will make all values actual temperatures.
    public var feelsLike: Bool? = true
}

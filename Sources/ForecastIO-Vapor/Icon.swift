//
//  DataPointIcon.swift
//  ForecastIO
//
//  Created by Satyam Ghodasara on 7/18/15.
//  Copyright (c) 2015 Satyam. All rights reserved.
//

import Foundation

/// Types of weather conditions. Additional values may be defined in the future, so be sure to use a default.
public enum Icon: String, Codable {
    
    /// A clear day.
    case clearDay = "clear-day"
    
    /// A clear night.
    case clearNight = "clear-night"
    
    /// A rainy day or night.
    case rain = "rain"
    
    /// A snowy day or night.
    case snow = "snow"
    
    /// A sleety day or night.
    case sleet = "sleet"
    
    /// A windy day or night.
    case wind = "wind"
    
    /// A foggy day or night.
    case fog = "fog"
    
    /// A cloudy day or night.
    case cloudy = "cloudy"
    
    /// A partly cloudy day.
    case partlyCloudyDay = "partly-cloudy-day"
    
    /// A partly cloudy night.
    case partlyCloudyNight = "partly-cloudy-night"
    
    /// No icon.
    case none = ""
    
    /** Returns desired string for Description Label based on enum value */
    public func iconFormat() -> String {
        let text = self.rawValue
        switch text {
        case "clear-day", "clear-night": return "CLEAR"
        case "rain": return "RAIN"
        case "snow": return "SNOW"
        case "sleet": return "SLEET"
        case "wind": return "WINDY"
        case "fog": return "FOGGY"
        case "cloudy": return "CLOUDY"
        case "partly-cloudy-day", "partly-cloudy-night": return "PARTLY CLOUDY"
        default: return "ERROR"
        }    
    }
    
}

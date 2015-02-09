//
//  ColorHelper.swift
//  ViewDescriptor
//
//  Created by Ivan Orlov on 13/10/14.
//  Copyright (c) 2014 Conmio. All rights reserved.
//

import Foundation

class ColorHelper {
    class func getColor(name: String) -> String {
        switch name {
        case "silver":
            return "#C0C0C0"
        case "gray":
            return "#808080"
        case "white":
            return "#ffffff"
        case "black":
            return "#000000"
        case "red":
            return "#FF0000"
        case "cyan":
            return "#00FFFF"
        case "maroon":
            return "#800000"
        case "yellow":
            return "#FFFF00"
        case "olive":
            return "#808000"
        case "lime":
            return "#00FF00"
        case "green":
            return "#008000"
        case "aqua":
            return "#00FFFF"
        case "teal":
            return "#008080"
        case "blue":
            return "#0000FF"
        case "pink":
            return "#FFC0CB"
        case "navy":
            return "#000080"
        case "fuchsia":
            return "#FF00FF"
        case "purple":
            return "#800080"
        default:
            return name;
        }
    }
}
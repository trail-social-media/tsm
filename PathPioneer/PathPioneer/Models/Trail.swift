//
//  Trail.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import Foundation
import ParseSwift

struct Trail: ParseObject {
    // These are required by ParseObject
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // Custom properties.
    var user: User?
    var imageFile: ParseFile?
    var trailName: String?
    var trailDesc: String?
    var latitudes: [Double]?
    var longitudes: [Double]?
}

/*
extension Trail {
    static var mockTrails: [Trail] = [
        Trail(trailName: "Mountain Hike", trailDesc: "An exhausting hike up the nearby mountains", latitudes: [], longitudes: []),
        Trail(trailName: "Nature Trail", trailDesc: "Beautiful scenery with a modest hiking trail", latitudes: [], longitudes: []),
        Trail(trailName: "River Trail", trailDesc: "A trail that follows along the river", latitudes: [], longitudes: [])
        ]
}
*/

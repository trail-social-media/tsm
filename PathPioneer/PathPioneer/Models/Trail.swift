//
//  Trail.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import Foundation

struct Trail {
    let trailName: String
    let trailDesc: String
}

extension Trail {
    static var mockTrails: [Trail] = [
        Trail(trailName: "Mountain Hike", trailDesc: "An exhausting hike up the nearby mountains"),
        Trail(trailName: "Nature Trail", trailDesc: "Beautiful scenery with a modest hiking trail"),
        Trail(trailName: "River Trail", trailDesc: "A trail that follows along the river")
        ]
}

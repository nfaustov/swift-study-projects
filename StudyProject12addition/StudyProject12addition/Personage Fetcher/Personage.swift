//
//  Personage.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 14.01.2021.
//

import Foundation

class Personage: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: URL
}

struct Origin: Decodable {
    let name: String
}

struct Location: Decodable {
    let name: String
}

//
//  PesonagesPage.swift
//  StudyProject12addition
//
//  Created by Nikolai Faustov on 24.01.2021.
//

import Foundation

class PersonagesPage: Decodable {
    let results: [Personage]
}

struct Pagination: Decodable {
    let info: Info
}

struct Info: Decodable {
    let count: Int
    let pages: Int
}

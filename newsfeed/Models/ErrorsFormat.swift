//
//  ErrorsFormat.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 08.02.2021.
//

import Foundation


struct ErrorsFormat: Codable {
    let status: String
    let code: String
    let message: String
}

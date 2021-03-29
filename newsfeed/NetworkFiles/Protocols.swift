//
//  Protocols.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 12.02.2021.
//

import Foundation

protocol CreatorQueryItemsProtocol {

    func createdQueryItemsFromParameters() -> [URLQueryItem]
}

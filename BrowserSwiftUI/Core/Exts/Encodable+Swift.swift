//
//  Encodable+Swift.swift
//  BrowserSwiftUI
//
//  Created by Mwai Banda on 4/2/22.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}

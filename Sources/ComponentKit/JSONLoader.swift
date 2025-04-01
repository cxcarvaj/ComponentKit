//
//  JSONLoader.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import Foundation

public protocol JSONLoader {}

extension JSONLoader {
    public func load<T>(url: URL, type: T.Type) throws -> T where T: Codable {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
    public func save<T>(url: URL, data: T) throws where T: Codable {
        let jsonData = try JSONEncoder().encode(data)
        //.atomic es necesario para evitar data races al momento de escritura en el archivo
        try jsonData.write(to: url, options: [.atomic, .completeFileProtection])
    }
}

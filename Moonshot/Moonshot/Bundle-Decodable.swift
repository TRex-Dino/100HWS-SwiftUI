//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Dmitry on 09.06.2021.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formater = DateFormatter()
        formater.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formater)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}

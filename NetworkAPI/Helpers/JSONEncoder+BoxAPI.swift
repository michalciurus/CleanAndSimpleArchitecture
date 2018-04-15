//  Created by Michal Ciurus

import Foundation

extension JSONEncoder {
    
    /// - Returns: Encoder with support for Box API dates
    static func boxEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.boxDateFormatter())
        return encoder
    }
}

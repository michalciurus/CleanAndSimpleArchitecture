//  Created by Michal Ciurus

import Foundation

extension JSONDecoder {
    
    /// - Returns: Decoder with support for Box API dates
    static func boxDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.boxDateFormatter())
        return decoder
    }
}

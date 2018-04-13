//  Created by Michal Ciurus

import Foundation

extension JSONDecoder {
    static func boxDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.boxDateFormatter())
        return decoder
    }
}

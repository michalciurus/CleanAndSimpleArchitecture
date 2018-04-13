//  Created by Michal Ciurus

import Foundation

extension JSONEncoder {
    static func boxEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.boxDateFormatter())
        return encoder
    }
}

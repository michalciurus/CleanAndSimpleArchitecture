//  Created by Michal Ciurus

import Foundation

extension DateFormatter {
    static func boxDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}

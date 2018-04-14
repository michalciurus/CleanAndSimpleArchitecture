//  Created by Michal Ciurus

import Foundation

extension DateFormatter {
    static func UIFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}

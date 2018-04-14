//  Created by Michal Ciurus

import Foundation

public protocol EmitsError {
    var errorEvent: EventObservable<String> { get }
}

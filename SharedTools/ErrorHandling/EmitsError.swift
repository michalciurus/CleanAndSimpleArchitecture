//  Created by Michal Ciurus

import Foundation

public protocol EmitsError {
    
    var errorEvent: PresenterEventObservable<String> { get }
    
}

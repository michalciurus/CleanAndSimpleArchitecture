//  Created by Michal Ciurus

import Foundation

/// Observers are informed on the main queue
final public class PresenterEventObservable<T>: EventObservable<T> {
    
    public override func fireEvent(with value: T?) {
        DispatchQueue.main.async {
            super.fireEvent(with: value)
        }
    }
    
}

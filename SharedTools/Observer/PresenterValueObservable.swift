//  Created by Michal Ciurus

import Foundation

/// Observers are informed on the main queue
final public class PresenterValueObservable<T>: ValueObservable<T> {
    
    override func fireObservers() {
        DispatchQueue.main.async {
            super.fireObservers()
        }
    }
    
}

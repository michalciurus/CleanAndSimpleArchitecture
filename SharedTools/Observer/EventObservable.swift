//  Created by Michal Ciurus

import Foundation


/// Observable that informs its observers when a new event is fired
public class EventObservable<T>: Observable<T> {
    
    /// Observe just for event without value
    ///
    /// - Parameter closure: observer closure
    public func observe(_ closure: @escaping () -> Void) {
        observe { _ in
            closure()
        }
    }

    public func fireEvent(with value: T?) {
        for observer in observers {
            observer(value)
        }
    }
    
    /// Fires event with nil value
    public func fireEvent() {
        fireEvent(with: nil)
    }

}

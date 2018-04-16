//  Created by Michal Ciurus

import Foundation


/// Observable that informs its observers when value is changed
public class ValueObservable<T>: Observable<T> {

    public var value: T? {
        didSet {
            fireObservers()
        }
    }
    
    public init(value: T?) {
        self.value = value
    }
    
    internal func fireObservers() {
        for observer in observers {
            observer(value)
        }
    }
    
}

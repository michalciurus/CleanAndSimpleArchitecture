//  Created by Michal Ciurus

import Foundation


/// Observable that informs its observers when value is changed
public class ValueObservable<T>: Observable<T> {

    public var value: T? {
        didSet {
            for observer in observers {
                observer(value)
            }
        }
    }
    
    public init(value: T?) {
        self.value = value
    }
}

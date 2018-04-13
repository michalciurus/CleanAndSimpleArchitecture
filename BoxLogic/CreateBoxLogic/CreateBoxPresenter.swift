//  Created by Michal Ciurus

import SharedTools

public class CreateBoxPresenter: EmitsError {
    public var errorEvent = EventObservable<String>()
    public let isCreating = ValueObservable<Bool>(value: false)
}

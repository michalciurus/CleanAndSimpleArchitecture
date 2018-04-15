//  Created by Michal Ciurus

import SharedTools

final public class CreateBoxPresenter: EmitsError {
    public var errorEvent = PresenterEventObservable<String>()
    public let isCreating = PresenterValueObservable<Bool>(value: false)
}

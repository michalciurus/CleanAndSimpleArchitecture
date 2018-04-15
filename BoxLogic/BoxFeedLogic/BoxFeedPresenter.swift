//  Created by Michal Ciurus

import Foundation
import NetworkAPI
import SharedTools

fileprivate enum BoxFeedPresenterConstants {
    static let datePrefix = "updated at:"
}

public struct BoxPresenter {
    public let descriptionLabel: String
    public let dateLabel: String?
    public let identifier: Int
}

public class BoxFeedPresenter: EmitsError {
    
    fileprivate typealias C = BoxFeedPresenterConstants
    
    //MARK: Public Properties
    
    public var boxes = PresenterValueObservable<[BoxPresenter]>(value: [])
    public var isLoading = PresenterValueObservable<Bool>(value: false)
    public var errorEvent = PresenterEventObservable<String>()
    
    //MARK: Internal Methods
    
    internal func add(boxes newBoxes: [BoxDocument], atTheTop: Bool = false) {
        let boxesPresenters = newBoxes.map { (box) -> BoxPresenter in
            guard let date = box.updatedAt, let key = box.key,
                let identifier = box.productId, let scope = box.scope else { fatalError("Box missing values") }
            
            var dateString = DateFormatter.UIFormatter().string(from: date)
            dateString = "\(C.datePrefix) \(dateString)"
            let description = "\(key) (\(scope.rawValue))"
            return BoxPresenter(descriptionLabel: description, dateLabel: dateString, identifier: identifier)
        }
        
        if atTheTop {
            boxes.value?.insert(contentsOf: boxesPresenters, at: 0)
        } else {
            boxes.value?.append(contentsOf: boxesPresenters)
        }
    }
    
    internal func deleteBox(at index: Int) {
        var newBoxes = boxes.value
        newBoxes?.remove(at: index)
        boxes.value = newBoxes
    }
    
    internal func removeAllBoxes() {
        boxes.value = []
    }
    
}

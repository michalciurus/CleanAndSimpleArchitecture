//  Created by Michal Ciurus

import Foundation
import NetworkAPI
import SharedTools

public struct BoxPresenter {
    public let descriptionLabel: String
    public let dateLabel: String?
    public let identifier: Int
}

public class BoxFeedPresenter {
    
    public var boxes = ValueObservable<[BoxPresenter]>(value: [])
    public var isLoading = ValueObservable<Bool>(value: false)
    
    internal func add(boxes newBoxes: [BoxDocument], atTheTop: Bool = false) {
        let boxesPresenters = newBoxes.map { (box) -> BoxPresenter in
            var dateString = DateFormatter.UIFormatter().string(from: box.updatedAt!)
            dateString = "updated at: \(dateString)"
            let description = "\(box.key!) (\(box.scope!.rawValue))"
            return BoxPresenter(descriptionLabel: description, dateLabel: dateString, identifier: box.productId!)
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
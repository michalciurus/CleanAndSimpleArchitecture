//  Created by Michal Ciurus

import UIKit
import BoxLogic

final class BoxFeedViewCell: UITableViewCell {
    
    static let identifier = "BoxFeedViewCell"
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func configure(with presenter: BoxPresenter) {
        descriptionLabel.text = presenter.descriptionLabel
        dateLabel.text = presenter.dateLabel
    }
}

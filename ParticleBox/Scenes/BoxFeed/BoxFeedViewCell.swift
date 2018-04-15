//  Created by Michal Ciurus

import UIKit
import BoxLogic

final class BoxFeedViewCell: UITableViewCell {
    
    static let identifier = "BoxFeedViewCell"
    
    //MARK: Private Properties
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    //MARK: Public Methods
    
    func configure(with presenter: BoxPresenter) {
        descriptionLabel.text = presenter.descriptionLabel
        dateLabel.text = presenter.dateLabel
    }
}

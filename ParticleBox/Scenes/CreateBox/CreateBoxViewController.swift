//  Created by Michal Ciurus

import UIKit
import BoxLogic

final class CreateBoxViewController: UIViewController {
    
    //MARK: Private Properties
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.isHidden = true
        }
    }
    
    @IBOutlet private weak var keyText: UITextField! {
        didSet {
            keyText.becomeFirstResponder()
        }
    }
    
    @IBOutlet private weak var scopeControl: UISegmentedControl!
    @IBOutlet private weak var createBoxButton: UIButton!
    
    //MARK: Public Properties
    
    let interactor = CreateBoxInteractor()
    
    //MARK: Public Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Box"
        textChanged(keyText)
        setupObservers()
        subscribeTo(errorEmitter: interactor.presenter)
    }
}

private extension CreateBoxViewController {
    
    @IBAction func didTapCreateBox(_ sender: Any) {
        assert(keyText.text != nil && keyText.text!.count > 0)
        if let text = keyText.text {
            interactor.createBox(key:text , scope: scopeControl.selectedSegmentIndex)
        }
    }
    
    @IBAction func textChanged(_ sender: Any) {
        let textCount = keyText.text?.count ?? 0
        let enabled = textCount > 0
        createBoxButton.isEnabled = enabled
        createBoxButton.alpha = enabled ? 1 : 0.5
    }
    
    func setupObservers() {
        interactor.presenter.isCreating.observe { [weak self] isCreating in
            if let isCreating = isCreating {
                self?.spinner.isHidden = !isCreating
            }
        }
    }
}

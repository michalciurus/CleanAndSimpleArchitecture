//  Created by Michal Ciurus

import UIKit
import BoxLogic

class CreateBoxViewController: UIViewController {
    
    let interactor = CreateBoxInteractor()
    
    @IBOutlet private weak var keyText: UITextField! {
        didSet {
            keyText.becomeFirstResponder()
        }
    }
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.isHidden = true
        }
    }
    
    @IBOutlet private weak var scopeControl: UISegmentedControl!
    @IBOutlet private weak var createBoxButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Box"
        textChanged(keyText)
        setupObservers()
    }
    
    @IBAction func didTapCreateBox(_ sender: Any) {
        interactor.createBox(key: keyText.text!, scope: scopeControl.selectedSegmentIndex)
    }
    
    @IBAction func textChanged(_ sender: Any) {
        let textCount = keyText.text?.count ?? 0
        let enabled = textCount > 0
        createBoxButton.isEnabled = enabled
        createBoxButton.alpha = enabled ? 1 : 0.5
    }
    
}

private extension CreateBoxViewController {
    func setupObservers() {
        interactor.presenter.isCreating.observe { [weak self] isCreating in
            if let isCreating = isCreating {
                self?.spinner.isHidden = !isCreating
            }
        }
    }
}

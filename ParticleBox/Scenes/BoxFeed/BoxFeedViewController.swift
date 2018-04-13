//  Created by Michal Ciurus

import UIKit
import BoxLogic
import SharedTools

class BoxFeedViewController: UITableViewController {
    
    let interactor = BoxFeedInteractor()
    @IBOutlet private weak var loadMoreButton: UIButton!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    let createBoxEvent = EventObservable<Void>()
    
    @IBAction func didTapLoadMore(_ sender: Any) {
        interactor.fetchMoreBoxes()
    }
    
    override func viewDidLoad() {
        title = "Boxes"
        
        setupObservers()
        addCreateBoxButton()
        interactor.fetchInitialBoxes()
    }
    
    // MARK: Table View Delegate
    
    override func viewDidAppear(_ animated: Bool) {
        addCreateBoxButton()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.presenter.boxes.value?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxFeedViewCell", for: indexPath) as! BoxFeedViewCell
        cell.configure(with: interactor.presenter.boxes.value![indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: Add delete animation
            interactor.deleteBox(at: indexPath.row)
        }
    }
}

private extension BoxFeedViewController {
    
    func setupObservers() {
        interactor.presenter.boxes.observe { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        interactor.presenter.isLoading.observe { [weak self] isLoading in
            if let loading = isLoading {
                self?.loadingIndicator.isHidden = !loading
                UIView.animate(withDuration: 0.1) {
                    self?.loadMoreButton.alpha = loading ? 0 : 1
                }
            }
        }
    }
    
    @objc func didTapCreate() {
        createBoxEvent.fireEvent()
    }
    
    func addCreateBoxButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "➕", style: .plain, target: self, action: #selector(didTapCreate))
    }
    
}

//  Created by Michal Ciurus

import UIKit
import BoxLogic
import SharedTools

class BoxFeedViewController: UITableViewController {
    
    let interactor = BoxFeedInteractor()
    @IBOutlet private weak var loadMoreButton: UIButton!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    var shouldRunDeleteAnimation = false
    
    let createBoxEvent = EventObservable<Void>()
    
    @IBAction func didTapLoadMore(_ sender: Any) {
        interactor.fetchMoreBoxes()
    }
    
    override func viewDidLoad() {
        title = "Boxes"
        
        setupObservers()
        addCreateBoxButton()
        interactor.fetchInitialBoxes()
        subscribeTo(errorEmitter: interactor.presenter)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc func pullToRefresh() {
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
            shouldRunDeleteAnimation = true
            interactor.deleteBox(at: indexPath.row) { [weak self] success in
                if success {
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                    self?.shouldRunDeleteAnimation = false
                }
            }
            
        }
    }
}

private extension BoxFeedViewController {
    
    func setupObservers() {
        interactor.presenter.boxes.observe { [weak self] _ in
            guard self?.shouldRunDeleteAnimation == false else { return }
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
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

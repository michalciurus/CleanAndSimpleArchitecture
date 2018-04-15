//  Created by Michal Ciurus

import UIKit
import BoxLogic
import SharedTools

class BoxFeedViewController: UITableViewController {
    
    let interactor = BoxFeedInteractor()
    var shouldRunDeleteAnimation = false
    let createBoxEvent = EventObservable<Void>()
    var dataSource: TableViewDataSource<BoxFeedViewCell, BoxPresenter>?
    
    @IBOutlet private weak var loadMoreButton: UIButton!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        title = "Boxes"
        
        setupObservers()
        setupDataSource()
        addCreateBoxButton()
        interactor.fetchInitialBoxes()
        subscribeTo(errorEmitter: interactor.presenter)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addCreateBoxButton()
    }
    
    @objc func pullToRefresh() {
        interactor.fetchInitialBoxes()
    }
    
    @IBAction func didTapLoadMore(_ sender: Any) {
        interactor.fetchMoreBoxes()
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
    
    func setupDataSource() {
        self.dataSource = TableViewDataSource<BoxFeedViewCell, BoxPresenter>(cellIdentifier: "BoxFeedViewCell", observable: interactor.presenter.boxes) { (cell, presenter) in
            cell.configure(with: presenter)
            return cell
        }
        
        self.dataSource?.didDelete.observe { [weak self] (value) in
            guard let value = value else { return }
            self?.shouldRunDeleteAnimation = true
            self?.interactor.deleteBox(at: value.row) { [weak self] success in
                if success {
                    self?.tableView.deleteRows(at: [value], with: .automatic)
                    self?.shouldRunDeleteAnimation = false
                }
            }
        }
        
        tableView.dataSource = dataSource
    }
    
    @objc func didTapCreate() {
        createBoxEvent.fireEvent()
    }
    
    func addCreateBoxButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "➕", style: .plain, target: self, action: #selector(didTapCreate))
    }
    
}

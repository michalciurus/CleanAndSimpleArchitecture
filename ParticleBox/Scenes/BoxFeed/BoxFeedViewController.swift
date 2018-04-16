//  Created by Michal Ciurus

import UIKit
import BoxLogic
import SharedTools

final class BoxFeedViewController: UITableViewController {

    //MARK: Private Properties
    
    private var shouldRunDeleteAnimation = false
    private var dataSource: TableViewDataSource<BoxFeedViewCell, BoxPresenter>?
    
    @IBOutlet private weak var loadMoreButton: UIButton!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    //MARK: Public Properties
    
    var interactor: BoxFeedInteractor!
    let createBoxEvent = EventObservable<Void>()
    
    //MARK: Public Methods
    
    override func viewDidLoad() {
        assertDependency()        
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
}

private extension BoxFeedViewController {
    
    @objc func pullToRefresh() {
        interactor.fetchInitialBoxes()
    }
    
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
        
        self.dataSource = TableViewDataSource<BoxFeedViewCell, BoxPresenter>(cellIdentifier: BoxFeedViewCell.identifier, observable: interactor.presenter.boxes) { (cell, presenter) in
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
    
    @IBAction func didTapLoadMore(_ sender: Any) {
        interactor.fetchMoreBoxes()
    }
    
    func addCreateBoxButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "➕", style: .plain, target: self, action: #selector(didTapCreate))
    }
}

extension BoxFeedViewController: InjectableInteractor {
    func inject(_ interactor: BoxFeedInteractor) {
        self.interactor = interactor
    }
}

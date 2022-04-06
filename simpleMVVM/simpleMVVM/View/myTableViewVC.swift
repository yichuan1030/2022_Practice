//
//  myTableViewController.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/29.
//

import Foundation
import UIKit
import SwiftUI

class myTableViewVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var viewModel : myTableViewVM = myTableViewVM()
    var tableView : UITableView?
    var indicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initVM()
        initVC()
    }
    
    override func viewDidLayoutSubviews() {
        indicator?.center = tableView?.center ?? self.view.center
        tableView?.frame = self.view.frame
    }
    
    private func initVC() {
        createTableView()
        createIndicator()
    }
    
    private func initVM() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] (msg) in
            DispatchQueue.main.async {
                self?.showAlert(msg: msg)
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.indicator?.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView?.alpha = 0.0
                    })
                }else {
                    self?.indicator?.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView?.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
        
//        viewModel.initFetch()
        viewModel.initBeerFetch()
    }
    
    
    
    private func createIndicator(){
        if indicator == nil {
            indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            self.view.addSubview(indicator!)
        }
    }
    private func createTableView() {
        
        if (tableView == nil) {
            tableView = UITableView(frame: self.view.frame, style: .plain)
//            tableView?.backgroundColor = UIColor.green
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.register(myTableViewCell.self, forCellReuseIdentifier: "cellClass")
            tableView?.rowHeight = 60
            self.view.addSubview(tableView!)
        }
        
    }
    
    
    func showAlert(msg: String? = "HelloHa") {
        let alert = UIAlertController.init(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
        }
        alertVC.addAction(okAction)
        
        let viewController = UIApplication.shared.windows.first!.rootViewController!
        viewController.present(alertVC, animated: true, completion: nil)
    }
    
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellSelect(ip: indexPath)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : myTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellClass", for: indexPath) as! myTableViewCell
        
        let cellData = viewModel.getCellData(ip: indexPath)
        cell.cellData = cellData
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

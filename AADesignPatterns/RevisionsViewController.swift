//
//  RevisionsViewController.swift
//  AADesignPatterns
//
//  Created by Arlind on 8/19/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import UIKit

protocol RevisionsViewControllerDelegate: class {
    func didFinish(with state: FormState)
}

class RevisionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: [FormState] = []
    weak var delegate: RevisionsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = FormStateSaver.restore()
    }
}

extension RevisionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = dataSource[indexPath.row].versionName
        cell.detailTextLabel?.text = dataSource[indexPath.row].dateSaved.toString()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        delegate?.didFinish(with: dataSource[indexPath.row])
    }
}

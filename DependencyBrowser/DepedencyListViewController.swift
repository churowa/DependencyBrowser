//
//  ViewController.swift
//  DependencyBrowser
//
//  Created by Francis Chary on 2017-10-01.
//  Copyright © 2017 Francis Chary. All rights reserved.
//

import UIKit

protocol DependencyListProviding {
    func carthageDependencies() -> [String]
    func cocoapodsDependencies() -> [String]
}

class DepedencyListViewController: UIViewController {

    @IBOutlet var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DepedencyListViewController: DependencyListProviding {
    func carthageDependencies() -> [String] {
        guard let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Dependencies", ofType: "plist")!),
        let carthage = plist["Carthage"] as? [String]
        else {
            return []
        }
        return carthage
    }

    func cocoapodsDependencies() -> [String] {
        guard let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Dependencies", ofType: "plist")!),
        let cocoapods = plist["Cocoapods"] as? [String]
        else {
            return []
        }
        return cocoapods
    }
}

extension DepedencyListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Cocoapods"
        case 1:
            return "Carthage"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.cocoapodsDependencies().count
        case 1:
            return self.carthageDependencies().count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DependencyCell", for: indexPath)

        let dependencyTitle: String = {
            switch indexPath.section {
            case 0:
                return self.cocoapodsDependencies()[indexPath.row]
            case 1:
                return self.carthageDependencies()[indexPath.row]
            default:
                return ""
            }
        }()
        cell.textLabel?.text = "\(dependencyTitle)"

        return cell
    }
}


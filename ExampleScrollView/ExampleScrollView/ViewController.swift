//
//  ViewController.swift
//  ExampleScrollView
//
//  Created by Thirawuth on 22/11/2563 BE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...100 {
            let label = UILabel()
            label.text = "Label \(index)"
            label.font = UIFont.systemFont(ofSize: 40)
            stackView.addArrangedSubview(label)
        }

    }

}

class ViewController2: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let item: [String] = ["ios", " Course", "Hello"]
    private var dataSource: MyTableViewDatasource!
    
    private var initialLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myDefaultCell")
//        tableView.register(MyCustomCell.self, forCellReuseIdentifier: "myCustomCell")
        
//        Cell Creation
        dataSource = MyTableViewDatasource(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "myDefaultCell")
            cell?.textLabel?.text = item
            return cell
        }
        
//        Set data source to tableView
        tableView.dataSource = dataSource
        
//        Load data to data source
//        var snapShot = NSDiffableDataSourceSnapshot<String, String>()
//        snapShot.appendSections(["test"])
//        snapShot.appendItems(item)
//        dataSource.apply(snapShot)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard initialLoad else { return }
        initialLoad = false
//        call service
//        Load data to data source
        var snapShot = NSDiffableDataSourceSnapshot<String, String>()
        snapShot.appendSections(["test"])
        snapShot.appendItems(item)
        dataSource.apply(snapShot)
    }

}

final class MyTableViewDatasource: UITableViewDiffableDataSource<String, String> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snapshot().sectionIdentifiers[section]
    }
}

class SampleOldDataSourceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let item: [String] = ["ios", " Course", "Hello", "Champ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension SampleOldDataSourceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = item[indexPath.row]
        return cell ?? UITableViewCell()
        
    }
    
}

struct Item: Hashable {
    let id = UUID()
    let name: String
}
//UICollectionViewDataSource
//UICollectionViewDiffableDataSource
class CollectionViewController: UIViewController {
    typealias DiffableSourece = UICollectionViewDiffableDataSource<String, Item>
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: DiffableSourece!
    private let item: [Item] = [Item.init(name: "ios"), Item.init(name: "Course"), Item.init(name: "Hello"), Item.init(name: "mama"), Item.init(name: "haha"),Item.init(name: "ios"), Item.init(name: "Course"), Item.init(name: "Hello"), Item.init(name: "mama"), Item.init(name: "haha"),Item.init(name: "ios"), Item.init(name: "Course"), Item.init(name: "Hello"), Item.init(name: "mama"), Item.init(name: "haha"),Item.init(name: "ios"), Item.init(name: "Course"), Item.init(name: "Hello"), Item.init(name: "mama"), Item.init(name: "haha"),Item.init(name: "ios"), Item.init(name: "Course"), Item.init(name: "Hello"), Item.init(name: "mama"), Item.init(name: "haha")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCollectionCell")
        
        dataSource = DiffableSourece(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let label = UILabel()
            label.text = item.name
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionCell", for: indexPath)
            let subview = cell.subviews
            subview.forEach { (view) in
                view.removeFromSuperview()
            }
            cell.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: cell.topAnchor),
                label.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                label.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
            ])
            
            return cell
        })
        
//        collectionView.dataSource = dataSource
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var snapShot = NSDiffableDataSourceSnapshot<String, Item>()
        snapShot.appendSections([""])
        snapShot.appendItems(item)
        dataSource.apply(snapShot)
    }
    
}

//customCell
//class MyCustomCell: UITableViewCell {
//
//}

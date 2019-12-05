//
//  ViewController.swift
//
//  Copyright © 2019 ServiceNow. All rights reserved.
//

import UIKit

protocol TypeName: AnyObject {
    static var typeName: String { get }
}

extension TypeName {
    static var typeName: String {
        let type = String(describing: self)
        return type
    }
}

extension NSObject: TypeName {
    class var typeName: String {
        let type = String(describing: self)
        return type
    }
}

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return coffeeShops.count
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let coffeeShop = coffeeShops[indexPath.row]
		print("tapped ", coffeeShop.name, coffeeShop.rating)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeshop", for: indexPath) as! CoffeeShopItemView
		let coffeeShop = coffeeShops[indexPath.row]
		print(coffeeShop.name,coffeeShop.review,coffeeShop.rating)
		cell.nameLabel.text = coffeeShop.name
		cell.reviewLabel.text = coffeeShop.review
		cell.ratingLabel.text = "Rating: \(Int(coffeeShop.rating))"
        return cell
	}
	var coffeeShops = [CoffeeShop]()
	@IBOutlet weak var tableView: UITableView!
	func loadCoffeeShops() {
		// this can be put in a separate method/file to read from json
		if let path = Bundle.main.path(forResource: "CoffeeShops", ofType: "json") {
			if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
				if (try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)) != nil {
					let decoder = JSONDecoder()
					if let content = try? decoder.decode([CoffeeShop].self, from: data) {
						coffeeShops = content
					}
				}
			}
		}
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableView.automaticDimension
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.register(UINib(nibName: CoffeeShopItemView.typeName, bundle: nil), forCellReuseIdentifier: "coffeeshop")
		// this can be made async, if needed e.g. network call or if the file size is huge e.g. 1000 rows
		// for now, i am just loading it at once.
		loadCoffeeShops()
	}
}

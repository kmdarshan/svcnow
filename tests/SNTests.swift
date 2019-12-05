//
//  Copyright © 2019 ServiceNow. All rights reserved.
//

import XCTest
@testable import svcnow

class SNCTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoffeeShop() {
        let coffeeShop = CoffeeShop(name: "Test Coffee", review: "Test Review", rating: 1)
        XCTAssertEqual(coffeeShop.name, "Test Coffee")
        XCTAssertEqual(coffeeShop.review, "Test Review")
        XCTAssertEqual(coffeeShop.rating, 1)
    }
    
    func testLoadFromJSON() {
        // TODO: load coffee shops from json and make sure they are loaded correctly
		if let path = Bundle.main.path(forResource: "CoffeeShops", ofType: "json") {
			if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
				if (try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)) != nil {
					let decoder = JSONDecoder()
					if let content = try? decoder.decode([CoffeeShop].self, from: data) {
						XCTAssertEqual(content.count, 5)
					}
				}
			}
		}
    }
}

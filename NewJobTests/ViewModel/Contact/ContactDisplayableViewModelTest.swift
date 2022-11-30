//
//  ContactDisplayableViewModelTest.swift
//  NewJobTests
//
//  Created by Pierre on 29/11/2022.
//

import XCTest
@testable import NewJob

final class ContactDisplayableViewModelTest: XCTestCase {
    var vm: ContactDisplayableViewModel!

    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        vm = ContactDisplayableViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        vm = nil
    }
    
    // MARK: - Tests
    func testGetClickableString_WhenPassText_ThenShouldReturnClickableText() {
        XCTAssertEqual(vm.clickableString, "")
        vm.getClickableString(clickableType: .email, text: "test@test.fr")
        XCTAssertEqual(vm.clickableString, "mailto:test@test.fr")
        
        vm.getClickableString(clickableType: .phoneNumer, text: "0600000000")
        XCTAssertEqual(vm.clickableString, "tel:0600000000")
    }

}

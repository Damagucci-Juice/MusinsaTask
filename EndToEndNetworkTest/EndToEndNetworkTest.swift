//
//  EndToEndNetworkTest.swift
//  EndToEndNetworkTest
//
//  Created by YEONGJIN JANG on 2022/07/14.
//

import XCTest
import TinyNetworking
@testable import MUSINSAPriorTask

class EndToEndNetworkTest: XCTestCase {
    
    let networking = TinyNetworking<MusinsaTarget>()
    
    func testAsycronusRequestSection() {
        var resultOfTask: Any?
        
        let expectation = XCTestExpectation(description: "TinyNetworkingTaskExpectation")
        
        networking.request(resource: .sections) { result in
            switch result {
            case let .success(response):
                let sections  = try? response.map(to: Section.self)
                resultOfTask = sections
                print(sections?.data.count)
                expectation.fulfill()
//                dump(resultOfTask)
            case let .failure(error):
                dump(error)
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertNotNil(resultOfTask, "\(resultOfTask)")
    }
    
}

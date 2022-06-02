//
//  zemoga_mobile_testTests.swift
//  zemoga-mobile-testTests
//
//  Created by AlejandroArciniegas on 31/05/22.
//

import XCTest
import Combine
@testable import zemoga_mobile_test
class zemoga_mobile_testTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var postFileStorage: PostFileStorage!


    override func setUpWithError() throws {
        try super.setUpWithError()
        cancellables = []
        postFileStorage = PostFileStorage()

    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testPostFileStorageLoadDefault() throws {
        //loads the default post from a embedded json
        let posts = try awaitPublisher(postFileStorage.loadDefault())
        if(posts.isEmpty){
            XCTFail("Nothing was loaded, error on LoadDefault method")
        }
        XCTAssertEqual(posts[0].id, 101, "id is not 101")
        XCTAssertEqual(posts[0].userId, 1, "userId is not 1")
        XCTAssert(posts[0].title == "Example Post")
    }

}
//Combine AwaitPublisher for Test Cases
extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}



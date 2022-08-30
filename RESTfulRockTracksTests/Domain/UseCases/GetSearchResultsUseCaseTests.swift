//
//  GetSearchResultsUseCaseTests.swift
//  RESTfulRockTracksTests
//
//  Created by Paul Willis on 29/08/2022.
//

import XCTest
@testable import RESTfulRockTracks

class getSearchResultsUseCaseTests: XCTestCase {
    
    enum SearchResultsUseCaseSuccessTestError: Error {
        case failedFetching
    }
    
    private var repository: SearchResultsRepositoryMock?
    private var sut: SearchResultsUseCase?
    private var resultValue: SearchResultsRepositoryProtocol.ResultValue?
    private var task: URLSessionTask?
    
    private let searchResults = [
        SearchResult.createStub(),
        SearchResult.createStub()
    ]
    
    // MARK: - Setup
    override func setUp() {
        self.repository = SearchResultsRepositoryMock()
        self.repository?.getSearchResultsReturnValue = URLSessionTask()
        self.sut = SearchResultsUseCase(repository: self.repository!)
    }
    
    override func tearDown() {
        self.repository = nil
        self.sut = nil
        self.resultValue = nil
        self.task = nil
        super.tearDown()
    }

    // MARK: - Tests
        
    func test_getSearchResultsUseCase_whenExecutes_shouldCallRepositoryOnce() {
        // when
        whenUseCaseRequestsSearchResults()

        // then
        thenEnsureRepositoryIsCalledExactlyOnce()
    }
    
    func test_getSearchResultsUseCase_whenSuccessfullyGetsSearchResults_shouldReturnSearchResultsWithSuccess() {
        // given
        givenExpectedSuccess()
             
        // when
        whenUseCaseRequestsSearchResults()
        
        // then
        thenEnsureSearchResultsAreFetched()
    }
    
    func test_getSearchResultsUseCase_whenFailsToGetSearchResults_shouldReturnErrorWithFailure() {
        // given
        givenExpectedFailure()
        
        // when
        whenUseCaseRequestsSearchResults()
        
        // then
        thenEnsureFailureResultIsReturned()
    }
    
    func test_getSearchResultsUseCase_whenGetsSearchResults_shouldReturnTask() {
        // when
        whenUseCaseRequestsSearchResults()
        
        // then
        thenEnsureTaskIsReturned()
    }

    // MARK: - Given

    private func givenExpectedSuccess() {
        self.repository?.getSearchResultsCompletionReturnValue = .success(self.searchResults)
    }
    
    private func givenExpectedFailure() {
        self.repository?.getSearchResultsCompletionReturnValue = .failure(SearchResultsUseCaseSuccessTestError.failedFetching)
    }
    
    // MARK: - When
    
    private func whenUseCaseRequestsSearchResults() {
        self.task = self.sut?.execute { result in
            self.resultValue = result
        }
    }
    
    // MARK: - Then
    
    private func thenEnsureRepositoryIsCalledExactlyOnce() {
        XCTAssertEqual(self.repository?.getSearchResultsCallsCount, 1)
    }
    
    private func thenEnsureSearchResultsAreFetched() {
        let returnedSearchResults = try? unwrapResult()
        XCTAssertEqual(self.searchResults, returnedSearchResults)
    }
    
    private func thenEnsureFailureResultIsReturned() {
        XCTAssertThrowsError(try unwrapResult(), "A SearchResultsUseCaseSuccessTestError should have been thrown but no Error was thrown") { error in
            XCTAssertEqual(error as? SearchResultsUseCaseSuccessTestError, SearchResultsUseCaseSuccessTestError.failedFetching)
        }
    }
    
    private func thenEnsureTaskIsReturned() {
        XCTAssertNotNil(self.task)
    }

    // MARK: - Helpers
    
    private func unwrapResult() throws -> [SearchResult]? {
        return try self.resultValue?.get()
    }
}

extension SearchResult {
    public static func createStub() -> SearchResult {
        SearchResult(
            wrapperType: .track,
            artistName: String.random(),
            trackName: String.random(),
            price: Double.random(in: 1...2),
            artworkUrl: String.random(),
            durationInMilliseconds: Int.random(in: 200000...300000),
            releaseDate: ISO8601DateFormatter().date(from: "2008-11-25 12:00:00 +0000")
        )
    }
}

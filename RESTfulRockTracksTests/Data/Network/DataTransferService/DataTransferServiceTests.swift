//
//  DataTransferServiceTests.swift
//  RESTfulRockTracksTests
//
//  Created by Paul Willis on 29/08/2022.
//

import XCTest
@testable import RESTfulRockTracks

class DataTransferServiceTests: XCTestCase {
    
    typealias Sut = DataTransferService<ResponseDTOMock>
    
    private enum ReturnedResult {
        case success
        case failure
    }
    
    private enum DataTransferErrorMock: Error {
        case someError
    }

    private var networkService: NetworkServiceMock?
    private var sut: Sut?
    
    private var expectedReturnedURLSessionTask: URLSessionTask?
    private var returnedURLSessionTask: URLSessionTask?
    
    private var sentURLRequest: URLRequest?
    private var urlRequestReceivedByNetworkService: URLRequest?
    
    private var expectedDTO = ResponseDTOMock(results: [
        ResponseDTOMock.ResultDTO(id: 28, name: "Action")
    ])
    private var returnedDTO: ResponseDTOMock?
    
    private var returnedResult: ReturnedResult?
    private var returnedError: Error?

    private func completion(_ result: Sut.ResultValue) {
        switch result {
        case .success(let returnedDTO):
            self.returnedResult = .success
            self.returnedDTO = returnedDTO
        case .failure(let returnedError):
            self.returnedResult = .failure
            self.returnedError = returnedError
        }
    }

    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        
        self.networkService = NetworkServiceMock()
        self.sut = DataTransferService(networkService: self.networkService!)
    }
    
    override func tearDown() {
        self.networkService = nil
        self.sut = nil
        
        self.expectedReturnedURLSessionTask = nil
        self.returnedURLSessionTask = nil
        
        self.sentURLRequest = nil
        self.urlRequestReceivedByNetworkService = nil
        
        self.returnedDTO = nil
        
        self.returnedResult = nil
        self.returnedError = nil
        
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_DataTransferService_whenPerformsRequest_shouldReturnURLSessionTask() {
        // when
        whenNetworkRequestIsPerformed()
        
        // then
        thenEnsureReturnsURLSessionTask()
    }
    
    func test_DataTransferService_whenPerformsRequest_shouldCallNetworkServiceExactlyOnce() {
        // when
        whenNetworkRequestIsPerformed()
        
        // then
        thenEnsureNetworkServiceCalledExactlyOnce()
    }
    
    func test_DataTransferService_whenPerformsRequest_shouldReturnURLSessionTaskFromNetworkService() {
        givenExpectedNetworkRequestResponse()
                
        // when
        whenNetworkRequestIsPerformed()
        
        // then
        thenEnsureReturnsURLSessionTaskFromNetworkService()
    }
    
    func test_DataTransferService_whenPerformsRequest_shouldPassRequestToNetworkService() {
        // when
        whenNetworkRequestIsPerformed()
        
        // then
        thenEnsureRequestIsPassedToNetworkService()
    }
        
    func test_DataTransferService_whenPerformsRequest_shouldReturnResult() {
        // when
        whenNetworkRequestIsPerformed()
        
        // then
        thenEnsureReturnsResult()
    }
    
    func test_DataTransferService_whenPerformsSuccessfulRequest_shouldReturnSuccessResultInCompletionHandler() {
        // when
        whenPerformsSuccessfulRequest()
        
        // then
        thenEnsureReturnsSuccessResult()
    }
    
    func test_DataTransferService_whenPerformsFailedRequest_shouldReturnFailureResultInCompletionHandler() {
        // when
        whenPerformsFailedRequest()
        
        // then
        thenEnsureReturnsFailureResult()
    }
    
    func test_DataTransferService_whenPerformsSuccessfulRequest_shouldReturnDTO() {
        // given
        self.networkService?.requestCompletionReturnValue = .success(Data.mockSuccessResponse())

        // when
        whenNetworkRequestIsPerformed()
        
        // then
        thenEnsureReturnsDTO()
    }
    
    func test_DataTransferService_whenPerformsSuccessfulRequest_shouldReturnURLSessionTask() {
        // when
        whenPerformsSuccessfulRequest()
        
        // then
        thenEnsureReturnsURLSessionTask()
    }
    
    func test_DataTransferService_whenPerformsFailedRequest_shouldReturnURLSessionTask() {
        // when
        whenPerformsFailedRequest()
        
        // then
        thenEnsureReturnsURLSessionTask()
    }
    
    func test_DataTransferService_whenPerformsFailedRequest_shouldReturnErrorInFailureResult() {
        // when
        whenPerformsFailedRequest()
        
        // then
        thenEnsureReturnsError()
    }
    
//    func test_DataTransferService_whenPerformFailedRequest_shouldReturnSpecificDataTransferErrorInFailureResult() {
//        // given
//        let expectedError = NetworkError.generic(DataTransferErrorMock.someError)
//        self.networkService?.requestCompletionReturnValue = .failure(expectedError)
//
//        // when
//        whenNetworkRequestIsPerformed()
//
//        // then
//        guard let returnedError = self.returnedError else {
//            XCTFail("Should always be non-nil value at this point")
//            return
//        }
//
//        let networkError: NetworkError?
//        if returnedError is NetworkError {
//            networkError = returnedError as? NetworkError
//        }
//
//        guard let networkError = networkError else {
//            return
//        }
//
//
//        if case NetworkError.generic(DataTransferErrorMock.someError) = returnedError {
//            XCTAssertEqual(expectedError, networkError)
//        }
//    }
    
    func test_DataTransferService_whenPerformsFailedRequest_shouldCallNetworkServiceExactlyOnce() {
        // when
        whenPerformsFailedRequest()
        
        // then
        thenEnsureNetworkServiceCalled(numberOfTimes: 1)
    }
    
    func test_DataTransferService_whenPerformsMultipleFailedRequests_shouldCallNetworkServiceEqualNumberOfTimes() {
        // when
        whenPerformsFailedRequest()
        whenPerformsFailedRequest()

        // then
        thenEnsureNetworkServiceCalled(numberOfTimes: 2)
    }

    func test_DataTransferService_whenPerformsSuccessfulRequest_shouldCallNetworkServiceExactlyOnce() {
        // when
        whenPerformsSuccessfulRequest()
        
        // then
        thenEnsureNetworkServiceCalled(numberOfTimes: 1)
    }
    
    func test_DataTransferService_whenPerformsMultipleSuccessfulRequests_shouldCallRequestPerformerEqualNumberOfTimes() {
        // when
        whenPerformsSuccessfulRequest()
        whenPerformsSuccessfulRequest()

        // then
        thenEnsureNetworkServiceCalled(numberOfTimes: 2)
    }
    
    func test_Decoding_whenPerformsSuccessfulRequest_shouldDecodeDataReceivedFromNetwork() {
        // when
        whenPerformsSuccessfulRequest()
        
        // then
        thenEnsureDecodesDataIntoExpectedObject()
    }
    
    // MARK: - Given
        
    private func givenExpectedNetworkRequestResponse(of urlSessionTask: URLSessionTask? = nil) {
        self.expectedReturnedURLSessionTask = urlSessionTask ?? URLSessionTask()
        self.networkService?.requestReturnValue = expectedReturnedURLSessionTask
    }
    
    // MARK: - When
    
    private func whenNetworkRequestIsPerformed() {
        self.performRequest()
    }
    
    private func whenPerformsSuccessfulRequest() {
        self.createMockSuccessfulResponseFromNetworkService()
        self.performRequest()
    }
    
    private func whenPerformsFailedRequest() {
        self.networkService?.requestCompletionReturnValue = .failure(NetworkError.someError)
        self.performRequest()
    }
        
    // MARK: - Then
    
    private func thenEnsureReturnsURLSessionTask() {
        XCTAssertNotNil(self.returnedURLSessionTask)
    }
    
    private func thenEnsureNetworkServiceCalledExactlyOnce() {
        XCTAssertEqual(self.networkService?.requestCallsCount, 1)
    }
    
    private func thenEnsureReturnsURLSessionTaskFromNetworkService() {
        guard
            let expectedReturnedURLSessionTask = self.expectedReturnedURLSessionTask,
            let returnedURLSessionTask = self.returnedURLSessionTask
        else {
            throwPreconditionFailureWhereVariableShouldNotBeNil()
            return
        }
        
        XCTAssertEqual(expectedReturnedURLSessionTask, returnedURLSessionTask)
    }
    
    private func thenEnsureRequestIsPassedToNetworkService() {
        XCTAssertEqual(urlRequest(), networkService?.requestReceivedRequest)
    }
    
    private func thenEnsureReturnsResult() {
        XCTAssertNotNil(self.returnedResult)
    }
    
    private func thenEnsureReturnsSuccessResult() {
        XCTAssertEqual(self.returnedResult, .success)
    }

    private func thenEnsureReturnsFailureResult() {
        XCTAssertEqual(self.returnedResult, .failure)
    }
    
    private func thenEnsureReturnsDTO() {
        XCTAssertNotNil(self.returnedDTO)
    }
    
    private func thenEnsureReturnsError() {
        XCTAssertNotNil(self.returnedError)
    }
    
    private func thenEnsureNetworkServiceCalled(numberOfTimes expectedCalls: Int) {
        let actualCalls = self.networkService?.requestCallsCount
        XCTAssertEqual(expectedCalls, actualCalls)
    }
    
    private func thenEnsureDecodesDataIntoExpectedObject() {
        XCTAssertEqual(self.expectedDTO, self.returnedDTO)
    }
    
    // MARK: - Test Setup Errors
    
    private func throwPreconditionFailureWhereVariableShouldNotBeNil() {
        preconditionFailure("The test variable should not be nil at this point - check test setup and ensure variables are correctly initialised")
    }
    
    // MARK: - Helpers
    
    private func urlRequest() -> URLRequest? {
        URLRequest(url: URL(string: "www.expectedReturnValue.com")!)
    }
    
    private func performRequest() {
        self.returnedURLSessionTask = sut?.request(self.urlRequest()!, completion: self.completion(_:))
    }
    
    private func createMockSuccessfulResponseFromNetworkService() {
        self.networkService?.requestCompletionReturnValue = .success(Data.mockSuccessResponse())
    }
}

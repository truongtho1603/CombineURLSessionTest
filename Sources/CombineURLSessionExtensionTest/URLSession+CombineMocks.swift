//
//  URLSession+CombineMocks.swift
//
//  Created by Tho Do on 14/02/2021.
//

import Foundation
import Combine
import CombineURLSessionExtension

class MockDataTaskPublisher<T>: DataTaskPublisherProtocol {
    var mockTryMapSubject = PassthroughSubject<T, Error>()
    var mockMapKeyPathSubject = PassthroughSubject<T, URLError>()
    var mockReceiveOnSubject = PassthroughSubject<URLSession.DataTaskPublisher.Output, URLError>()

    func tryMapPublisher<T>(_ transform: @escaping ((data: Data, response: URLResponse)) throws -> T) -> AnyPublisher<T, Error> {
        mockTryMapSubject
            .map { $0 as! T }
            .eraseToAnyPublisher()
    }

    func mapKeyPath<T>(_ keyPath: KeyPath<(data: Data, response: URLResponse), T>) -> AnyPublisher<T, URLError> {
        mockMapKeyPathSubject
            .map { $0 as! T }
            .eraseToAnyPublisher()
    }

    func receiveOn<S: Scheduler>(scheduler: S,
                                 options: S.SchedulerOptions?) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError> {
        mockReceiveOnSubject.eraseToAnyPublisher()
    }
}

class MockURLSession<T>: URLSessionProtocol {
    var mockDataTaskPublisher: (URLRequest) -> DataTaskPublisherProtocol = { _ in MockDataTaskPublisher<T>() }

    var mockDataTaskPublisherURL: (URL) -> DataTaskPublisherProtocol = { _ in MockDataTaskPublisher<T>() }

    func dataTaskPublisherForRequest(_ request: URLRequest) -> DataTaskPublisherProtocol {
        mockDataTaskPublisher(request)
    }

    func dataTaskPublisherForURL(_ url: URL) -> DataTaskPublisherProtocol {
        mockDataTaskPublisherURL(url)
    }
}

class MockNotificationCenterPublisher<T>: NotificationCenterPublisherProtocol {
    let mockMapTransformSubject = PassthroughSubject<Notification, Never>()

    func mapTransform<T>(_ transform: @escaping (Notification) -> T) -> AnyPublisher<T, Never> {
        mockMapTransformSubject
            .map(transform)
            .eraseToAnyPublisher()
    }
}

class MockCombineNotificationCenter: NotificationCenterProtocol {
    var mockPublisherFor: (String, AnyObject?) -> NotificationCenterPublisherProtocol = { _, _ in MockNotificationCenterPublisher<Any>() }

    func publisherFor(_ name: Notification.Name,
                      _ object: AnyObject?) -> NotificationCenterPublisherProtocol {
        mockPublisherFor(name.rawValue, object)
    }
}

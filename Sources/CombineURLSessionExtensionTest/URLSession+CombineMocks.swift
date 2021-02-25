//
//  URLSession+CombineMocks.swift
//
//  Created by Tho Do on 14/02/2021.
//

import Foundation
import Combine
import CombineURLSessionExtension

public class MockDataTaskPublisher<T>: DataTaskPublisherProtocol {
    public var mockTryMapSubject = PassthroughSubject<T, Error>()
    public var mockMapKeyPathSubject = PassthroughSubject<T, URLError>()
    public var mockReceiveOnSubject = PassthroughSubject<URLSession.DataTaskPublisher.Output, URLError>()

    public func tryMapPublisher<T>(_ transform: @escaping ((data: Data, response: URLResponse)) throws -> T) -> AnyPublisher<T, Error> {
        mockTryMapSubject
            .map { $0 as! T }
            .eraseToAnyPublisher()
    }

    public func mapKeyPath<T>(_ keyPath: KeyPath<(data: Data, response: URLResponse), T>) -> AnyPublisher<T, URLError> {
        mockMapKeyPathSubject
            .map { $0 as! T }
            .eraseToAnyPublisher()
    }

    public func receiveOn<S: Scheduler>(scheduler: S,
                                        options: S.SchedulerOptions?) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError> {
        mockReceiveOnSubject.eraseToAnyPublisher()
    }
}

public class MockURLSession<T>: URLSessionProtocol {
    public var mockDataTaskPublisher: (URLRequest) -> DataTaskPublisherProtocol = { _ in MockDataTaskPublisher<T>() }

    public var mockDataTaskPublisherURL: (URL) -> DataTaskPublisherProtocol = { _ in MockDataTaskPublisher<T>() }

    public func dataTaskPublisherForRequest(_ request: URLRequest) -> DataTaskPublisherProtocol {
        mockDataTaskPublisher(request)
    }

    public func dataTaskPublisherForURL(_ url: URL) -> DataTaskPublisherProtocol {
        mockDataTaskPublisherURL(url)
    }
}

public class MockNotificationCenterPublisher<T>: NotificationCenterPublisherProtocol {
    public let mockMapTransformSubject = PassthroughSubject<Notification, Never>()

    public func mapTransform<T>(_ transform: @escaping (Notification) -> T) -> AnyPublisher<T, Never> {
        mockMapTransformSubject
            .map(transform)
            .eraseToAnyPublisher()
    }
}

public class MockCombineNotificationCenter: NotificationCenterProtocol {
    public var mockPublisherFor: (String, AnyObject?) -> NotificationCenterPublisherProtocol = { _, _ in MockNotificationCenterPublisher<Any>() }

    public func publisherFor(_ name: Notification.Name,
                             _ object: AnyObject?) -> NotificationCenterPublisherProtocol {
        mockPublisherFor(name.rawValue, object)
    }
}

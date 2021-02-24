//
//  URLSession+Extensions.swift
//
//  Created by Tho Do on 14/02/2021.
//

import Foundation
import Combine

public protocol URLSessionProtocol: class {
    func dataTaskPublisherForRequest(_ request: URLRequest) -> DataTaskPublisherProtocol
    func dataTaskPublisherForURL(_ url: URL) -> DataTaskPublisherProtocol
}

extension URLSession: URLSessionProtocol {
    public func dataTaskPublisherForRequest(_ request: URLRequest) -> DataTaskPublisherProtocol {
        dataTaskPublisher(for: request)
    }

    public func dataTaskPublisherForURL(_ url: URL) -> DataTaskPublisherProtocol {
        dataTaskPublisher(for: url)
    }
}

public protocol DataTaskPublisherProtocol {
    func tryMapPublisher<T>(_ transform: @escaping ((data: Data, response: URLResponse)) throws -> T) -> AnyPublisher<T, Error>
    func mapKeyPath<T>(_ keyPath: KeyPath<(data: Data, response: URLResponse), T>) -> AnyPublisher<T, URLError>

    func receiveOn<S: Scheduler>(scheduler: S,
                                 options: S.SchedulerOptions?) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError>
}

extension DataTaskPublisherProtocol where Self: Publisher {}

extension URLSession.DataTaskPublisher: DataTaskPublisherProtocol {
    public func tryMapPublisher<T>(_ transform: @escaping ((data: Data, response: URLResponse)) throws -> T) -> AnyPublisher<T, Error> {
        tryMap(transform).eraseToAnyPublisher()
    }

    public func mapKeyPath<T>(_ keyPath: KeyPath<(data: Data, response: URLResponse), T>) -> AnyPublisher<T, URLError> {
        map(keyPath).eraseToAnyPublisher()
    }

    public func receiveOn<S: Scheduler>(scheduler: S,
                                 options: S.SchedulerOptions?) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError> {
        receive(on: scheduler,
                options: options).eraseToAnyPublisher()
    }
}

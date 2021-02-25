//
//  NotificationCenter+Extensions.swift
//
//  Created by Tho Do on 14/02/2021.
//

import Foundation
import Combine

public protocol NotificationCenterProtocol: class {
    func publisherFor(_ name: Notification.Name,
                      _ object: AnyObject?) -> NotificationCenterPublisherProtocol
}

extension NotificationCenter: NotificationCenterProtocol {
    public func publisherFor(_ name: Notification.Name,
                             _ object: AnyObject?) -> NotificationCenterPublisherProtocol {
        publisher(for: name, object: object) as NotificationCenterPublisherProtocol
    }
}

public protocol NotificationCenterPublisherProtocol {
    func mapTransform<T>(_ transform: @escaping (Notification) -> T) -> AnyPublisher<T, Never>
}

extension NotificationCenter.Publisher: NotificationCenterPublisherProtocol {
    public func mapTransform<T>(_ transform: @escaping (Notification) -> T) -> AnyPublisher<T, Never> {
        map(transform).eraseToAnyPublisher()
    }
}

//
// Experience.swift
// GENERATED CONTENT. DO NOT EDIT.
//

import Foundation
import RealityKit
import simd
import Combine

@available(iOS 13.0, macOS 10.15, *)
public enum Experience {

    public class NotificationTrigger {

        public let identifier: Swift.String

        private weak var root: RealityKit.Entity?

        fileprivate init(identifier: Swift.String, root: RealityKit.Entity?) {
            self.identifier = identifier
            self.root = root
        }

        public func post(overrides: [Swift.String: RealityKit.Entity]? = nil) {
            guard let scene = root?.scene else {
                print("Unable to post notification trigger with identifier \"\(self.identifier)\" because the root is not part of a scene")
                return
            }

            var userInfo: [Swift.String: Any] = [
                "RealityKit.NotificationTrigger.Scene": scene,
                "RealityKit.NotificationTrigger.Identifier": self.identifier
            ]
            userInfo["RealityKit.NotificationTrigger.Overrides"] = overrides

            Foundation.NotificationCenter.default.post(name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotificationTrigger"), object: self, userInfo: userInfo)
        }

    }

    public class NotifyAction {

        public let identifier: Swift.String

        public var onAction: ((RealityKit.Entity?) -> Swift.Void)?

        private weak var root: RealityKit.Entity?

        fileprivate init(identifier: Swift.String, root: RealityKit.Entity?) {
            self.identifier = identifier
            self.root = root

            Foundation.NotificationCenter.default.addObserver(self, selector: #selector(actionDidFire(notification:)), name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotifyAction"), object: nil)
        }

        deinit {
            Foundation.NotificationCenter.default.removeObserver(self, name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotifyAction"), object: nil)
        }

        @objc
        private func actionDidFire(notification: Foundation.Notification) {
            guard let onAction = onAction else {
                return
            }

            guard let userInfo = notification.userInfo as? [Swift.String: Any] else {
                return
            }

            guard let scene = userInfo["RealityKit.NotifyAction.Scene"] as? RealityKit.Scene,
                root?.scene == scene else {
                    return
            }

            guard let identifier = userInfo["RealityKit.NotifyAction.Identifier"] as? Swift.String,
                identifier == self.identifier else {
                    return
            }

            let entity = userInfo["RealityKit.NotifyAction.Entity"] as? RealityKit.Entity

            onAction(entity)
        }

    }

    public enum LoadRealityFileError: Error {
        case fileNotFound(String)
    }

    private static var streams = [Combine.AnyCancellable]()

    public static func loadBox() throws -> Experience.Box {
        guard let realityFileURL = Foundation.Bundle(for: Experience.Box.self).url(forResource: "Experience", withExtension: "reality") else {
            throw Experience.LoadRealityFileError.fileNotFound("Experience.reality")
        }

        let realityFileSceneURL = realityFileURL.appendingPathComponent("Box", isDirectory: false)
        let anchorEntity = try Experience.Box.loadAnchor(contentsOf: realityFileSceneURL)
        return createBox(from: anchorEntity)
    }

    public static func loadBoxAsync(completion: @escaping (Swift.Result<Experience.Box, Swift.Error>) -> Void) {
        guard let realityFileURL = Foundation.Bundle(for: Experience.Box.self).url(forResource: "Experience", withExtension: "reality") else {
            completion(.failure(Experience.LoadRealityFileError.fileNotFound("Experience.reality")))
            return
        }

        var cancellable: Combine.AnyCancellable?
        let realityFileSceneURL = realityFileURL.appendingPathComponent("Box", isDirectory: false)
        let loadRequest = Experience.Box.loadAnchorAsync(contentsOf: realityFileSceneURL)
        cancellable = loadRequest.sink(receiveCompletion: { loadCompletion in
            if case let .failure(error) = loadCompletion {
                completion(.failure(error))
            }
            streams.removeAll { $0 === cancellable }
        }, receiveValue: { entity in
            completion(.success(Experience.createBox(from: entity)))
        })
        cancellable?.store(in: &streams)
    }

    private static func createBox(from anchorEntity: RealityKit.AnchorEntity) -> Experience.Box {
        let box = Experience.Box()
        box.anchoring = anchorEntity.anchoring
        box.addChild(anchorEntity)
        return box
    }

    public static func loadDronePro() throws -> Experience.DronePro {
        guard let realityFileURL = Foundation.Bundle(for: Experience.DronePro.self).url(forResource: "Experience", withExtension: "reality") else {
            throw Experience.LoadRealityFileError.fileNotFound("Experience.reality")
        }

        let realityFileSceneURL = realityFileURL.appendingPathComponent("DronePro", isDirectory: false)
        let anchorEntity = try Experience.DronePro.loadAnchor(contentsOf: realityFileSceneURL)
        return createDronePro(from: anchorEntity)
    }

    public static func loadDroneProAsync(completion: @escaping (Swift.Result<Experience.DronePro, Swift.Error>) -> Void) {
        guard let realityFileURL = Foundation.Bundle(for: Experience.DronePro.self).url(forResource: "Experience", withExtension: "reality") else {
            completion(.failure(Experience.LoadRealityFileError.fileNotFound("Experience.reality")))
            return
        }

        var cancellable: Combine.AnyCancellable?
        let realityFileSceneURL = realityFileURL.appendingPathComponent("DronePro", isDirectory: false)
        let loadRequest = Experience.DronePro.loadAnchorAsync(contentsOf: realityFileSceneURL)
        cancellable = loadRequest.sink(receiveCompletion: { loadCompletion in
            if case let .failure(error) = loadCompletion {
                completion(.failure(error))
            }
            streams.removeAll { $0 === cancellable }
        }, receiveValue: { entity in
            completion(.success(Experience.createDronePro(from: entity)))
        })
        cancellable?.store(in: &streams)
    }

    private static func createDronePro(from anchorEntity: RealityKit.AnchorEntity) -> Experience.DronePro {
        let dronePro = Experience.DronePro()
        dronePro.anchoring = anchorEntity.anchoring
        dronePro.addChild(anchorEntity)
        return dronePro
    }

    public class Box: RealityKit.Entity, RealityKit.HasAnchoring {

    }

    public class DronePro: RealityKit.Entity, RealityKit.HasAnchoring {

        public var dronePro: RealityKit.Entity? {
            return self.findEntity(named: "DronePro")
        }



        public private(set) lazy var actions = Experience.DronePro.Actions(root: self)
        public private(set) lazy var notifications = Experience.DronePro.Notifications(root: self)

        public class Notifications {

            fileprivate init(root: RealityKit.Entity) {
                self.root = root
            }

            private weak var root: RealityKit.Entity?

            public private(set) lazy var droneBackward = Experience.NotificationTrigger(identifier: "droneBackward", root: root)
            public private(set) lazy var droneForward = Experience.NotificationTrigger(identifier: "droneForward", root: root)
            public private(set) lazy var droneLeft = Experience.NotificationTrigger(identifier: "droneLeft", root: root)
            public private(set) lazy var droneOff = Experience.NotificationTrigger(identifier: "droneOff", root: root)
            public private(set) lazy var droneRight = Experience.NotificationTrigger(identifier: "droneRight", root: root)
            public private(set) lazy var droneRotateLeft = Experience.NotificationTrigger(identifier: "droneRotateLeft", root: root)
            public private(set) lazy var droneRotateRight = Experience.NotificationTrigger(identifier: "droneRotateRight", root: root)
            public private(set) lazy var droneUp = Experience.NotificationTrigger(identifier: "droneUp", root: root)
            public private(set) lazy var performActionOne = Experience.NotificationTrigger(identifier: "performActionOne", root: root)

            public private(set) lazy var allNotifications = [ droneUp, droneForward, droneBackward, droneRotateLeft, droneRotateRight, droneLeft, droneRight, droneOff, performActionOne ]

        }

        public class Actions {

            fileprivate init(root: RealityKit.Entity) {
                self.root = root
            }

            private weak var root: RealityKit.Entity?

            public private(set) lazy var actionComplete = Experience.NotifyAction(identifier: "ActionComplete", root: root)
            public private(set) lazy var actionCompleteDroneUp = Experience.NotifyAction(identifier: "ActionCompleteDroneUp", root: root)

            public private(set) lazy var allActions = [ actionCompleteDroneUp, actionComplete ]

        }

    }

}


//
//  RemoteConfigService.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseCore


protocol RemoteConfigProvider: AnyObject {
    func getRemoteData<T: Decodable>(for configValueKey: String, _ completion: @escaping (Result<T, Error>) -> Void)
    func string(for _key: RemoteConfigKeys) -> String?
    func int(for _key: RemoteConfigKeys) -> Int?
    func double(for _key: RemoteConfigKeys) -> Double?
    func float(for _key: RemoteConfigKeys) -> Float?
}

// swiftlint:disable inclusive_language
final class RemoteConfigService: RemoteConfigProvider {
    
    static let shared = RemoteConfigService()
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    private func configureRemoteConfigService(completion:@escaping () -> ()) {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetchAndActivate { stat, error in
            completion()
        }
    }
    
    func setup(completion:@escaping () -> ()) {
        configureRemoteConfigService(completion: completion)
    }
    
    private func key(for key: RemoteConfigKeys) -> String { key.rawValue }
    
    private func configValue(for key: String) -> RemoteConfigValue { remoteConfig.configValue(forKey: key) }
    
    func value<T: Codable>(for: T.Type, key: RemoteConfigKeys) -> T? {
        try? decoder.decode(T.self, from: configValue(for: key.rawValue).dataValue)
    }
    
    func getRemoteData<T: Decodable>(for configValueKey: String, _ completion: @escaping (Result<T, Error>) -> Void) {
        let result = remoteConfig.configValue(forKey: configValueKey)
        let data = result.dataValue
        DispatchQueue.main.async {
            do {
                let decdedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decdedData))
            } catch {
                let error = NSError(domain: "Remote Config", code: -100, userInfo: [NSLocalizedDescriptionKey: "empty Response Data"])
                completion(.failure(error))
            }
        }
    }
    
    func string(for _key: RemoteConfigKeys) -> String? {
        configValue(for: key(for: _key)).stringValue
    }
    
    func bool(for _key: RemoteConfigKeys) -> Bool {
        configValue(for: key(for: _key)).boolValue
    }
    
    func int(for _key: RemoteConfigKeys) -> Int? {
        configValue(for: key(for: _key)).numberValue.intValue
    }
    
    func double(for _key: RemoteConfigKeys) -> Double? {
        configValue(for: key(for: _key)).numberValue.doubleValue
    }
    
    func float(for _key: RemoteConfigKeys) -> Float? {
        configValue(for: key(for: _key)).numberValue.floatValue
    }
    
    deinit {
        debugPrint(#function, #fileID)
    }
}

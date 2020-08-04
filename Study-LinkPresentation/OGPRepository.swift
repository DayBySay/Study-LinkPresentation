//
//  OGPRepository.swift
//  Study-LinkPresentation
//
//  Created by Takayuki Sei on 2020/08/04.
//  Copyright © 2020 Takayuki Sei. All rights reserved.
//

import Foundation
import LinkPresentation

class OGPRepository {
    private let store = UserDefaults.standard
    private let key = "OGPRepository"
    
    func ogpMetadata(url: URL, completion: ((LPLinkMetadata) -> Void)?) {
        guard let metadatas = store.dictionary(forKey: key) as? [String: Data] else {
            fetchMetadata(url: url, completion: completion)
            return
        }
        
        guard let data = metadatas[url.absoluteString] else {
            fetchMetadata(url: url, completion: completion)
            return
        }
        
        do {
            guard let metadata = try NSKeyedUnarchiver.unarchivedObject(ofClass: LPLinkMetadata.self, from: data) else {
                fetchMetadata(url: url, completion: completion)
                return
            }
            completion?(metadata)
        } catch {
            print("Failed to unarchive metadata with error \(error)")
            fetchMetadata(url: url, completion: completion)
            return
        }
    }
    
    private func fetchMetadata(url: URL, completion: ((LPLinkMetadata) -> Void)?) {
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { [weak self] (metadata, error) in
            if let error = error {
                print(error)
                return
            }
            guard let metadata = metadata else { return }
            completion?(metadata)
            
            guard let self = self else { return }
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: metadata, requiringSecureCoding: true)
                var metadatas: [String: Data] = self.store.dictionary(forKey: self.key) as? [String: Data] ?? [:]
                metadatas[metadata.originalURL!.absoluteString] = data
                self.store.set(metadatas, forKey: self.key)
            } catch {
                print("Failed storing metadata with error \(error as NSError)")
            }
        }
    }
}

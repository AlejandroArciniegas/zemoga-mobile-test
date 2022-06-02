//
//  PostFileStorage.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import Foundation
import Combine

fileprivate struct Envelope: Codable {
    let posts: [Post]
}

class PostFileStorage {
    
    var localFile: URL {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("posts.json")
        return fileURL
    }
    
    var localFavoritesFile: URL {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("favoritePosts.json")
        return fileURL
    }
    
    var defaultFile: URL {
        return Bundle.main.url(forResource: "default", withExtension: "json")!
    }
    
    var defaultFavoriteFile: URL {
        return Bundle.main.url(forResource: "default-favorites", withExtension: "json")!
    }
    
    private func clear() {
        try? FileManager.default.removeItem(at: localFile)
    }
    
    func loadFavorites()  -> AnyPublisher<[Post], Never>  {
        if FileManager.default.fileExists(atPath: localFile.standardizedFileURL.path) {
            return Future<[Post], Never> { promise in
                self.loadFavorite(self.localFavoritesFile) { posts in
                    DispatchQueue.main.async {
                        promise(.success(posts))
                    }
                }
            }.eraseToAnyPublisher()
        } else {
            return loadDefaultFavorite()
        }
    }
    
    func load() -> AnyPublisher<[Post], Never>  {
        if FileManager.default.fileExists(atPath: localFile.standardizedFileURL.path) {
            return Future<[Post], Never> { promise in
                self.load(self.localFile) { posts in
                    DispatchQueue.main.async {
                        promise(.success(posts))
                    }
                }
            }.eraseToAnyPublisher()
        } else {
            return loadDefault()
        }
    }
    
    func save(posts: [Post]) {
        let envelope = Envelope(posts: posts)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(envelope)
        try! data.write(to: localFile)
    }
    func saveFavorites(posts: [Post]) {
        let envelope = Envelope(posts: posts)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(envelope)
        try! data.write(to: localFavoritesFile)
    }
    
    private func loadSynchronously(_ file: URL) -> [Post] {
        do {
            let data = try Data(contentsOf: file)
            let envelope = try JSONDecoder().decode(Envelope.self, from: data)
            return envelope.posts
        } catch {
            clear()
            return loadSynchronously(defaultFile)
        }
    }
    private func load(_ file: URL, completion: @escaping ([Post]) -> Void) {
        DispatchQueue.main.async {
            let posts = self.loadSynchronously(file)
            completion(posts)
        }
    }
    private func loadFavorite(_ file: URL, completion: @escaping ([Post]) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let posts = self.loadSynchronously(file)
            completion(posts)
        }
    }
    
    func loadDefault(synchronous: Bool = false) -> AnyPublisher<[Post], Never> {
        if synchronous {
            return Just<[Post]>(loadSynchronously(defaultFile)).eraseToAnyPublisher()
        }
        return Future<[Post], Never> { promise in
            self.load(self.defaultFile) { posts in
                DispatchQueue.main.async {
                    promise(.success(posts))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func loadDefaultFavorite(synchronous: Bool = false) -> AnyPublisher<[Post], Never> {
        if synchronous {
            return Just<[Post]>(loadSynchronously(defaultFile)).eraseToAnyPublisher()
        }
        return Future<[Post], Never> { promise in
            self.load(self.defaultFavoriteFile) { posts in
                DispatchQueue.main.async {
                    promise(.success(posts))
                }
            }
        }.eraseToAnyPublisher()
    }
}

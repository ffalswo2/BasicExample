//
//  RealmService.swift
//  SOPT32-Seminar-3
//
//  Created by 김민재 on 2023/05/27.
//

import Foundation

import RealmSwift
import Realm

final class RealmService {

    private let localRealm = try! Realm()

    func addPost(item: PostDTO) {
        let post = RealmStoragePost(input: item)
        if localRealm.isEmpty {
            try! localRealm.write {
                localRealm.add(post)
            }
        } else {
            try! localRealm.write {
                localRealm.add(post, update: .modified)
            }
        }
    }

    func getPosts() -> Results<RealmStoragePost> {
        let savedPosts = localRealm.objects(RealmStoragePost.self)
        return savedPosts
    }

    func deletePost(dto: PostDTO) {

        guard let postToDelete = localRealm.objects(RealmStoragePost.self).filter("id == %@", dto.id).first else { return }
        try! localRealm.write {
            localRealm.delete(postToDelete)
        }
    }

    func checkUniquePost(input: PostDTO) -> Bool {
        let posts = convertToStoragePost(input: getPosts())
        for item in posts {
            if input == item {
                return false
            }
        }
        return true
    }

    func convertToStoragePost(input: Results<RealmStoragePost>) -> [PostDTO] {
        var storagePosts = [PostDTO]()
        let inputSize = input.count
        for index in 0 ..< inputSize {
            let post = PostDTO(
                id: input[index].id,
                img: input[index].img ?? "",
                name: input[index].name ?? "",
                location: input[index].location ?? "",
                date: input[index].date ?? "",
                price: input[index].price ?? "",
                status: input[index].status ?? ""
            )
            storagePosts.append(post)
        }
        return storagePosts
    }

    // 스키마 수정시 한번 돌려야 한다.
    func resetDB(){
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
          realmURL,
          realmURL.appendingPathExtension("lock"),
          realmURL.appendingPathExtension("note"),
          realmURL.appendingPathExtension("management")
        ]

        for URL in realmURLs {
          do {
            try FileManager.default.removeItem(at: URL)
          } catch {
            // handle error
          }
        }
    }

    init() {
        print("Realm Location: ", localRealm.configuration.fileURL ?? "cannot find location.")
    }
}


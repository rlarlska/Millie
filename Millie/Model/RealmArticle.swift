//
//  RealmArticle.swift
//  Millie
//
//  Created by 김기남 on 2024/05/09.
//

import Foundation
import RealmSwift

class RealmArticle: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var sourceId: String?
    @Persisted var sourceName: String
    @Persisted var author: String?
    @Persisted var title: String
    @Persisted var desc: String?
    @Persisted var url: String
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String
    @Persisted var content: String?
    @Persisted var imageData: Data?
    @Persisted var isRead: Bool = false
    
    static func getArticles() throws -> [RealmArticle] {
        let realm = try Realm()
        let objects = realm.objects(RealmArticle.self)
        
        return objects.reversed()
    }
    
    static func getArticle(of title: String) throws -> RealmArticle? {
        let realm = try Realm()
        let objects = realm.objects(RealmArticle.self).filter { $0.title == title }
        
        return objects.first
    }
    
    func add() throws {
        let realm = try Realm()
        
        try realm.write {
            realm.add(self)
        }
    }
    
    func update(imageData: Data) throws {
        let realm = try Realm()
        
        try realm.write {
            self.imageData = imageData
            realm.add(self, update: .modified)
        }
    }
    
    func setRead() throws {
        let realm = try Realm()
        
        try realm.write {
            self.isRead = true
            realm.add(self, update: .modified)
        }
    }
}

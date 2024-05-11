//
//  NewsVIewModel.swift
//  Millie
//
//  Created by 김기남 on 2024/05/07.
//

import UIKit

let apiKey = "51ff84e2516d451fa7b9a897e6127ff0"
class NewsViewModel: ObservableObject {
    @Published var articles = [RealmArticle]()
    
    init() {
        fetch()
    }
    
    /// AF
    private func fetch() {
        let url = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=" + apiKey
        
        getArticles()
        
        AlamofireModel.request(of: News.self, urlString: url) { result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    news.articles.forEach {
                        self.add(article: $0)
                    }
                }
                break
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    /// Realm
    func getArticles() {
        do {
            self.articles = try RealmArticle.getArticles()
        } catch {
            print(String(describing: error))
        }
    }
    
    func add(article: Article) {
        do {
            if let _ = try RealmArticle.getArticle(of: article.title) {
                return
            }
            
            let realmArticle = article.toRealmArticle()
            try realmArticle.add()
            
            self.articles.insert(realmArticle, at: 0)
        } catch {
            print(String(describing: error))
        }
    }
    
    func setRead(realmArticle: RealmArticle) {
        self.articles = self.articles.map {
            if $0.id == realmArticle.id {
                try? realmArticle.setRead()
                return realmArticle
            }
            
            return $0
        }
    }
    
    func updateData(realmArticle: RealmArticle, imageData: Data) {
        self.articles = self.articles.map {
            if $0.id == realmArticle.id {
                try? realmArticle.update(imageData: imageData)
                return realmArticle
            }
            
            return $0
        }
    }
}

extension Article {
    func toRealmArticle() -> RealmArticle {
        let realmArticle = RealmArticle()
        
        realmArticle.sourceId = self.source.id
        realmArticle.sourceName = self.source.name
        realmArticle.author = self.author
        realmArticle.title = self.title
        realmArticle.desc = self.description
        realmArticle.url = self.url
        realmArticle.urlToImage = self.urlToImage
        realmArticle.publishedAt = self.publishedAt
        realmArticle.content = self.content
        
        return realmArticle
    }
}

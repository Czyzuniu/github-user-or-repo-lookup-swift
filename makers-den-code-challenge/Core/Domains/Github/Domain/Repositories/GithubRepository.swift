import Foundation

protocol GithubRepository {
    func getUsersByQuery(params: GithubSearchRequest) async throws -> [GithubUser]
    func getRepositoriesByQuery(params: GithubSearchRequest) async throws -> [GithubRepo]
}


struct GithubSearchRequest {
    let query: String
    let limit: Int
    
    init(query: String, limit: Int) {
        self.query = query
        self.limit = limit
    }
    
    static func withDefault(query: String) -> Self {
        .init(query: query, limit: Constants.AUTOCOMPLETE_MAX_LIMIT)
    }
}

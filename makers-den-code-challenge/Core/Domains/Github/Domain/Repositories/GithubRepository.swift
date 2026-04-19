import Foundation

protocol GithubRepository {
    func getUsersByQuery(params: GithubUserSearchRequest) async throws -> [GithubUser]
    func getRepositoriesByQuery(params: GithubUserSearchRequest) async throws -> [GithubRepo]
}


struct GithubUserSearchRequest {
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

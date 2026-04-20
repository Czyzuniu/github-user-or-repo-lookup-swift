import Foundation

class GithubSearchService {
    let repository: GithubRepository
    
    init(repository: GithubRepository) {
        self.repository = repository
    }
    
    func search(query: String) async throws -> [GitHubSearchResult] {
        async let repos = repository.getRepositoriesByQuery(
            params: GithubUserSearchRequest.withDefault(query: query)
        )
        
        async let users = repository.getUsersByQuery(
            params: GithubUserSearchRequest.withDefault(query: query)
        )
        
        let (reposResult, usersResult) = try await (repos, users)
        
        let repoResults = reposResult.map {
            GitHubSearchResult(id: $0.id, name: $0.repoName, variant: .repository)
        }
        
        let userResults = usersResult.map {
            GitHubSearchResult(id: $0.id, name: $0.profileName, variant: .user)
        }
        
        return (repoResults + userResults)
            .sorted { $0.name < $1.name }
            .prefix(Constants.AUTOCOMPLETE_MAX_LIMIT)
            .map { $0 }
    }
}

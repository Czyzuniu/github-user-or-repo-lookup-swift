import Foundation

class GithubSearchService {
    let repository: GithubRepository
    
    init(repository: GithubRepository) {
        self.repository = repository
    }
    
    func search(query: String) async throws -> [GitHubSearchResult] {
        var users: [GithubUser] = []
        var result: [GitHubSearchResult] = []
        
        let repos = try await self.repository.getRepositoriesByQuery(params: GithubUserSearchRequest.withDefault(query: query))
        
        if (repos.count < Constants.AUTOCOMPLETE_MAX_LIMIT) {
            users = try await repository.getUsersByQuery(
                params: GithubUserSearchRequest(query: query, limit: Constants.AUTOCOMPLETE_MAX_LIMIT - repos.count)
            )
        }
        
        repos.forEach { repo in
            result.append(GitHubSearchResult(id: repo.id, name: repo.repoName, variant: .repository))
        }
        
        users.forEach { user in
            result.append(GitHubSearchResult(id: user.id, name: user.profileName, variant: .user))
        }
        
        return result.sorted { a, b in
            a.name < b.name
        }
    }
}

import Foundation

class GithubSearchService {
    let repository: GithubRepository
    
    init(repository: GithubRepository) {
        self.repository = repository
    }
    
    func search(query: String) async throws -> [GitHubSearchResult] {
        var result: [GitHubSearchResult] = []
        
        let repos = try await self.repository.getRepositoriesByQuery(params: GithubUserSearchRequest.withDefault(query: query))
        let users = try await self.repository.getUsersByQuery(params: GithubUserSearchRequest.withDefault(query: query))
        
        repos.forEach { repo in
            result.append(GitHubSearchResult(id: repo.id, name: repo.repoName, variant: .repository))
        }
        
        users.forEach { user in
            result.append(GitHubSearchResult(id: user.id, name: user.profileName, variant: .user))
        }
        
        let sortedAlphabetically = result.sorted { a, b in
            a.name < b.name
        }
        
        return Array(sortedAlphabetically.prefix(Constants.AUTOCOMPLETE_MAX_LIMIT))
    }
}

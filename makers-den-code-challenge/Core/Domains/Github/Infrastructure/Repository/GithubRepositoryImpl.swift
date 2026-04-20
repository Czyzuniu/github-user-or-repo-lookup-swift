import Foundation

class GithubRepositoryImpl: GithubRepository {
    let githubApi: GitHubApi
    
    init(githubApi: GitHubApi) {
        self.githubApi = githubApi
    }
    
    func getUsersByQuery(params: GithubUserSearchRequest) async throws -> [GithubUser] {
        do {
            let result = try await self.githubApi.getUsers(query: params.query, limit: params.limit)
            return result.items.map { GithubUserModel in
                return GithubUser(id: GithubUserModel.id, profileName: GithubUserModel.login)
            }
        } catch let error as NetworkError {
            switch error {
            case .rateLimit:
                throw GithubSearchError.rateLimit
            default:
                throw GithubSearchError.serverError
            }
        }
    }

    func getRepositoriesByQuery(params: GithubUserSearchRequest) async throws -> [GithubRepo] {
        do {
            let result = try await self.githubApi.getRepo(query: params.query, limit: params.limit)
            return result.items.map { GithubRepositoryModel in
                return GithubRepo(id: GithubRepositoryModel.id, repoName: GithubRepositoryModel.fullName)
            }
        } catch let error as NetworkError {
            switch error {
            case .rateLimit:
                throw GithubSearchError.rateLimit
            default:
                throw GithubSearchError.serverError
            }
        }
    }
}

enum GitHubRepositoryError: Error {
    case genericResponse(message: String)
    case rateLimit(message: String)
}

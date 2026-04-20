import Foundation

protocol GitHubApi {
    func getUsers(query: String, limit: Int) async throws -> GithubSearchUsersResponse
    func getRepo(query: String, limit: Int) async throws -> GithubSearchReposResponse
}

class GitHubApiImpl: GitHubApi {
    func getUsers(query: String, limit: Int) async throws -> GithubSearchUsersResponse {
        let urlString = "\(Constants.GITHUB_API_BASE_URL)/search/users?q=\(query)&per_page=\(limit)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unexpectedError
        }
        
        if httpResponse.statusCode == 200 {
            return try JSONDecoder().decode(GithubSearchUsersResponse.self, from: data)
        } else if (httpResponse.statusCode == 403) {
            throw NetworkError.rateLimit
        } else {
            throw NetworkError.serverError(message: "There was a problem fetching results")
        }
    }

    func getRepo(query: String, limit: Int) async throws -> GithubSearchReposResponse {
        let urlString = "\(Constants.GITHUB_API_BASE_URL)/search/repositories?q=\(query)&per_page=\(limit)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unexpectedError
        }
        
        if httpResponse.statusCode == 200 {
            return try JSONDecoder().decode(GithubSearchReposResponse.self, from: data)
        } else if (httpResponse.statusCode == 403) {
            throw NetworkError.rateLimit
        } else {
            throw NetworkError.serverError(message: "There was a problem fetching results")
        }

    }
}

enum NetworkError: Error {
    case serverError(message: String)
    case unexpectedError
    case rateLimit
}

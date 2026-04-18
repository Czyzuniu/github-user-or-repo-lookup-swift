//
//  GithubRepositoryImpl.swift
//  makers-den-code-challenge
//
//  Created by Konrad Kolpak on 17/04/2026.
//

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
        } catch {
            throw GitHubRepositoryError.genericResponse(message: "There was a problem fetching users from GitHub")
        }

    }

    func getRepositoriesByQuery(params: GithubUserSearchRequest) async throws -> [GithubRepo] {
        do {
            let result = try await self.githubApi.getRepo(query: params.query, limit: params.limit)
            return result.items.map { GithubRepositoryModel in
                return GithubRepo(id: GithubRepositoryModel.id, repoName: GithubRepositoryModel.fullName)
            }
        } catch {
            throw GitHubRepositoryError.genericResponse(message: "There was a problem fetching repositories from GitHub")
        }
    }
}


enum GitHubRepositoryError: Error {
    case genericResponse(message: String)
}

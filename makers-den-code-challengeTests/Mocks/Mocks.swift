import Foundation
@testable import makers_den_code_challenge


final class MockGitHubApi: GitHubApi {
    var getUsersHandler: ((String, Int) async throws -> GithubSearchUsersResponse)!
    var getRepoHandler: ((String, Int) async throws -> GithubSearchReposResponse)!

    func getUsers(query: String, limit: Int) async throws -> GithubSearchUsersResponse {
        return try await getUsersHandler(query, limit)
    }

    func getRepo(query: String, limit: Int) async throws -> GithubSearchReposResponse {
        return try await getRepoHandler(query, limit)
    }
}

extension GithubRepoOwner {
    static func mock(
        login: String = "apple",
        id: Int = 1,
        avatarUrl: String = "https://avatars.githubusercontent.com/u/1"
    ) -> GithubRepoOwner {
        GithubRepoOwner(
            login: login,
            id: id,
            avatarUrl: avatarUrl
        )
    }
}

extension GithubRepoModel {
    static func mock(
        id: Int = 1,
        name: String = "swift",
        fullName: String = "apple/swift",
        isPrivate: Bool = false,
        owner: GithubRepoOwner = GithubRepoOwner.mock(),
        htmlUrl: String = "https://github.com/apple/swift",
        description: String? = "Swift programming language",
        isFork: Bool = false,
        url: String = "https://api.github.com/repos/apple/swift",
        stargazersCount: Int = 1000,
        watchersCount: Int = 1000,
        language: String? = "Swift"
    ) -> GithubRepoModel {
        GithubRepoModel(
            id: id,
            name: name,
            fullName: fullName,
            isPrivate: isPrivate,
            owner: owner,
            htmlUrl: htmlUrl,
            description: description,
            isFork: isFork,
            url: url,
            stargazersCount: stargazersCount,
            watchersCount: watchersCount,
            language: language
        )
    }
}

extension GithubUserModel {
    static func mock(
        login: String = "octocat",
        id: Int = 1,
        nodeId: String = "MDQ6VXNlcjE=",
        avatarUrl: String = "https://github.com/images/error/octocat_happy.gif",
        gravatarId: String = "",
        url: String = "https://api.github.com/users/octocat",
        htmlUrl: String = "https://github.com/octocat",
        followersUrl: String = "https://api.github.com/users/octocat/followers",
        followingUrl: String = "https://api.github.com/users/octocat/following{/other_user}",
        gistsUrl: String = "https://api.github.com/users/octocat/gists{/gist_id}",
        starredUrl: String = "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        subscriptionsUrl: String = "https://api.github.com/users/octocat/subscriptions",
        organizationsUrl: String = "https://api.github.com/users/octocat/orgs",
        reposUrl: String = "https://api.github.com/users/octocat/repos",
        eventsUrl: String = "https://api.github.com/users/octocat/events{/privacy}",
        receivedEventsUrl: String = "https://api.github.com/users/octocat/received_events",
        type: String = "User",
        siteAdmin: Bool = false
    ) -> GithubUserModel {
        GithubUserModel(
            login: login,
            id: id,
            nodeId: nodeId,
            avatarUrl: avatarUrl,
            gravatarId: gravatarId,
            url: url,
            htmlUrl: htmlUrl,
            followersUrl: followersUrl,
            followingUrl: followingUrl,
            gistsUrl: gistsUrl,
            starredUrl: starredUrl,
            subscriptionsUrl: subscriptionsUrl,
            organizationsUrl: organizationsUrl,
            reposUrl: reposUrl,
            eventsUrl: eventsUrl,
            receivedEventsUrl: receivedEventsUrl,
            type: type,
            siteAdmin: siteAdmin
        )
    }
}

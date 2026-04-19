import Foundation

struct GithubRepo {
    let id: Int
    let repoName: String
}

struct GithubUser {
    let id: Int
    let profileName: String
}

struct GitHubSearchResult {
    let id: Int
    let name: String
    let variant: GithubVariant
}

enum GithubVariant {
    case repository
    case user
}

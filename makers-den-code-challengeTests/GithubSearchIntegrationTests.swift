//
//  GithubSearchViewModelTests.swift
//  makers-den-code-challengeTests
//
//  Created by Konrad Kolpak on 18/04/2026.
//

import Testing
@testable import makers_den_code_challenge

struct GithubSearchIntegrationTests {

    @Test func testShouldNotCallTheApiWhenTypedLessThen3Characters() async throws {
        
        let mockGitHubApi = MockGitHubApi()
        
        let viewModel = await GithubSearchViewModel(
            state: GithubSearchState(),
            service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: mockGitHubApi)),
            debounceDuration: 0
        )
        
        await viewModel.onSearchInputChanged("AB")
        
        await #expect(viewModel.state.searchQuery == "AB")
        if case .idle = await viewModel.state.status {
            #expect(true)
        } else {
            Issue.record("Expected idle state")
        }
    }
    
    @Test func testShouldCallTheApiWhenTypedMoreThen2CharactersAndReturnMergedReposAndUsersAndSortAlphabeticallyByName() async throws {
        
        let mockGitHubApi = MockGitHubApi()
        
        mockGitHubApi.getRepoHandler = { _, _ in
            return GithubSearchReposResponse(totalCount: 2,
                                             incompleteResults: true,
                                             items: [GithubRepoModel.mock(id: 1, fullName: "a"), GithubRepoModel.mock(id: 2, fullName: "b")])
        }
        
        mockGitHubApi.getUsersHandler = { _, _ in
            return GithubSearchUsersResponse(totalCount: 2,
                                             incompleteResults: true,
                                             items: [GithubUserModel.mock(login: "c", id: 3), GithubUserModel.mock(login: "d", id: 4)])
        }
        
        let viewModel = await GithubSearchViewModel(
            state: GithubSearchState(),
            service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: mockGitHubApi)),
            debounceDuration: 0
        )
        
        await viewModel.onSearchInputChanged("ABC")
        
        await #expect(viewModel.state.searchQuery == "ABC")
                
        if case let .success(results) = await viewModel.state.status {
            #expect(results.count == 4)
            #expect(results[0].name == "a")
            #expect(results[1].name == "b")
            #expect(results[2].name == "c")
            #expect(results[3].name == "d")
        }
    }
    
    @Test func testShouldReturnEmptyStatusWhenNoResultsFound() async throws {
        
        let mockGitHubApi = MockGitHubApi()
        
        mockGitHubApi.getRepoHandler = { _, _ in
            return GithubSearchReposResponse(totalCount: 0,
                                             incompleteResults: true,
                                             items: [])
        }
        
        mockGitHubApi.getUsersHandler = { _, _ in
            return GithubSearchUsersResponse(totalCount: 0,
                                             incompleteResults: false,
                                             items: [])
        }
        
        let viewModel = await GithubSearchViewModel(
            state: GithubSearchState(),
            service: GithubSearchService(repository: GithubRepositoryImpl(githubApi: mockGitHubApi)),
            debounceDuration: 0
        )
        
        await viewModel.onSearchInputChanged("XXXXXXXXXX")
        
        await #expect(viewModel.state.searchQuery == "XXXXXXXXXX")
            
        
        if case .noresults = await viewModel.state.status {
            #expect(true)
        } else {
            Issue.record("Expected no results state")
        }
    }

}

Github search via repo name or username built using iOS with Swift UI + Clean Architecture

General structure:
- makers-den-code-challenge
    - Core/Domains
        - holds the domain models/protocols across different domains, e.g Auth, Github etc
    - Features
        - feature based structure which holds states, components, and pages tied specifically to a particular feature
    - UI 
        - Holds components in our core design system of the app, these should be used to create other feature specific components as a base
    - Utilities
        - Holds small helper methods or constants, this could be moved into specific domains if the app grows

Testing:
- makers-den-code-challengeTests
    - Mocks - hold methods to create objects which can be used for previews or tests
    - GithubSearchIntegrationTests - integration tests starting all the way from the viewmodel -> service -> repository -> api

-makers-den-code-challenge/Features/GithubSearch/Presentation/Pages/GithubSearchPage 
    -Holds previews for different states


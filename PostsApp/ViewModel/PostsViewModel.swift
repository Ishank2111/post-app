import Foundation

@MainActor
final class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var favorites: [Post] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private let apiService = APIService()
    
    var filteredPosts: [Post] {
        if searchText.isEmpty {
            return posts
        } else {
            return posts.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func fetchPosts() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            posts = try await apiService.fetchPosts()
        } catch {
            print("Error fetching posts:", error)
        }
    }
    
    func toggleFavorite(_ post: Post) {
        if favorites.contains(post) {
            favorites.removeAll { $0 == post }
        } else {
            favorites.append(post)
        }
    }
    
    func isFavorite(_ post: Post) -> Bool {
        favorites.contains(post)
    }
}

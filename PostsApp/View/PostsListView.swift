import SwiftUI

struct PostsListView: View {
    @StateObject private var viewModel = PostsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showFavorites = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 12)
                    
                    TextField("Search by title...", text: $viewModel.searchText)
                        .textFieldStyle(.plain)
                    
                    if !viewModel.searchText.isEmpty {
                        Button {
                            viewModel.searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                }
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                ZStack {
                    List(viewModel.filteredPosts) { post in
                        NavigationLink(destination: PostDetailView(post: post, viewModel: viewModel)) {
                            PostRowView(post: post, viewModel: viewModel)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.fetchPosts()
                    }
                    .overlay {
                        if viewModel.filteredPosts.isEmpty && !viewModel.searchText.isEmpty && !viewModel.isLoading {
                            ContentUnavailableView(
                                "No Results",
                                systemImage: "magnifyingglass",
                                description: Text("No posts found matching '\(viewModel.searchText)'")
                            )
                        }
                    }
                    
                    if viewModel.isLoading {
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.5)
                                .tint(.green)
                            
                            Text("Loading Posts...")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGroupedBackground).opacity(0.9))
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Posts")
                        .font(.custom("poppins_bold", size: 18))
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFavorites = true
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            
                            if !viewModel.favorites.isEmpty {
                                Text("\(viewModel.favorites.count)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(isPresented: $showFavorites) {
                FavoritesView(viewModel: viewModel)
            }
            .task {
                await viewModel.fetchPosts()
            }
        }
    }
}

struct PostRowView: View {
    let post: Post
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color.green.opacity(0.2))
                .frame(width: 44, height: 44)
                .overlay {
                    Text("\(post.userId)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.green)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(post.title.capitalized)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("User ID: \(post.userId)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                viewModel.toggleFavorite(post)
            } label: {
                Image(systemName: viewModel.isFavorite(post) ? "heart.fill" : "heart")
                    .font(.system(size: 20))
                    .foregroundColor(viewModel.isFavorite(post) ? .red : .gray)
                    .contentTransition(.symbolEffect(.replace))
            }
            .buttonStyle(.plain)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    PostsListView()
}

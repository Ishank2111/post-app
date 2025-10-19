import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: PostsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if viewModel.favorites.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart.slash",
                        description: Text("Posts you favorite will appear here")
                    )
                } else {
                    List(viewModel.favorites) { post in
                        NavigationLink(destination: PostDetailView(post: post, viewModel: viewModel)) {
                            PostRowView(post: post, viewModel: viewModel)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                    .listStyle(.plain)
                }
            }
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
                ToolbarItem(placement: .principal) {
                    Text("Favorites")
                        .font(.custom("poppins_bold", size: 18))
                        .foregroundColor(.white)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    FavoritesView(viewModel: PostsViewModel())
}

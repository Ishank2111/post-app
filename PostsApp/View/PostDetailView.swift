import SwiftUI

struct PostDetailView: View {
    let post: Post
    @ObservedObject var viewModel: PostsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(post.title.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                }
                
                Divider()
                
                Text(post.body)
                    .font(.body)
                    .lineSpacing(4)
                    .foregroundColor(.primary.opacity(0.85))
                
                Spacer()
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom) {
            Button {
                viewModel.toggleFavorite(post)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: viewModel.isFavorite(post) ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite(post) ? .red : .white)
                    
                    Text(viewModel.isFavorite(post) ? "Remove from Favorites" : "Add to Favorites")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.green)
                .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(.systemGroupedBackground))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            ToolbarItem(placement: .principal) {
                Text("Post Detail")
                    .font(.custom("poppins_bold", size: 18))
                    .foregroundColor(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.green, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
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
    NavigationStack {
        PostDetailView(
            post: Post(userId: 1, id: 1, title: "Sample Post Title", body: "This is a sample post body."),
            viewModel: PostsViewModel()
        )
    }
}

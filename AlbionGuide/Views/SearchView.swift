import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView("데이터 로딩 중...")
                } else if searchText.isEmpty {
                    emptySearchView
                } else if !viewModel.hasResults {
                    noResultsView
                } else {
                    searchResults
                }
            }
            .navigationTitle("검색")
            .searchable(text: $searchText, prompt: "무기, 방어구, 악세서리 검색")
            .onChange(of: searchText) { _, newValue in
                viewModel.searchText = newValue
                viewModel.search()
            }
        }
    }
    
    private var emptySearchView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundStyle(.tertiary)
            
            Text("무기, 방어구, 악세서리를\n검색해보세요")
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    private var noResultsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundStyle(.tertiary)
            
            Text("'\(searchText)'에 대한\n검색 결과가 없습니다")
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    private var searchResults: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                if !viewModel.weapons.isEmpty {
                    SearchSection(title: "무기", count: viewModel.weapons.count) {
                        ForEach(viewModel.weapons.prefix(10)) { weapon in
                            NavigationLink(destination: WeaponDetailView(weapon: weapon)) {
                                SearchResultRow(
                                    icon: weapon.icon,
                                    name: weapon.name,
                                    tier: weapon.tierNumber,
                                    itemPower: weapon.itemPower
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                if !viewModel.armors.isEmpty {
                    SearchSection(title: "방어구", count: viewModel.armors.count) {
                        ForEach(viewModel.armors.prefix(10)) { armor in
                            NavigationLink(destination: ArmorDetailView(armor: armor)) {
                                SearchResultRow(
                                    icon: armor.icon,
                                    name: armor.name,
                                    tier: Int(armor.tier.components(separatedBy: ".").first ?? "0") ?? 0,
                                    itemPower: armor.itemPower
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                if !viewModel.accessories.isEmpty {
                    SearchSection(title: "악세서리", count: viewModel.accessories.count) {
                        ForEach(viewModel.accessories.prefix(10)) { accessory in
                            SearchResultRow(
                                icon: accessory.icon,
                                name: accessory.name,
                                tier: Int(accessory.tier.components(separatedBy: ".").first ?? "0") ?? 0,
                                itemPower: accessory.itemPower
                            )
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct SearchSection<Content: View>: View {
    let title: String
    let count: Int
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Text("\(count)개")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(Capsule())
            }
            
            VStack(spacing: 8) {
                content()
            }
        }
    }
}

struct SearchResultRow: View {
    let icon: String
    let name: String
    let tier: Int
    let itemPower: Int
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: icon)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                default:
                    Image(systemName: "questionmark.circle")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 44, height: 44)
            .background(Color(.tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                HStack(spacing: 8) {
                    Text("T\(tier)")
                        .font(.caption2.bold())
                        .foregroundStyle(.orange)
                    
                    Text("IP \(itemPower)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SearchView()
        .environmentObject(LocalStorageService.shared)
}

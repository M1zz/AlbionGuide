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
                    ProgressView(String(localized: "loading_data"))
                } else if searchText.isEmpty {
                    emptySearchView
                } else if !viewModel.hasResults {
                    noResultsView
                } else {
                    searchResults
                }
            }
            .navigationTitle(String(localized: "search"))
            .searchable(text: $searchText, prompt: String(localized: "search_all"))
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

            Text(String(localized: "search_hint"))
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

            Text(String(localized: "no_results_for \(searchText)"))
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private var searchResults: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                if !viewModel.weapons.isEmpty {
                    SearchSection(title: String(localized: "weapons"), count: viewModel.weapons.count) {
                        ForEach(viewModel.weapons.prefix(10)) { weapon in
                            NavigationLink(destination: WeaponDetailView(weapon: weapon)) {
                                SearchResultRow(
                                    icon: weapon.icon,
                                    name: weapon.localizedName,
                                    tier: weapon.tierNumber,
                                    itemPower: weapon.itemPower
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                if !viewModel.armors.isEmpty {
                    SearchSection(title: String(localized: "armor"), count: viewModel.armors.count) {
                        ForEach(viewModel.armors.prefix(10)) { armor in
                            NavigationLink(destination: ArmorDetailView(armor: armor)) {
                                SearchResultRow(
                                    icon: armor.icon,
                                    name: armor.localizedName,
                                    tier: Int(armor.tier.components(separatedBy: ".").first ?? "0") ?? 0,
                                    itemPower: armor.itemPower
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                if !viewModel.accessories.isEmpty {
                    SearchSection(title: String(localized: "accessories"), count: viewModel.accessories.count) {
                        ForEach(viewModel.accessories.prefix(10)) { accessory in
                            SearchResultRow(
                                icon: accessory.icon,
                                name: accessory.localizedName,
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

                Text(String(localized: "\(count) items"))
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

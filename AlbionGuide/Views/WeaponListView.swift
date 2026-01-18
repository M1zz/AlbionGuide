import SwiftUI

struct WeaponListView: View {
    @StateObject private var viewModel = WeaponListViewModel()
    @EnvironmentObject private var storage: LocalStorageService
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.weapons.isEmpty {
                    ProgressView("무기 정보 로딩 중...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        Task { await viewModel.loadInitialData() }
                    }
                } else {
                    weaponList
                }
            }
            .navigationTitle("무기")
            .searchable(text: $viewModel.searchText, prompt: "무기 검색")
            .onChange(of: viewModel.searchText) { _, _ in
                viewModel.applyFilters()
            }
            .refreshable {
                await viewModel.refresh()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        tierFilterMenu
                    } label: {
                        Label("필터", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
    
    private var weaponList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.filteredWeapons) { weapon in
                    NavigationLink(destination: WeaponDetailView(weapon: weapon)) {
                        WeaponRowView(weapon: weapon)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
    
    private var tierFilterMenu: some View {
        Menu("티어 필터") {
            Button("전체") {
                viewModel.selectedTier = nil
                viewModel.applyFilters()
            }
            
            ForEach(viewModel.tiers, id: \.self) { tier in
                Button("T\(tier)") {
                    viewModel.selectedTier = tier
                    viewModel.applyFilters()
                }
            }
        }
    }
}

struct WeaponRowView: View {
    let weapon: Weapon
    @EnvironmentObject private var storage: LocalStorageService
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: weapon.icon)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                case .failure:
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .frame(width: 60, height: 60)
                @unknown default:
                    EmptyView()
                }
            }
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(weapon.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                HStack(spacing: 8) {
                    TierBadge(tier: weapon.tierNumber, enchantment: weapon.enchantment)
                    
                    Text("IP \(weapon.itemPower)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                storage.toggleFavoriteWeapon(weapon.id)
            } label: {
                Image(systemName: storage.isWeaponFavorite(weapon.id) ? "star.fill" : "star")
                    .foregroundStyle(storage.isWeaponFavorite(weapon.id) ? .yellow : .secondary)
            }
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TierBadge: View {
    let tier: Int
    let enchantment: Int
    
    var tierColor: Color {
        switch tier {
        case 1: return .gray
        case 2: return .green
        case 3: return .blue
        case 4: return .purple
        case 5: return .red
        case 6: return .orange
        case 7: return .yellow
        case 8: return .pink
        default: return .gray
        }
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Text("T\(tier)")
                .font(.caption.bold())
            
            if enchantment > 0 {
                Text(".\(enchantment)")
                    .font(.caption2)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(tierColor.opacity(0.2))
        .foregroundStyle(tierColor)
        .clipShape(Capsule())
    }
}

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            
            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Button("다시 시도", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    WeaponListView()
        .environmentObject(LocalStorageService.shared)
}

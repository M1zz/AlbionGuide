import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var storage: LocalStorageService
    @StateObject private var viewModel = FavoritesViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("카테고리", selection: $selectedTab) {
                    Text("무기").tag(0)
                    Text("방어구").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if selectedTab == 0 {
                    favoriteWeaponsList
                } else {
                    favoriteArmorsList
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("즐겨찾기")
            .task {
                await viewModel.loadFavorites(
                    weaponIds: Array(storage.favoriteWeaponIds),
                    armorIds: Array(storage.favoriteArmorIds)
                )
            }
            .onChange(of: storage.favoriteWeaponIds) { _, newIds in
                Task {
                    await viewModel.loadFavorites(
                        weaponIds: Array(newIds),
                        armorIds: Array(storage.favoriteArmorIds)
                    )
                }
            }
            .onChange(of: storage.favoriteArmorIds) { _, newIds in
                Task {
                    await viewModel.loadFavorites(
                        weaponIds: Array(storage.favoriteWeaponIds),
                        armorIds: Array(newIds)
                    )
                }
            }
        }
    }
    
    private var favoriteWeaponsList: some View {
        Group {
            if viewModel.favoriteWeapons.isEmpty {
                emptyView(message: "즐겨찾기한 무기가 없습니다")
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.favoriteWeapons) { weapon in
                            NavigationLink(destination: WeaponDetailView(weapon: weapon)) {
                                WeaponRowView(weapon: weapon)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private var favoriteArmorsList: some View {
        Group {
            if viewModel.favoriteArmors.isEmpty {
                emptyView(message: "즐겨찾기한 방어구가 없습니다")
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.favoriteArmors) { armor in
                            NavigationLink(destination: ArmorDetailView(armor: armor)) {
                                ArmorRowView(armor: armor)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private func emptyView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "star.slash")
                .font(.system(size: 50))
                .foregroundStyle(.tertiary)
            
            Text(message)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("아이템 상세 화면에서 별 아이콘을 눌러\n즐겨찾기에 추가하세요")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoriteWeapons: [Weapon] = []
    @Published var favoriteArmors: [Armor] = []
    @Published var isLoading = false
    
    private let api = OpenAlbionAPI.shared
    private var allWeapons: [Weapon] = []
    private var allArmors: [Armor] = []
    
    func loadFavorites(weaponIds: [Int], armorIds: [Int]) async {
        isLoading = true
        
        if allWeapons.isEmpty {
            do {
                allWeapons = try await api.fetchWeapons()
            } catch {
                // 에러 무시
            }
        }
        
        if allArmors.isEmpty {
            do {
                allArmors = try await api.fetchArmors()
            } catch {
                // 에러 무시
            }
        }
        
        favoriteWeapons = allWeapons.filter { weaponIds.contains($0.id) }
        favoriteArmors = allArmors.filter { armorIds.contains($0.id) }
        
        isLoading = false
    }
}

#Preview {
    FavoritesView()
        .environmentObject(LocalStorageService.shared)
}

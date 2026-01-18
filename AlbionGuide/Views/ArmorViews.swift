import SwiftUI

struct ArmorListView: View {
    @StateObject private var viewModel = ArmorListViewModel()
    @EnvironmentObject private var storage: LocalStorageService
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.armors.isEmpty {
                    ProgressView("방어구 정보 로딩 중...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        Task { await viewModel.loadArmors() }
                    }
                } else {
                    armorList
                }
            }
            .navigationTitle("방어구")
            .searchable(text: $viewModel.searchText, prompt: "방어구 검색")
            .onChange(of: viewModel.searchText) { _, _ in
                viewModel.applyFilters()
            }
            .refreshable {
                await viewModel.refresh()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        categoryFilterMenu
                        tierFilterMenu
                    } label: {
                        Label("필터", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
    
    private var armorList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.filteredArmors) { armor in
                    NavigationLink(destination: ArmorDetailView(armor: armor)) {
                        ArmorRowView(armor: armor)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
    
    private var categoryFilterMenu: some View {
        Menu("카테고리") {
            ForEach(ArmorListViewModel.ArmorCategory.allCases, id: \.self) { category in
                Button {
                    viewModel.selectedCategory = category
                    viewModel.applyFilters()
                } label: {
                    HStack {
                        Text(category.rawValue)
                        if viewModel.selectedCategory == category {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
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

struct ArmorRowView: View {
    let armor: Armor
    @EnvironmentObject private var storage: LocalStorageService
    
    var tierNumber: Int {
        Int(armor.tier.components(separatedBy: ".").first ?? "0") ?? 0
    }
    
    var enchantment: Int {
        Int(armor.tier.components(separatedBy: ".").last ?? "0") ?? 0
    }
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: armor.icon)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                default:
                    Image(systemName: "tshirt.fill")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .frame(width: 60, height: 60)
                }
            }
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(armor.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                HStack(spacing: 8) {
                    TierBadge(tier: tierNumber, enchantment: enchantment)
                    
                    Text("IP \(armor.itemPower)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                storage.toggleFavoriteArmor(armor.id)
            } label: {
                Image(systemName: storage.isArmorFavorite(armor.id) ? "star.fill" : "star")
                    .foregroundStyle(storage.isArmorFavorite(armor.id) ? .yellow : .secondary)
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

struct ArmorDetailView: View {
    @StateObject private var viewModel: ArmorDetailViewModel
    @EnvironmentObject private var storage: LocalStorageService
    
    init(armor: Armor) {
        _viewModel = StateObject(wrappedValue: ArmorDetailViewModel(armor: armor))
    }
    
    var tierNumber: Int {
        Int(viewModel.armor.tier.components(separatedBy: ".").first ?? "0") ?? 0
    }
    
    var enchantment: Int {
        Int(viewModel.armor.tier.components(separatedBy: ".").last ?? "0") ?? 0
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                armorHeader
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 40)
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        Task { await viewModel.loadSpells() }
                    }
                } else {
                    spellsContent
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(viewModel.armor.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    storage.toggleFavoriteArmor(viewModel.armor.id)
                } label: {
                    Image(systemName: storage.isArmorFavorite(viewModel.armor.id) ? "star.fill" : "star")
                        .foregroundStyle(storage.isArmorFavorite(viewModel.armor.id) ? .yellow : .secondary)
                }
            }
        }
    }
    
    private var armorHeader: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: viewModel.armor.icon)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                default:
                    Image(systemName: "tshirt.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.secondary)
                        .frame(width: 120, height: 120)
                }
            }
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
            
            Text(viewModel.armor.name)
                .font(.title2.bold())
            
            HStack(spacing: 12) {
                TierBadge(tier: tierNumber, enchantment: enchantment)
                
                Label("\(viewModel.armor.itemPower)", systemImage: "bolt.fill")
                    .font(.subheadline)
                    .foregroundStyle(.orange)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemGroupedBackground))
    }
    
    private var spellsContent: some View {
        VStack(spacing: 16) {
            if viewModel.spellSlots.isEmpty {
                Text("스킬 정보가 없습니다")
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                ForEach(viewModel.spellSlots) { slot in
                    ArmorSpellSlotSection(slot: slot)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ArmorSpellSlotSection: View {
    let slot: SpellSlot
    @State private var expandedSpell: Int?
    
    var slotName: String {
        switch slot.slot {
        case "First Slot": return "D 스킬"
        case "Passive": return "패시브"
        default: return slot.slot
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(slotName)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            ForEach(slot.spells) { spell in
                SpellCardView(spell: spell, isExpanded: expandedSpell == spell.id) {
                    withAnimation(.spring(response: 0.3)) {
                        expandedSpell = expandedSpell == spell.id ? nil : spell.id
                    }
                }
            }
        }
    }
}

#Preview {
    ArmorListView()
        .environmentObject(LocalStorageService.shared)
}

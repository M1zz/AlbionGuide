import Foundation
import SwiftUI

@MainActor
class WeaponListViewModel: ObservableObject {
    @Published var weapons: [Weapon] = []
    @Published var filteredWeapons: [Weapon] = []
    @Published var categories: [Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    @Published var selectedTier: Int?
    @Published var selectedCategoryId: Int?
    
    private let api = OpenAlbionAPI.shared
    
    var tiers: [Int] {
        Array(Set(weapons.map { $0.tierNumber })).sorted()
    }
    
    init() {
        Task {
            await loadInitialData()
        }
    }
    
    func loadInitialData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let weaponsTask = api.fetchWeapons()
            async let categoriesTask = api.fetchCategories()
            
            let (fetchedWeapons, fetchedCategories) = try await (weaponsTask, categoriesTask)
            
            weapons = fetchedWeapons
            categories = fetchedCategories
            applyFilters()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func applyFilters() {
        var result = weapons
        
        if !searchText.isEmpty {
            result = result.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        if let tier = selectedTier {
            result = result.filter { $0.tierNumber == tier }
        }
        
        filteredWeapons = result.sorted { $0.tierNumber < $1.tierNumber }
    }
    
    func refresh() async {
        await api.clearCache()
        await loadInitialData()
    }
}

@MainActor
class WeaponDetailViewModel: ObservableObject {
    @Published var weapon: Weapon
    @Published var spellSlots: [SpellSlot] = []
    @Published var stats: [WeaponStatEnchantment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedEnchantment: Int = 0
    @Published var selectedQuality: String = "Normal"
    
    private let api = OpenAlbionAPI.shared
    
    let qualities = ["Normal", "Good", "Outstanding", "Excellent", "Masterpiece"]
    
    init(weapon: Weapon) {
        self.weapon = weapon
        Task {
            await loadDetails()
        }
    }
    
    func loadDetails() async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let spellsTask = api.fetchWeaponSpells(weaponId: weapon.id)
            async let statsTask = api.fetchWeaponStats(weaponId: weapon.id)
            
            let (fetchedSpells, fetchedStats) = try await (spellsTask, statsTask)
            
            spellSlots = fetchedSpells
            stats = fetchedStats
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    var currentStats: [StatValue]? {
        guard let enchantmentData = stats.first(where: { $0.enchantment == selectedEnchantment }),
              let qualityData = enchantmentData.stats.first(where: { $0.quality == selectedQuality }) else {
            return nil
        }
        return qualityData.stats
    }
    
    var availableEnchantments: [Int] {
        stats.map { $0.enchantment }.sorted()
    }
}

@MainActor
class ArmorListViewModel: ObservableObject {
    @Published var armors: [Armor] = []
    @Published var filteredArmors: [Armor] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    @Published var selectedTier: Int?
    @Published var selectedCategory: ArmorCategory = .all
    
    enum ArmorCategory: String, CaseIterable {
        case all = "전체"
        case head = "머리"
        case chest = "갑옷"
        case shoes = "신발"
        case cape = "망토"
    }
    
    private let api = OpenAlbionAPI.shared
    
    var tiers: [Int] {
        Array(Set(armors.map { Int($0.tier.components(separatedBy: ".").first ?? "0") ?? 0 })).sorted()
    }
    
    init() {
        Task {
            await loadArmors()
        }
    }
    
    func loadArmors() async {
        isLoading = true
        errorMessage = nil
        
        do {
            armors = try await api.fetchArmors()
            applyFilters()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func applyFilters() {
        var result = armors
        
        if !searchText.isEmpty {
            result = result.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        if let tier = selectedTier {
            result = result.filter {
                Int($0.tier.components(separatedBy: ".").first ?? "0") == tier
            }
        }
        
        switch selectedCategory {
        case .all:
            break
        case .head:
            result = result.filter { $0.name.contains("Hood") || $0.name.contains("Helmet") || $0.name.contains("Cowl") || $0.name.contains("Cap") }
        case .chest:
            result = result.filter { $0.name.contains("Jacket") || $0.name.contains("Armor") || $0.name.contains("Robe") || $0.name.contains("Garb") }
        case .shoes:
            result = result.filter { $0.name.contains("Boots") || $0.name.contains("Sandals") || $0.name.contains("Shoes") }
        case .cape:
            result = result.filter { $0.name.contains("Cape") || $0.name.contains("Cloak") }
        }
        
        filteredArmors = result
    }
    
    func refresh() async {
        await api.clearCache()
        await loadArmors()
    }
}

@MainActor
class ArmorDetailViewModel: ObservableObject {
    @Published var armor: Armor
    @Published var spellSlots: [SpellSlot] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let api = OpenAlbionAPI.shared
    
    init(armor: Armor) {
        self.armor = armor
        Task {
            await loadSpells()
        }
    }
    
    func loadSpells() async {
        isLoading = true
        errorMessage = nil
        
        do {
            spellSlots = try await api.fetchArmorSpells(armorId: armor.id)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var weapons: [Weapon] = []
    @Published var armors: [Armor] = []
    @Published var accessories: [Accessory] = []
    @Published var isLoading = false
    
    private let api = OpenAlbionAPI.shared
    private var allWeapons: [Weapon] = []
    private var allArmors: [Armor] = []
    private var allAccessories: [Accessory] = []
    
    init() {
        Task {
            await loadAllData()
        }
    }
    
    func loadAllData() async {
        isLoading = true
        
        do {
            async let weaponsTask = api.fetchWeapons()
            async let armorsTask = api.fetchArmors()
            async let accessoriesTask = api.fetchAccessories()
            
            let (w, a, acc) = try await (weaponsTask, armorsTask, accessoriesTask)
            allWeapons = w
            allArmors = a
            allAccessories = acc
        } catch {
            // 에러 무시
        }
        
        isLoading = false
    }
    
    func search() {
        guard !searchText.isEmpty else {
            weapons = []
            armors = []
            accessories = []
            return
        }
        
        let query = searchText.lowercased()
        
        weapons = allWeapons.filter { $0.name.lowercased().contains(query) }
        armors = allArmors.filter { $0.name.lowercased().contains(query) }
        accessories = allAccessories.filter { $0.name.lowercased().contains(query) }
    }
    
    var hasResults: Bool {
        !weapons.isEmpty || !armors.isEmpty || !accessories.isEmpty
    }
    
    var totalResults: Int {
        weapons.count + armors.count + accessories.count
    }
}

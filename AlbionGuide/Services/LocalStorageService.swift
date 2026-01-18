import Foundation

class LocalStorageService: ObservableObject {
    static let shared = LocalStorageService()
    
    @Published var builds: [Build] = []
    @Published var favoriteWeaponIds: Set<Int> = []
    @Published var favoriteArmorIds: Set<Int> = []
    @Published var favoriteSpellIds: Set<Int> = []
    @Published var recentViewedWeaponIds: [Int] = []
    
    private let buildsKey = "savedBuilds"
    private let favoriteWeaponsKey = "favoriteWeapons"
    private let favoriteArmorsKey = "favoriteArmors"
    private let favoriteSpellsKey = "favoriteSpells"
    private let recentViewedKey = "recentViewed"
    
    private init() {
        loadAll()
    }
    
    private func loadAll() {
        loadBuilds()
        loadFavorites()
        loadRecentViewed()
    }
    
    private func loadBuilds() {
        guard let data = UserDefaults.standard.data(forKey: buildsKey),
              let decoded = try? JSONDecoder().decode([Build].self, from: data) else {
            return
        }
        builds = decoded
    }
    
    func saveBuilds() {
        guard let encoded = try? JSONEncoder().encode(builds) else { return }
        UserDefaults.standard.set(encoded, forKey: buildsKey)
    }
    
    func addBuild(_ build: Build) {
        builds.insert(build, at: 0)
        saveBuilds()
    }
    
    func updateBuild(_ build: Build) {
        if let index = builds.firstIndex(where: { $0.id == build.id }) {
            var updated = build
            updated.updatedAt = Date()
            builds[index] = updated
            saveBuilds()
        }
    }
    
    func deleteBuild(_ build: Build) {
        builds.removeAll { $0.id == build.id }
        saveBuilds()
    }
    
    private func loadFavorites() {
        favoriteWeaponIds = Set(UserDefaults.standard.array(forKey: favoriteWeaponsKey) as? [Int] ?? [])
        favoriteArmorIds = Set(UserDefaults.standard.array(forKey: favoriteArmorsKey) as? [Int] ?? [])
        favoriteSpellIds = Set(UserDefaults.standard.array(forKey: favoriteSpellsKey) as? [Int] ?? [])
    }
    
    func toggleFavoriteWeapon(_ id: Int) {
        if favoriteWeaponIds.contains(id) {
            favoriteWeaponIds.remove(id)
        } else {
            favoriteWeaponIds.insert(id)
        }
        UserDefaults.standard.set(Array(favoriteWeaponIds), forKey: favoriteWeaponsKey)
    }
    
    func toggleFavoriteArmor(_ id: Int) {
        if favoriteArmorIds.contains(id) {
            favoriteArmorIds.remove(id)
        } else {
            favoriteArmorIds.insert(id)
        }
        UserDefaults.standard.set(Array(favoriteArmorIds), forKey: favoriteArmorsKey)
    }
    
    func isWeaponFavorite(_ id: Int) -> Bool {
        favoriteWeaponIds.contains(id)
    }
    
    func isArmorFavorite(_ id: Int) -> Bool {
        favoriteArmorIds.contains(id)
    }
    
    private func loadRecentViewed() {
        recentViewedWeaponIds = UserDefaults.standard.array(forKey: recentViewedKey) as? [Int] ?? []
    }
    
    func addRecentViewed(weaponId: Int) {
        recentViewedWeaponIds.removeAll { $0 == weaponId }
        recentViewedWeaponIds.insert(weaponId, at: 0)
        if recentViewedWeaponIds.count > 20 {
            recentViewedWeaponIds = Array(recentViewedWeaponIds.prefix(20))
        }
        UserDefaults.standard.set(recentViewedWeaponIds, forKey: recentViewedKey)
    }
    
    func clearAll() {
        builds = []
        favoriteWeaponIds = []
        favoriteArmorIds = []
        favoriteSpellIds = []
        recentViewedWeaponIds = []
        
        UserDefaults.standard.removeObject(forKey: buildsKey)
        UserDefaults.standard.removeObject(forKey: favoriteWeaponsKey)
        UserDefaults.standard.removeObject(forKey: favoriteArmorsKey)
        UserDefaults.standard.removeObject(forKey: favoriteSpellsKey)
        UserDefaults.standard.removeObject(forKey: recentViewedKey)
    }
}

import Foundation

// MARK: - Category
struct Category: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let subcategories: [Subcategory]?
}

struct Subcategory: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

// MARK: - Weapon
struct Weapon: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let tier: String
    let itemPower: Int
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, tier, icon
        case itemPower = "item_power"
    }
    
    var tierNumber: Int {
        Int(tier.components(separatedBy: ".").first ?? "0") ?? 0
    }
    
    var enchantment: Int {
        Int(tier.components(separatedBy: ".").last ?? "0") ?? 0
    }
}

// MARK: - Armor
struct Armor: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let tier: String
    let itemPower: Int
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, tier, icon
        case itemPower = "item_power"
    }
}

// MARK: - Accessory
struct Accessory: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let tier: String
    let itemPower: Int
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, tier, icon
        case itemPower = "item_power"
    }
}

// MARK: - Spell
struct SpellSlot: Codable, Identifiable {
    var id: String { slot }
    let slot: String
    let spells: [Spell]
}

struct Spell: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let slot: String
    let preview: String?
    let icon: String
    let attributes: [SpellAttribute]
    let description: String
    let descriptionHtml: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slot, preview, icon, attributes, description
        case descriptionHtml = "description_html"
    }
    
    static func == (lhs: Spell, rhs: Spell) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SpellAttribute: Codable, Hashable {
    let name: String
    let value: String
}

// MARK: - Weapon Stats
struct WeaponStatEnchantment: Codable, Identifiable {
    var id: Int { enchantment }
    let enchantment: Int
    let icon: String
    let stats: [WeaponStatQuality]
}

struct WeaponStatQuality: Codable, Identifiable {
    let id: Int
    let quality: String
    let enchantment: Int
    let weapon: WeaponBasic
    let stats: [StatValue]
}

struct WeaponBasic: Codable {
    let id: Int
    let name: String
    let tier: String
    let itemPower: Int
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, tier, icon
        case itemPower = "item_power"
    }
}

struct StatValue: Codable, Hashable {
    let name: String
    let value: String
}

// MARK: - Consumable
struct Consumable: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let tier: String
    let icon: String
}

// MARK: - API Response Wrapper
struct APIResponse<T: Codable>: Codable {
    let data: T
}

// MARK: - Build
struct Build: Codable, Identifiable {
    let id: UUID
    var name: String
    var weaponId: Int?
    var headId: Int?
    var chestId: Int?
    var shoesId: Int?
    var capeId: Int?
    var notes: String
    var createdAt: Date
    var updatedAt: Date
    
    init(name: String = "새 빌드") {
        self.id = UUID()
        self.name = name
        self.notes = ""
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

// MARK: - Item Type
enum ItemType: String, CaseIterable {
    case weapon = "무기"
    case head = "머리"
    case chest = "갑옷"
    case shoes = "신발"
    case cape = "망토"
    case accessory = "악세서리"
    case consumable = "소모품"
    
    var iconName: String {
        switch self {
        case .weapon: return "shield.lefthalf.filled"
        case .head: return "crown.fill"
        case .chest: return "tshirt.fill"
        case .shoes: return "shoe.fill"
        case .cape: return "wind"
        case .accessory: return "sparkles"
        case .consumable: return "flask.fill"
        }
    }
}

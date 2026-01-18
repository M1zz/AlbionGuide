import Foundation

actor OpenAlbionAPI {
    static let shared = OpenAlbionAPI()
    
    private let baseURL = "https://api.openalbion.com/api/v3"
    private let session: URLSession
    private var cache: [String: (data: Data, timestamp: Date)] = [:]
    private let cacheExpiration: TimeInterval = 3600
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = URLSession(configuration: config)
    }
    
    private func fetch<T: Codable>(_ endpoint: String, type: T.Type) async throws -> T {
        let cacheKey = endpoint
        
        if let cached = cache[cacheKey],
           Date().timeIntervalSince(cached.timestamp) < cacheExpiration {
            return try JSONDecoder().decode(T.self, from: cached.data)
        }
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError
        }
        
        cache[cacheKey] = (data, Date())
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetchCategories() async throws -> [Category] {
        let response = try await fetch("/categories", type: APIResponse<[Category]>.self)
        return response.data
    }
    
    func fetchWeapons(categoryId: Int? = nil, subcategoryId: Int? = nil, tier: String? = nil) async throws -> [Weapon] {
        var endpoint = "/weapons"
        var params: [String] = []
        
        if let categoryId = categoryId {
            params.append("category_id=\(categoryId)")
        }
        if let subcategoryId = subcategoryId {
            params.append("subcategory_id=\(subcategoryId)")
        }
        if let tier = tier {
            params.append("tier=\(tier)")
        }
        
        if !params.isEmpty {
            endpoint += "?" + params.joined(separator: "&")
        }
        
        let response = try await fetch(endpoint, type: APIResponse<[Weapon]>.self)
        return response.data
    }
    
    func fetchWeaponSpells(weaponId: Int) async throws -> [SpellSlot] {
        let response = try await fetch("/spells/weapon/\(weaponId)", type: APIResponse<[SpellSlot]>.self)
        return response.data
    }
    
    func fetchWeaponStats(weaponId: Int) async throws -> [WeaponStatEnchantment] {
        let response = try await fetch("/weapon-stats/weapon/\(weaponId)", type: APIResponse<[WeaponStatEnchantment]>.self)
        return response.data
    }
    
    func fetchArmors(categoryId: Int? = nil, subcategoryId: Int? = nil, tier: String? = nil) async throws -> [Armor] {
        var endpoint = "/armors"
        var params: [String] = []
        
        if let categoryId = categoryId {
            params.append("category_id=\(categoryId)")
        }
        if let subcategoryId = subcategoryId {
            params.append("subcategory_id=\(subcategoryId)")
        }
        if let tier = tier {
            params.append("tier=\(tier)")
        }
        
        if !params.isEmpty {
            endpoint += "?" + params.joined(separator: "&")
        }
        
        let response = try await fetch(endpoint, type: APIResponse<[Armor]>.self)
        return response.data
    }
    
    func fetchArmorSpells(armorId: Int) async throws -> [SpellSlot] {
        let response = try await fetch("/spells/armor/\(armorId)", type: APIResponse<[SpellSlot]>.self)
        return response.data
    }
    
    func fetchAccessories(categoryId: Int? = nil, tier: String? = nil) async throws -> [Accessory] {
        var endpoint = "/accessories"
        var params: [String] = []
        
        if let categoryId = categoryId {
            params.append("category_id=\(categoryId)")
        }
        if let tier = tier {
            params.append("tier=\(tier)")
        }
        
        if !params.isEmpty {
            endpoint += "?" + params.joined(separator: "&")
        }
        
        let response = try await fetch(endpoint, type: APIResponse<[Accessory]>.self)
        return response.data
    }
    
    func fetchConsumables(categoryId: Int? = nil, tier: String? = nil) async throws -> [Consumable] {
        var endpoint = "/consumables"
        var params: [String] = []
        
        if let categoryId = categoryId {
            params.append("category_id=\(categoryId)")
        }
        if let tier = tier {
            params.append("tier=\(tier)")
        }
        
        if !params.isEmpty {
            endpoint += "?" + params.joined(separator: "&")
        }
        
        let response = try await fetch(endpoint, type: APIResponse<[Consumable]>.self)
        return response.data
    }
    
    func clearCache() {
        cache.removeAll()
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case serverError
    case decodingError
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "잘못된 URL입니다"
        case .serverError: return "서버 오류가 발생했습니다"
        case .decodingError: return "데이터 처리 중 오류가 발생했습니다"
        case .networkError: return "네트워크 연결을 확인해주세요"
        }
    }
}

struct AlbionImageURL {
    static let renderBase = "https://render.albiononline.com/v1"
    
    static func item(_ identifier: String, enchantment: Int = 0, quality: Int = 1, size: Int = 217) -> URL? {
        var id = identifier
        if enchantment > 0 {
            id += "@\(enchantment)"
        }
        return URL(string: "\(renderBase)/item/\(id).png?quality=\(quality)&size=\(size)")
    }
    
    static func spell(_ identifier: String, size: Int = 172) -> URL? {
        URL(string: "\(renderBase)/spell/\(identifier).png?size=\(size)")
    }
}

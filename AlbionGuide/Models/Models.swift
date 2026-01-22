import Foundation

// MARK: - Item Localization
/// 무기/방어구/악세서리 이름을 한국어로 변환하는 서비스
struct ItemLocalization {
    static let shared = ItemLocalization()

    /// 영어 → 한국어 무기 이름 매핑
    private let weaponNames: [String: String] = [
        // MARK: - 검 계열 (Swords)
        "Broadsword": "브로드소드",
        "Claymore": "클레이모어",
        "Dual Swords": "듀얼 소드",
        "Clarent Blade": "클라렌트 블레이드",
        "Carving Sword": "조각용 소드",
        "Galatine Pair": "갤러틴 페어",
        "Kingmaker": "킹메이커",
        "Infinity Blade": "인피니티 블레이드",

        // MARK: - 도끼 계열 (Axes)
        "Battleaxe": "배틀액스",
        "Greataxe": "그레이트액스",
        "Halberd": "할버드",
        "Carrioncaller": "캐리온콜러",
        "Infernal Scythe": "인퍼널 사이드",
        "Bear Paws": "베어 포",
        "Realmbreaker": "렐름브레이커",

        // MARK: - 망치 계열 (Hammers)
        "Hammer": "해머",
        "Great Hammer": "그레이트 해머",
        "Polehammer": "폴해머",
        "Tombhammer": "툼해머",
        "Forge Hammers": "포지 해머",
        "Grailseeker": "그레일시커",
        "Hand of Justice": "핸드 오브 저스티스",

        // MARK: - 철퇴 계열 (Maces)
        "Mace": "메이스",
        "Heavy Mace": "헤비 메이스",
        "Morning Star": "모닝스타",
        "Bedrock Mace": "베드락 메이스",
        "Incubus Mace": "인큐버스 메이스",
        "Camlann Mace": "캠런 메이스",
        "Oathkeepers": "오스키퍼",

        // MARK: - 단검 계열 (Daggers)
        "Dagger": "대거",
        "Dagger Pair": "대거 페어",
        "Claws": "클로",
        "Bloodletter": "블러드레터",
        "Black Hands": "블랙 핸드",
        "Deathgivers": "데스기버",
        "Bridled Fury": "브라이들드 퓨리",

        // MARK: - 창 계열 (Spears)
        "Spear": "스피어",
        "Pike": "파이크",
        "Glaive": "글레이브",
        "Heron Spear": "헤론 스피어",
        "Spirithunter": "스피릿헌터",
        "Trinity Spear": "트리니티 스피어",
        "Daybreaker": "데이브레이커",

        // MARK: - 자연 지팡이 계열 (Nature Staffs)
        "Nature Staff": "네이처 스태프",
        "Great Nature Staff": "그레이트 네이처 스태프",
        "Wild Staff": "와일드 스태프",
        "Druidic Staff": "드루이딕 스태프",
        "Blight Staff": "블라이트 스태프",
        "Rampant Staff": "램펀트 스태프",
        "Ironroot Staff": "아이언루트 스태프",

        // MARK: - 신성 지팡이 계열 (Holy Staffs)
        "Holy Staff": "홀리 스태프",
        "Great Holy Staff": "그레이트 홀리 스태프",
        "Divine Staff": "디바인 스태프",
        "Lifetouch Staff": "라이프터치 스태프",
        "Fallen Staff": "폴른 스태프",
        "Redemption Staff": "리뎀션 스태프",
        "Hallowfall": "할로우폴",

        // MARK: - 비전 지팡이 계열 (Arcane Staffs)
        "Arcane Staff": "아케인 스태프",
        "Great Arcane Staff": "그레이트 아케인 스태프",
        "Enigmatic Staff": "에니그매틱 스태프",
        "Witchwork Staff": "위치워크 스태프",
        "Occult Staff": "오컬트 스태프",
        "Malevolent Locus": "말레볼런트 로커스",
        "Evensong": "이븐송",

        // MARK: - 화염 지팡이 계열 (Fire Staffs)
        "Fire Staff": "파이어 스태프",
        "Great Fire Staff": "그레이트 파이어 스태프",
        "Infernal Staff": "인퍼널 스태프",
        "Wildfire Staff": "와일드파이어 스태프",
        "Brimstone Staff": "브림스톤 스태프",
        "Blazing Staff": "블레이징 스태프",
        "Dawnsong": "던송",

        // MARK: - 냉기 지팡이 계열 (Frost Staffs)
        "Frost Staff": "프로스트 스태프",
        "Great Frost Staff": "그레이트 프로스트 스태프",
        "Glacial Staff": "글레이셜 스태프",
        "Hoarfrost Staff": "호어프로스트 스태프",
        "Icicle Staff": "아이시클 스태프",
        "Permafrost Prism": "퍼마프로스트 프리즘",
        "Chillhowl": "칠하울",

        // MARK: - 저주 지팡이 계열 (Curse Staffs)
        "Curse Staff": "커스 스태프",
        "Great Curse Staff": "그레이트 커스 스태프",
        "Demonic Staff": "데모닉 스태프",
        "Lifecurse Staff": "라이프커스 스태프",
        "Cursed Skull": "커스드 스컬",
        "Damnation Staff": "댐네이션 스태프",
        "Shadowcaller": "섀도우콜러",

        // MARK: - 활 계열 (Bows)
        "Bow": "보우",
        "Warbow": "워보우",
        "Longbow": "롱보우",
        "Whispering Bow": "위스퍼링 보우",
        "Wailing Bow": "웨일링 보우",
        "Bow of Badon": "바돈의 활",
        "Mistpiercer": "미스트피어서",

        // MARK: - 석궁 계열 (Crossbows)
        "Crossbow": "크로스보우",
        "Heavy Crossbow": "헤비 크로스보우",
        "Light Crossbow": "라이트 크로스보우",
        "Weeping Repeater": "위핑 리피터",
        "Boltcasters": "볼트캐스터",
        "Siegebow": "시즈보우",
        "Energy Shaper": "에너지 셰이퍼",

        // MARK: - 사분의 계열 (Quarterstaffs)
        "Quarterstaff": "쿼터스태프",
        "Iron-clad Staff": "아이언클래드 스태프",
        "Double Bladed Staff": "더블 블레이디드 스태프",
        "Black Monk Stave": "블랙 몽크 스테이브",
        "Soulscythe": "소울사이드",
        "Staff of Balance": "스태프 오브 밸런스",
        "Grovekeeper": "그로브키퍼",

        // MARK: - 방패 계열 (Shields)
        "Shield": "실드",
        "Sarcophagus": "사르코파거스",
        "Caitiff Shield": "케이티프 실드",
        "Facebreaker": "페이스브레이커",
        "Astral Aegis": "아스트랄 이지스",

        // MARK: - 횃불 계열 (Torches)
        "Torch": "토치",
        "Mistcaller": "미스트콜러",
        "Leering Cane": "리어링 케인",
        "Cryptcandle": "크립트캔들",
        "Sacred Scepter": "세이크리드 셉터",

        // MARK: - 책 계열 (Tomes)
        "Tome of Spells": "톰 오브 스펠",
        "Eye of Secrets": "아이 오브 시크릿",
        "Muisak": "뮤이삭",
        "Taproot": "탭루트",
        "Celestial Censer": "셀레스티얼 센서",
    ]

    /// 영어 → 한국어 방어구 이름 매핑
    private let armorNames: [String: String] = [
        // MARK: - 천 갑옷 (Cloth)
        "Scholar Cowl": "스콜라 카울",
        "Scholar Robe": "스콜라 로브",
        "Scholar Sandals": "스콜라 샌들",
        "Cleric Cowl": "클레릭 카울",
        "Cleric Robe": "클레릭 로브",
        "Cleric Sandals": "클레릭 샌들",
        "Mage Cowl": "메이지 카울",
        "Mage Robe": "메이지 로브",
        "Mage Sandals": "메이지 샌들",
        "Druid Cowl": "드루이드 카울",
        "Druid Robe": "드루이드 로브",
        "Druid Sandals": "드루이드 샌들",
        "Fiend Cowl": "핀드 카울",
        "Fiend Robe": "핀드 로브",
        "Fiend Sandals": "핀드 샌들",
        "Royal Cowl": "로얄 카울",
        "Royal Robe": "로얄 로브",
        "Royal Sandals": "로얄 샌들",
        "Cultist Cowl": "컬티스트 카울",
        "Cultist Robe": "컬티스트 로브",
        "Cultist Sandals": "컬티스트 샌들",

        // MARK: - 가죽 갑옷 (Leather)
        "Mercenary Hood": "머서너리 후드",
        "Mercenary Jacket": "머서너리 재킷",
        "Mercenary Shoes": "머서너리 슈즈",
        "Hunter Hood": "헌터 후드",
        "Hunter Jacket": "헌터 재킷",
        "Hunter Shoes": "헌터 슈즈",
        "Assassin Hood": "어쌔신 후드",
        "Assassin Jacket": "어쌔신 재킷",
        "Assassin Shoes": "어쌔신 슈즈",
        "Stalker Hood": "스토커 후드",
        "Stalker Jacket": "스토커 재킷",
        "Stalker Shoes": "스토커 슈즈",
        "Hellion Hood": "헬리온 후드",
        "Hellion Jacket": "헬리온 재킷",
        "Hellion Shoes": "헬리온 슈즈",
        "Royal Hood": "로얄 후드",
        "Royal Jacket": "로얄 재킷",
        "Royal Shoes": "로얄 슈즈",
        "Specter Hood": "스펙터 후드",
        "Specter Jacket": "스펙터 재킷",
        "Specter Shoes": "스펙터 슈즈",

        // MARK: - 판금 갑옷 (Plate)
        "Soldier Helmet": "솔저 헬멧",
        "Soldier Armor": "솔저 아머",
        "Soldier Boots": "솔저 부츠",
        "Knight Helmet": "나이트 헬멧",
        "Knight Armor": "나이트 아머",
        "Knight Boots": "나이트 부츠",
        "Guardian Helmet": "가디언 헬멧",
        "Guardian Armor": "가디언 아머",
        "Guardian Boots": "가디언 부츠",
        "Graveguard Helmet": "그레이브가드 헬멧",
        "Graveguard Armor": "그레이브가드 아머",
        "Graveguard Boots": "그레이브가드 부츠",
        "Demon Helmet": "데몬 헬멧",
        "Demon Armor": "데몬 아머",
        "Demon Boots": "데몬 부츠",
        "Royal Helmet": "로얄 헬멧",
        "Royal Armor": "로얄 아머",
        "Royal Boots": "로얄 부츠",
        "Judicator Helmet": "주디케이터 헬멧",
        "Judicator Armor": "주디케이터 아머",
        "Judicator Boots": "주디케이터 부츠",

        // MARK: - 망토 (Capes)
        "Cape": "망토",
        "Cloak": "클로크",
        "Undead Cape": "언데드 망토",
        "Heretic Cape": "헤레틱 망토",
        "Demon Cape": "데몬 망토",
        "Morgana Cape": "모르가나 망토",
        "Keeper Cape": "키퍼 망토",
        "Avalonian Cape": "아발로니안 망토",
        "Thetford Cape": "뎃포드 망토",
        "Fort Sterling Cape": "포트 스털링 망토",
        "Lymhurst Cape": "림허스트 망토",
        "Bridgewatch Cape": "브릿지워치 망토",
        "Martlock Cape": "마틀록 망토",
        "Caerleon Cape": "칼레온 망토",
    ]

    /// 티어 접두사 매핑
    private let tierPrefixes: [String: String] = [
        "Beginner's": "초보자",
        "Novice's": "견습",
        "Journeyman's": "숙련",
        "Adept's": "전문가",
        "Expert's": "달인",
        "Master's": "대가",
        "Grandmaster's": "그랜드마스터",
        "Elder's": "엘더",
    ]

    /// 영어 → 한국어 스킬 이름 매핑
    private let skillNames: [String: String] = [
        // MARK: - 검 스킬 (Sword Skills)
        "Heroic Strike": "영웅적인 타격",
        "Heroic Cleave": "영웅적인 가르기",
        "Heroic Charge": "영웅적인 돌진",
        "Blade Cyclone": "칼날 회오리",
        "Interrupt": "방해",
        "Splitting Slash": "베어가르기",
        "Hamstring": "저지",
        "Parry Strike": "흘려치기",
        "Iron Will": "강철의 의지",
        "Deep Cuts": "깊게 베기",
        "Weakening": "쇠약",
        "Increased Defense": "방어 증가",
        "Aggressive Rush": "공격적인 돌격",
        "Mighty Blow": "강력한 후려치기",
        "Charge": "돌진",
        "Spinning Blades": "회전하는 칼날",
        "Crescent Slash": "초승달 베기",
        "Fearless Strike": "용맹한 타격",
        "Soulless Stream": "영혼없는 흐름",
        "Majestic Smash": "위풍당당한 강타",

        // MARK: - 도끼 스킬 (Axe Skills)
        "Rending Bleed": "찢는 출혈",
        "Rending Strike": "찢는 타격",
        "Rending Spin": "찢는 회전",
        "Rending Rage": "찢어지는 분노",
        "Deadly Chop": "죽음의 내려치기",
        "Adrenaline Boost": "아드레날린 부스트",
        "Battle Rush": "전투 돌격",
        "Internal Bleeding": "내출혈",
        "Raging Blades": "분노의 칼날",
        "Blood Bandit": "피의 도적",
        "Whirlwind": "회오리바람",
        "Tear Apart": "찢어발기기",
        "Morgana Raven": "모르가나의 까마귀",
        "Bloody Reap": "피의 수확",
        "Razor Cut": "날카로운 베기",
        "Aftershock": "여파",

        // MARK: - 철퇴 스킬 (Mace Skills)
        "Defensive Slam": "방어적 밀쳐내기",
        "Threatening Smash": "위협적인 강타",
        "Sacred Ground": "신성한 땅",
        "Ground Shaker": "대지 진동자",
        "Snare Charge": "유인 돌진",
        "Guard Rune": "보호의 룬",
        "Air Compressor": "공기 압축",
        "Deep Leap": "크게 뛰기",
        "Battle Howl": "전투의 울부짖음",
        "Gravitas": "중력 조작",
        "Shrinking Curse": "수축의 저주",
        "Vendetta": "복수",
        "Blessed Aurora": "신성한 오로라",

        // MARK: - 해머 스킬 (Hammer Skills)
        "Bash Knee": "강력한 휘두르기",
        "Threatening Strike": "위협하는 타격",
        "Iron Breaker": "강철 분쇄",
        "Heavy Smash": "육중한 강타",
        "Slowing Charge": "둔화 돌진",
        "Power Geyser": "거센 간헐천",
        "Knockout": "의식불명",
        "Inertia Ring": "무력의 고리",
        "Earth Shatter": "대지 충격",
        "Groundbreaker": "땅 부수기",
        "Tackle": "태클",
        "Grasp of the Undead": "언데드의 손아귀",
        "Giant Steps": "거인의 발걸음",
        "Ground Pound": "땅 내려치기",
        "Onslaught": "맹공",

        // MARK: - 단검 스킬 (Dagger Skills)
        "Sunder Armor": "갑옷 부수기",
        "Assassin Spirit": "암살자의 정신",
        "Chain Slash": "연쇄 베기",
        "Puncture": "관통",
        "Deadly Dance": "죽음의 춤",
        "Life Leech": "생명 흡수",
        "Shadow Edge": "그림자 칼날",
        "Forbidden Stab": "금단의 찌르기",
        "Infiltration": "잠입",
        "Dash": "돌진",
        "Cursed Sickle": "저주받은 낫",

        // MARK: - 창 스킬 (Spear Skills)
        "Inner Focus": "내적 집중",
        "Piercing Thrust": "관통 찌르기",
        "Decisive Strike": "결정적 타격",
        "Lunging Stab": "찌르기 돌진",
        "Spirit Spear": "영혼 창",
        "Forest of Spears": "창의 숲",
        "Cripple": "무력화",
        "Impaler": "꿰뚫기",
        "Deflecting Spin": "방어 회전",

        // MARK: - 활 스킬 (Bow Skills)
        "Snipe": "저격",
        "Piercing Shot": "관통 사격",
        "Explosive Arrow": "폭발 화살",
        "Multishot": "다중 사격",
        "Frost Shot": "서리 사격",
        "Speed Shot": "신속 사격",
        "Ray of Light": "빛의 광선",
        "Enchanted Arrow": "마법 화살",

        // MARK: - 석궁 스킬 (Crossbow Skills)
        "Rapid Fire": "연사",
        "Piercing Bolts": "관통 볼트",
        "Explosive Shot": "폭발 사격",
        "Auto Fire": "자동 사격",
        "Sunder Shot": "분쇄 사격",
        "Noise Eraser": "소음 제거기",
        "Well Prepared": "만반의 준비",

        // MARK: - 네이처 스태프 스킬 (Nature Staff Skills)
        "Rejuvenation": "재생",
        "Thorns": "가시",
        "Revitalize": "활력",
        "Poison": "독",
        "Protection of Nature": "자연의 보호",
        "Cleanse Heal": "정화 치유",
        "Living Armor": "생명의 갑옷",
        "Circle of Life": "생명의 순환",

        // MARK: - 홀리 스태프 스킬 (Holy Staff Skills)
        "Holy Beam": "신성한 광선",
        "Heal": "치유",
        "Divine Blessing": "신성한 축복",
        "Smite": "천벌",
        "Flash Heal": "순간 치유",
        "Generous Heal": "관대한 치유",
        "Desperate Prayer": "간절한 기도",
        "Holy Explosion": "신성 폭발",
        "Sacred Pulse": "신성한 파동",
        "Salvation": "구원",

        // MARK: - 파이어 스태프 스킬 (Fire Staff Skills)
        "Fireball": "파이어볼",
        "Incinerate": "소각",
        "Flame Burst": "화염 폭발",
        "Fire Bolt": "화염 화살",
        "Burning Field": "불타는 필드",
        "Fire Wall": "화염 벽",
        "Meteor": "유성",
        "Magma Sphere": "마그마 구체",
        "Infernal Fire": "지옥불",

        // MARK: - 프로스트 스태프 스킬 (Frost Staff Skills)
        "Frost Bolt": "서리 화살",
        "Freeze": "동결",
        "Blizzard": "눈보라",
        "Frost Bomb": "서리 폭탄",
        "Hoarfrost": "흰 서리",
        "Ice Shard": "얼음 파편",
        "Avalanche": "눈사태",
        "Shatter": "산산조각",
        "Frost Nova": "서리 노바",

        // MARK: - 커스 스태프 스킬 (Curse Staff Skills)
        "Curse": "저주",
        "Dark Curse": "어둠의 저주",
        "Vile Curse": "사악한 저주",
        "Haunting Screams": "잊혀지지 않는 비명",
        "Desecrate": "모독",
        "Death Curse": "죽음의 저주",
        "Grudge": "원한",
        "Area of Decay": "부패의 영역",

        // MARK: - 아케인 스태프 스킬 (Arcane Staff Skills)
        "Arcane Bolt": "신비한 화살",
        "Mana Shield": "마나 보호막",
        "Spell Amplification": "마법 증폭",
        "Energy Bolt": "에너지 화살",
        "Frazzle": "정신 쇠약",
        "Time Freeze": "시간 정지",
        "Arcane Orb": "신비한 구체",

        // MARK: - 쿼터스태프 스킬 (Quarterstaff Skills)
        "Concussive Blow": "뇌진탕 타격",
        "Stun Run": "기절 돌진",
        "Heavy Cleave": "강력한 가르기",
        "Empowered Slam": "강화된 내려치기",
        "Hurricane": "허리케인",
        "Cartwheel": "옆돌기",
        "Forceful Swing": "강력한 휘두르기",

        // MARK: - 공통 패시브 (Common Passives)
        "Attack Speed": "공격 속도",
        "Cast Speed": "시전 속도",
        "Cooldown Reduction": "재사용 대기시간 감소",
        "Damage": "피해",
        "Defense": "방어",
        "Healing": "치유",
        "Energy": "에너지",
        "Health": "체력",
    ]

    /// 아이템 이름을 한국어로 변환
    func localize(_ name: String) -> String {
        // 현재 언어가 한국어가 아니면 원본 반환
        guard Locale.current.language.languageCode?.identifier == "ko" else {
            return name
        }

        // 티어 접두사 분리
        var localizedName = name
        var prefix = ""

        for (englishPrefix, koreanPrefix) in tierPrefixes {
            if name.hasPrefix(englishPrefix) {
                prefix = koreanPrefix + " "
                localizedName = String(name.dropFirst(englishPrefix.count)).trimmingCharacters(in: .whitespaces)
                break
            }
        }

        // 무기 이름 검색
        if let koreanName = weaponNames[localizedName] {
            return prefix + koreanName
        }

        // 방어구 이름 검색
        if let koreanName = armorNames[localizedName] {
            return prefix + koreanName
        }

        // 매핑이 없으면 원본 반환
        return name
    }

    /// 스킬 이름을 한국어로 변환
    func localizeSkill(_ name: String) -> String {
        // 현재 언어가 한국어가 아니면 원본 반환
        guard Locale.current.language.languageCode?.identifier == "ko" else {
            return name
        }

        // 스킬 이름 검색
        if let koreanName = skillNames[name] {
            return koreanName
        }

        // 매핑이 없으면 원본 반환
        return name
    }
}

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

    var localizedName: String {
        ItemLocalization.shared.localize(name)
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

    var localizedName: String {
        ItemLocalization.shared.localize(name)
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

    var localizedName: String {
        ItemLocalization.shared.localize(name)
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

    var localizedName: String {
        ItemLocalization.shared.localizeSkill(name)
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

    init(name: String = String(localized: "new_build")) {
        self.id = UUID()
        self.name = name
        self.notes = ""
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

// MARK: - Item Type
enum ItemType: String, CaseIterable {
    case weapon
    case head
    case chest
    case shoes
    case cape
    case accessory
    case consumable

    var localizedName: String {
        switch self {
        case .weapon: return String(localized: "weapon")
        case .head: return String(localized: "head")
        case .chest: return String(localized: "chest")
        case .shoes: return String(localized: "shoes")
        case .cape: return String(localized: "cape")
        case .accessory: return String(localized: "accessories")
        case .consumable: return String(localized: "consumables")
        }
    }

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

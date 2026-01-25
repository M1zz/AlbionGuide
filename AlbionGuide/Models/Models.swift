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

    /// 영어 → 한국어 스킬 속성 이름 매핑
    private let attributeNames: [String: String] = [
        // 기본 속성
        "Cast Time": "시전 시간",
        "Range": "사거리",
        "Energy Cost": "에너지 소모",
        "Cooldown": "재사용 대기시간",
        "Standtime": "정지 시간",
        "Hit Delay": "적중 지연",
        "Channel Time": "채널링 시간",

        // 피해/효과 관련
        "Damage": "피해량",
        "Magic Damage": "마법 피해",
        "Physical Damage": "물리 피해",
        "Heal": "치유량",
        "Healing": "치유량",
        "Shield": "보호막",
        "Buff Duration": "버프 지속시간",
        "Debuff Duration": "디버프 지속시간",
        "Effect Duration": "효과 지속시간",
        "Duration": "지속시간",

        // 범위/거리 관련
        "Radius": "반경",
        "Area": "범위",
        "Knockback": "밀어내기",
        "Pull": "끌어당기기",

        // 군중 제어
        "Stun Duration": "기절 지속시간",
        "Silence Duration": "침묵 지속시간",
        "Root Duration": "속박 지속시간",
        "Slow": "둔화",
        "Slow Duration": "둔화 지속시간",

        // 스택/충전
        "Max Stacks": "최대 중첩",
        "Stacks": "중첩",
        "Charges": "충전",

        // 기타
        "Threat": "위협도",
        "Lifesteal": "생명력 흡수",
        "Resistance": "저항",
        "Armor": "방어력",
        "Attack Speed": "공격 속도",
        "Movement Speed": "이동 속도",
        "Cast Speed Increase": "시전 속도 증가",
        "Damage Increase": "피해 증가",
        "Healing Increase": "치유 증가",
        "Health Regeneration": "체력 재생",
        "Energy Regeneration": "에너지 재생",
        "Instant": "즉시",
        "Tick Interval": "틱 간격",
        "Max Targets": "최대 대상",
        "Projectile Speed": "투사체 속도",
    ]

    /// 스킬 ID → 한국어 설명 매핑
    private let skillDescriptions: [Int: String] = [
        // MARK: - 공통 패시브 스킬 (Common Passive Skills)
        6: "4번의 일반 공격마다 대상 적에게 1.5초 동안 58의 물리 피해를 주는 출혈을 부여합니다.",
        7: "일반 공격 피해의 15%를 생명력 흡수로 받습니다.",
        15: "일반 공격 피해의 15%를 생명력 흡수로 받습니다.",
        24: "일반 공격 시마다 에너지를 4 회복합니다.",
        35: "체력이 40% 미만일 때 피해를 받으면 활성화됩니다. 3초 동안 피해량 15%, 재사용 대기시간 감소 15% 증가합니다.",
        46: "일반 공격 시 대상 적을 1.61초/1.77초 동안 10%(플레이어)/40%(몹) 느리게 합니다.",
        47: "일반 공격 시 적이 잃은 체력의 15%를 흡수합니다.",
        48: "4번의 공격마다 피해량이 증가합니다.",
        49: "5번의 공격마다 공격 속도가 증가합니다.",
        74: "4번의 주문 시전 후 3초 동안 치유 시전량이 20% 증가합니다.",
        75: "5번의 주문 시전 후 다음 일반 공격이 대상 적을 2.99m/3.29m 밀어냅니다.",
        76: "두 번째 슬롯 스킬 시전 시 활성화됩니다. 1.5초 동안 모든 시전과 채널링이 방해받지 않습니다.",
        105: "주문 시전 후 3초 내 다음 3회 일반 공격의 공격 속도가 120%, 사거리가 33% 증가합니다.",
        108: "5번의 주문 시전 후 3초 동안 피해 저항이 70/71 증가합니다.",
        115: "일반 공격 시 적이 잃은 체력의 15%를 흡수합니다.",
        123: "5번의 주문 시전 후 다음 일반 공격이 적을 1.75-1.92초 동안 침묵시킵니다.",
        151: "일반 공격 시 대상 적의 피해량을 2초 동안 2% 감소시킵니다. (최대 5회 중첩)",
        163: "일반 공격 시 적에게 화염을 부여하여 2.5초 동안 초당 23의 추가 피해를 줍니다.",
        170: "3번의 일반 공격마다 적을 1.2초 동안 속박합니다.",
        171: "4번의 주문 시전 후 3초 동안 시전 속도가 40% 증가합니다.",
        207: "3번의 일반 공격마다 적을 밀어내고 주문 시전을 방해합니다.",
        208: "4번의 주문 시전 후 Q 슬롯 스킬의 재사용 대기시간이 즉시 초기화됩니다.",
        248: "4번의 일반 공격마다 대상 적 주변 5m 반경에 68/75의 마법 피해를 주는 악마적 폭발을 일으킵니다.",

        // MARK: - 도끼 스킬 (Axe Skills)
        1: "대상 적을 공격하여 178/196의 물리 피해를 줍니다. 찢는 출혈 충전을 부여합니다. 각 충전은 6초 동안 83/91의 피해를 줍니다. (최대 3회 중첩) 최대 중첩 시 5초 동안 받는 치유량이 12% 감소합니다.",
        2: "주변 6m 반경의 모든 적에게 물리 피해를 주며 회전합니다. 3m 이상 떨어진 적에게 248, 가까운 적에게 149의 피해를 줍니다. 또한 6초 동안 초당 18의 물리 피해를 주는 찢는 출혈을 부여합니다. (최대 3회 중첩) 3중첩 시 5초 동안 받는 치유량이 20% 감소합니다.",
        3: "대상 적을 타격하여 502/551의 물리 피해를 줍니다. 8초 동안 피해 저항을 48/49 감소시킵니다.",
        4: "아드레날린 부스트를 발동하여 최대 7초 동안 모든 피해가 25%, 이동 속도가 40%, 공격 속도가 40% 증가합니다. 3.5초 동안 직접 피해를 주지 않으면 일찍 종료됩니다.",
        5: "콤보 스킬입니다. 피의 흡입: 찢는 출혈 충전에 따라 피해가 증가하는 도끼를 던집니다(578/660/743/825). 피의 도적: 피가 주입된 도끼를 던져 363의 피해를 주고 대상의 찢는 출혈 충전에 따라 치유합니다(모두 743 치유).",

        // MARK: - 검 스킬 (Sword Skills)
        148: "적을 타격하여 상당한 물리 피해를 주고 이동 속도와 공격 속도 버프를 얻습니다. 영웅적 충전 하나당 6초 동안 이동 속도와 공격 속도가 12% 증가합니다. (최대 3회 중첩)",
        149: "회전하며 주변의 여러 적에게 피해를 줍니다. 영웅적 충전을 소모하면 피해량이 증가하여, 기본 피해 132-145에서 충전 시 198-218까지 증가합니다.",
        150: "대상 적에게 도약하여 주문 시전을 방해합니다. 충전에 따라 피해가 증가합니다: 0충전 264, 1충전 422, 2충전 634, 3충전 894. 이후 모든 충전을 소모합니다.",

        // MARK: - 철퇴 스킬 (Mace Skills)
        16: "대상 적을 공격하여 223/245의 물리 피해를 줍니다. 8m 반경 내 본인과 최대 5명의 아군에게 3초 동안 피해 저항 44/44, 군중 제어 저항 57/63을 부여합니다.",
        17: "전방 원뿔 범위로 철퇴를 휘둘러 맞은 모든 적에게 419/460의 물리 피해를 줍니다. 맞은 몹에 대한 위협도가 100 증가합니다.",
        19: "지정한 위치 주변 4m 반경에 충격을 가해 574/631의 물리 피해를 줍니다. 맞은 모든 적을 0.6초 동안 공중에 띄웁니다.",
        20: "지정한 위치로 도약하여 착지 시 6m 반경의 모든 적에게 153/168의 물리 피해를 줍니다. 맞은 모든 적을 3.58초/3.93초(플레이어) / 7.14초/7.85초(몹) 동안 속박합니다.",
        88: "지정한 위치로 도약하며 착지까지 모든 군중 제어, 디버프, 피해에 면역이 됩니다. 착지 시 5m 반경에 448의 물리 피해를 줍니다. 맞은 모든 적을 4.19초 동안 30% 느리게 하고, 3m 반경 내 적은 2.52초 동안 기절시킵니다.",

        // MARK: - 해머 스킬 (Hammer Skills)
        111: "대상 적을 가격하여 160/175의 물리 피해를 줍니다. 5.59초/6.14초 동안 30% 느리게 합니다.",
        112: "대상 적을 타격하여 288/317의 물리 피해를 줍니다. 3초 동안 위협 생성량이 400% 증가합니다.",
        113: "전방의 모든 적에게 869의 피해를 주는 강력한 공격을 가합니다.",
        114: "지정한 위치로 돌진하며 지나가는 모든 적에게 162/178의 물리 피해를 줍니다. 5.59초/6.14초 동안 50% 느리게 합니다.",

        // MARK: - 창 스킬 (Spear Skills)
        38: "전방 9m 직선상의 모든 적을 찔러 257/283의 물리 피해를 줍니다. 공격력을 28%씩 증가시키는 영혼 창 충전을 부여하고(최대 3중첩) 적을 느리게 합니다.",
        39: "창에 마법을 부여하여 8초 동안 공격 범위가 40% 증가합니다. 영혼 창 충전을 부여하며, 현재 충전에 따라 에너지 소모량이 증가합니다. 최대 3회 중첩됩니다.",
        40: "전방 원뿔 범위에 최대 2.1초 동안 채널링하며 연속 찌르기를 발사합니다. 채널링 중 0.3초마다 물리 피해를 줍니다.",
        41: "1.8초 동안 채널링하며 명상하여 내적 집중을 모읍니다. 최대 10중첩까지 피해량, 군중 제어 지속시간, 이동 속도가 점진적으로 증가합니다.",
        42: "대상 적을 타격하여 350/384의 마법 피해를 줍니다.",
        43: "0.4초 후 땅에서 거대한 창이 솟아오릅니다.",
        44: "지정한 방향으로 무기를 던져 첫 번째로 맞은 적을 끌어당깁니다.",
        95: "파이크로 대상 적을 휘둘러 4.93초 동안 속박합니다.",
        99: "지정한 위치로 돌진하며 지나가는 모든 적을 0.6초 동안 공중에 띄웁니다. 영혼 창 충전에 따라 피해가 증가합니다: 0충전 201 ~ 3충전 687.",

        // MARK: - 활 스킬 (Bow Skills)
        196: "원뿔 범위로 화살을 발사하여 적을 6.14m 밀어내고 363의 물리 피해를 줍니다.",
        197: "지정한 방향으로 화살을 쏴 관통하며 맞은 모든 적에게 252의 물리 피해를 줍니다. 또한 6초 동안 피해 저항을 9 감소시킵니다. (최대 3회 중첩)",
        198: "0.6초 후 착지하는 화살을 발사합니다. 3m 반경의 모든 적을 2.76초 동안 속박하고 500의 물리 피해를 줍니다.",
        199: "8초 동안 최대 6발의 화살에 마법을 부여하여 공격 속도 50%, 물리 피해 240% 증가합니다. 8초 내 재사용 시 돌진하며 추가로 4발의 화살에 마법을 부여합니다.",

        // MARK: - 석궁 스킬 (Crossbow Skills)
        202: "대상 적에게 집중 공격하여 최대 1.5초 동안 채널링하며 0.3초마다 95의 물리 피해를 줍니다. 마지막 공격은 5m 반경에 259의 마법 피해를 주며 폭발합니다.",
        203: "지정한 위치에 폭발 볼트를 발사하여 3m 반경의 모든 적에게 410의 마법 피해를 줍니다.",
        204: "지정한 방향으로 볼트를 발사하여 첫 번째로 맞은 적을 15.36m 밀어냅니다. 196의 물리 피해를 주고, 5초 동안 시전 시간이 감소하고 공격 속도가 50% 증가합니다.",
        205: "대상 적에게 정조준한 볼트를 발사하여 288의 물리 피해를 줍니다. 대상의 남은 체력 10%당 피해 저항을 8 감소시킵니다. (최대 10회 중첩, 4초 지속)",
        206: "단일 대상에게 1273의 물리 피해를 줍니다.",

        // MARK: - 워글러브 스킬 (War Gloves Skills)
        26: "최대 2개의 스킬을 조합합니다. 콤보는 1.25초 후 초기화됩니다. 1차 빈틈 만들기: 대상 적을 공격하여 218의 물리 피해를 줍니다. 2차 빈틈 공략: 218의 물리 피해를 주고 3초 동안 피해 저항을 30 감소시킵니다.",
        27: "최대 2개의 스킬을 조합합니다. 콤보는 2초 후 초기화됩니다. 1차 용 도약: 지정한 위치로 돌진하여 2.5m 반경의 모든 적을 차서 254의 물리 피해를 줍니다. 적을 하나라도 맞히면 다음 콤보 스킬이 활성화됩니다. 2차 용 주먹: 지정한 위치로 도약하여 2.5m 반경의 모든 적에게 308의 물리 피해를 주고 0.5초 동안 공중에 띄웁니다.",
        30: "지정한 위치로 돌진하며 지나가는 모든 적을 반복해서 찹니다. 최대 3회까지 134의 물리 피해(플레이어) / 218의 물리 피해(몹)를 줍니다. 적 플레이어 1명을 함께 끌고 갑니다.",
        31: "대상 적을 타격하여 15.9m 뒤로 밀어냅니다. 236의 물리 피해를 주고, 밀려난 적이 지형에 부딪히면 363의 추가 물리 피해를 받습니다. 5초 동안 피해 저항이 61 감소합니다.",
        92: "땅을 내려쳐 전방 3m 반경에 불타는 간헐천을 방출합니다. 682의 마법 피해를 주고 맞은 모든 적을 0.5초 동안 공중에 띄웁니다. 적을 하나라도 맞히면 첫 번째 슬롯 스킬의 재사용 대기시간이 초기화됩니다.",

        // MARK: - 쿼터스태프 스킬 (Quarterstaff Skills)
        9: "최대 2개의 스킬을 조합합니다. 콤보는 6초 후 초기화됩니다. 1차, 2차 흐르는 타격: 원뿔 범위에 248의 피해를 줍니다. 3차 뇌진탕 타격: 397의 피해를 주고 2.31초 동안 기절시킵니다.",
        10: "최대 0.6초 동안 채널링하며 5m 반경에서 스태프를 휘둘러 0.25초마다 126의 물리 피해를 줍니다. 적중 시 5초 동안 재사용 대기시간이 12% 감소합니다. (최대 3회 중첩)",
        11: "지정한 방향으로 최대 3회 무기를 휘두르며 각각 265의 물리 피해를 줍니다. 세 번 모두 적중하면 4초 동안 이동 속도가 30%, 일반 공격 피해가 50% 증가합니다.",
        12: "달리기 시작하여 4초 동안 이동 속도가 30% 증가합니다. 달리는 중 첫 번째 공격은 대상 적을 3.4초 동안 기절시킵니다.",
        13: "주변 6m 반경에서 스태프를 휘둘러 맞은 모든 적을 6.87m 밀어내고 172의 피해를 줍니다. 8초 동안 적의 모든 피해가 20% 감소하고 일반 공격이 비활성화됩니다.",
        14: "지정한 위치로 도약하여 6m 반경에 265의 물리 피해를 줍니다. 맞은 모든 적을 4.84초 동안 50% 느리게 합니다.",

        // MARK: - 화염 지팡이 스킬 (Fire Staff Skills)
        160: "불타는 투사체를 발사하여 178/196의 마법 피해를 주고 점화를 부여하여 지속 피해를 줍니다. (최대 5회 중첩)",
        161: "불타는 영역을 생성하여 즉시 광역 피해를 주고 영역 내 적에게 지속 피해를 줍니다.",
        164: "전방에 14m 너비의 화염벽을 생성하여 5초간 지속됩니다.",
        183: "콤보 기반 공격으로 최대 3발의 화염을 발사한 후 4차 격렬한 화염을 발사합니다.",
        185: "원뿔 범위 공격으로 적에게 점화를 부여하고, 다른 화염 스킬에 영향받은 적에게 추가 피해를 줍니다.",
        186: "채널링하며 여러 개의 구체를 던져 땅에 불타는 지역을 생성합니다.",
        192: "1초 후 지정한 위치에 유성이 충돌하여 대규모 광역 피해를 줍니다.",

        // MARK: - 냉기 지팡이 스킬 (Frost Staff Skills)
        165: "237의 마법 피해를 주고 4.06초 동안 적의 이동 속도를 25% 감소시키는 주문입니다.",
        166: "4m 반경에 406의 마법 피해를 주는 주문입니다.",
        167: "5m 반경의 폭발물을 소환하여 477/524의 피해를 주고 적을 20% 느리게 합니다.",
        168: "순간이동 스킬로 3m 범위의 노바를 방출하여 1.4초/1.54초 동안 기절시키고 201/221의 피해를 줍니다.",
        175: "채널링 광선으로 0.3초마다 82/91의 피해를 주고 중첩되는 둔화 디버프를 부여합니다.",
        181: "전방에 3개의 영역을 연속으로 생성하여 각각 260의 마법 피해를 줍니다.",
        184: "투사체로 3m 반경에 339/372(플레이어) / 258/284(몹)의 가변 피해를 줍니다.",
        190: "적을 1초 동안 기절시킨 후 582(플레이어) / 800(몹)의 피해를 주며 폭발합니다.",

        // MARK: - 신성 지팡이 스킬 (Holy Staff Skills)
        65: "대상 아군에게 치유 기도를 시전하여 266/283의 체력을 회복시킵니다.",
        66: "2.5m 반경에 마법 피해를 주고 3초 내 다음 직접 타격에 추가 피해를 줍니다. 적 적중 시 재사용 대기시간이 50% 감소합니다.",
        67: "지정한 위치에 신성한 섬광을 소환하여 5m 반경 내 최대 5명의 아군에게 262/278의 체력을 회복시킵니다.",
        68: "아군을 치유하고 적에게 피해를 주며, 적 플레이어를 밀어내거나 몹을 공중에 띄웁니다.",
        69: "시간이 지남에 따라 증가하는 채널링 치유로, 6초에 걸쳐 최대 7회 중첩됩니다.",
        70: "대상의 방어구와 받는 치유량을 증가시키고 강제 이동 면역을 부여합니다.",
        71: "투사체로 7m 반경 내 최대 10명의 아군을 충돌 시 치유합니다.",
        72: "쓰러진 아군을 부활시켜 최대 체력의 30%를 회복시킵니다.",
        90: "아군 사이를 튕기는 치유로 최대 10명의 대상에게 적중합니다.",

        // MARK: - 자연 지팡이 스킬 (Nature Staff Skills)
        132: "대상 아군에게 재생 효과를 부여하여 지속적으로 체력을 회복시킵니다.",
        133: "가시 성장을 생성합니다.",
        134: "활력을 부여하여 대상 아군을 치유합니다.",
        135: "정화 치유로 아군의 해로운 효과를 제거하고 치유합니다.",
        137: "재생하는 꽃을 소환합니다.",
        138: "가시덤불 씨앗을 뿌립니다.",
        142: "자연의 보호를 시전하여 아군을 보호합니다.",
        144: "재생의 산들바람으로 범위 내 아군을 치유합니다.",
        145: "최대 5.6초 동안 채널링하며 9m 반경의 오라를 소환하여 이동 속도가 15% 증가합니다.",

        // MARK: - 비전 지팡이 스킬 (Arcane Staff Skills)
        100: "379-416의 마법 피해를 주는 투사체로, 7m 내 최대 3명의 적에게 튕기며 신비한 충전을 부여하여 추가 피해를 발동시킵니다.",
        101: "아군에게 2초 동안 861-946의 피해를 흡수하는 보호막을 부여하고 강제 이동 효과에 면역을 부여합니다.",
        102: "2단 콤보: 원뿔 범위의 적에게 474-520의 피해를 주는 칼날을 소환한 후 0.2초 피해 면역과 함께 순간이동이 가능합니다.",
        103: "4m 반경 내 최대 10명의 아군의 군중 제어와 디버프를 정화하고 이동 속도를 40% 증가시킵니다.",
        106: "296-325의 마법 피해를 주고 4초 동안 적의 방어력을 23.077% 감소시킵니다.",
        117: "3m 반경 내 모든 적을 1.19-1.31초 동안 침묵시키고 387-426의 마법 피해를 줍니다.",
        118: "4.75초 동안 채널링하며 0.25초마다 아군의 피해를 8%씩 증가시킵니다. (최대 10회 중첩)",
        121: "대상 플레이어의 두 번째 슬롯 스킬을 20초 동안 복사하며 독립적인 재사용 대기시간을 가집니다.",
        125: "2m에서 8m 반경으로 커지는 채널링 광역 효과로, 적의 모든 긍정적 효과를 제거하고 아군에게 5초 동안 85의 저항을 부여합니다.",

        // MARK: - 저주 지팡이 스킬 (Cursed Staff Skills)
        243: "60/66의 마법 피해를 주고 8초 동안 각각 243/267의 피해를 주는 저주 충전을 부여합니다. (최대 4회 중첩)",
        244: "관통하는 낫 투사체를 발사하여 60/66의 마법 피해를 주고 시전 위치로 돌아오며, 맞은 모든 적에게 저주 충전을 부여합니다.",
        245: "지정한 방향으로 악마적 광선을 방출하여 맞은 모든 적에게 373/410의 마법 피해를 줍니다. 피해 저항을 49/50 감소시킵니다.",
        246: "4m 반경에 파동을 방출하여 적을 3.63초/3.99초 동안 속박하고 저주 충전을 부여합니다.",
        249: "아군의 일반 공격이 공격 휴지 시간에 따라 증가하는 마법 피해를 주도록 하는 버프입니다.",
        252: "4초 동안 지속되는 3m 웅덩이를 생성하여 적을 10% 느리게 하고 1초마다 저주 충전을 부여합니다.",
        254: "0.5초마다 138/151의 피해를 주는 채널링 광선입니다. 저주 충전이 있는 경우 4m 반경에 195/214의 피해를 줍니다.",
        255: "최대 10명의 대상에게 튕기며 210/230(플레이어)의 피해를 주는 구체입니다.",
        257: "13m 반경에 영향을 주는 광역 저주로, 5.5초 동안 341의 마법 피해를 주고 저항을 53 감소시킵니다.",

        // MARK: - 단검 스킬 (Dagger Skills)
        211: "대상 적을 공격하여 244의 물리 피해를 줍니다. 방어구 분쇄 충전을 부여합니다.",
        212: "지정한 위치로 도약하여 3m 반경의 모든 적에게 258/284의 물리 피해를 줍니다.",
        213: "지정한 방향으로 원뿔 범위에 3개의 투척 칼날을 던져 모든 적을 관통합니다.",
        214: "지정한 위치로 돌진합니다. 4초 동안 모든 피해가 15% 증가합니다.",
        215: "토글 스킬로, 공격당 추가 마법 피해를 주고 생명력을 흡수하며 이동 속도가 증가하지만 자신에게 고정 피해를 입힙니다.",
        216: "일반 공격 시 적이 잃은 체력의 15%를 흡수합니다.",
        219: "대상 적을 공격하여 308의 물리 피해를 줍니다. 받는 치유량과 치유 시전량을 40% 감소시킵니다.",
        217: "적에게 독을 주입하여 지속 피해를 줍니다. 중첩 시 피해가 증가합니다.",
        218: "그림자 속으로 사라져 은신 상태가 됩니다. 은신 중 이동 속도가 증가합니다.",
        220: "대상 뒤로 순간이동하여 기습 공격을 가합니다.",
        221: "연속 베기를 가하여 다중 피해를 줍니다.",
        222: "치명적인 일격을 가하여 대상의 남은 체력에 비례한 피해를 줍니다.",

        // MARK: - 천 방어구 스킬 (Cloth Armor Skills)
        // 머리
        300: "적에게 공포를 주어 일정 시간 동안 도망가게 합니다.",
        301: "마나 보호막을 생성하여 피해를 흡수합니다. 보호막이 유지되는 동안 에너지가 회복됩니다.",
        302: "적의 마법 저항을 감소시키는 저주를 겁니다.",
        303: "정신 집중을 통해 시전 속도와 재사용 대기시간 감소를 얻습니다.",
        304: "적의 버프를 제거하고 자신에게 흡수합니다.",
        305: "암흑 구름을 소환하여 적의 시야를 차단합니다.",
        306: "신비한 에너지로 아군의 피해를 증가시킵니다.",
        // 가슴
        310: "피해를 받을 때 즉시 순간이동합니다.",
        311: "공격 시 마나를 흡수합니다.",
        312: "적에게 받는 피해를 반사합니다.",
        313: "마법 증폭으로 모든 마법 피해가 증가합니다.",
        314: "정화의 빛으로 디버프를 제거합니다.",
        315: "시간 조작으로 재사용 대기시간을 초기화합니다.",
        // 신발
        320: "순간이동으로 짧은 거리를 즉시 이동합니다.",
        321: "에너지 흐름으로 이동하며 에너지를 회복합니다.",
        322: "마법 회피로 다음 마법 공격을 무효화합니다.",
        323: "지속적인 마나 재생 효과를 얻습니다.",

        // MARK: - 가죽 방어구 스킬 (Leather Armor Skills)
        // 머리
        330: "적의 위치를 추적하여 일정 시간 동안 볼 수 있습니다.",
        331: "반사 신경을 활성화하여 회피율이 증가합니다.",
        332: "집중 상태로 공격 속도와 피해가 증가합니다.",
        333: "적에게 출혈을 유발하는 독침을 발사합니다.",
        334: "사냥꾼의 시야로 주변 적을 감지합니다.",
        335: "기습 준비 자세로 다음 공격의 피해가 크게 증가합니다.",
        // 가슴
        340: "구르기로 짧은 거리를 이동하며 피해를 회피합니다.",
        341: "연막탄을 던져 은신 상태가 됩니다.",
        342: "분노 폭발로 공격력이 크게 증가합니다.",
        343: "생존 본능으로 받는 피해가 감소합니다.",
        344: "독을 뿌려 주변 적에게 지속 피해를 줍니다.",
        345: "그림자 망토로 일정 시간 은신합니다.",
        // 신발
        350: "질주로 이동 속도가 크게 증가합니다.",
        351: "도약으로 장애물을 넘어갑니다.",
        352: "추적 불가 상태가 되어 대상 지정을 방지합니다.",
        353: "민첩한 움직임으로 군중 제어 효과를 줄입니다.",

        // MARK: - 판금 방어구 스킬 (Plate Armor Skills)
        // 머리
        360: "도발로 주변 적의 관심을 끌어 위협도를 증가시킵니다.",
        361: "방패를 들어 전방 피해를 차단합니다.",
        362: "전투 함성으로 아군의 사기를 높입니다.",
        363: "집중 방어로 받는 피해를 크게 감소시킵니다.",
        364: "반격 자세로 피해를 받을 때 반격합니다.",
        365: "위압감으로 적의 피해를 감소시킵니다.",
        // 가슴
        370: "무적 상태로 일정 시간 모든 피해에 면역이 됩니다.",
        371: "가시 갑옷으로 근접 공격자에게 피해를 반사합니다.",
        372: "결사 방어로 치명적인 피해를 막습니다.",
        373: "아군을 보호하여 받는 피해를 대신 받습니다.",
        374: "분쇄의 일격으로 적의 방어력을 감소시킵니다.",
        375: "철벽 방어로 받는 피해를 크게 감소시킵니다.",
        // 신발
        380: "돌진으로 전방으로 빠르게 이동합니다.",
        381: "위치 고정으로 강제 이동에 면역이 됩니다.",
        382: "대지 강타로 주변 적을 기절시킵니다.",
        383: "방어적 이동으로 이동하며 피해 감소를 얻습니다.",

        // MARK: - 망토 스킬 (Cape Skills)
        390: "저항력이 일시적으로 증가합니다.",
        391: "에너지 회복 속도가 증가합니다.",
        392: "이동 속도가 일시적으로 증가합니다.",
        393: "피해 흡수 보호막을 생성합니다.",
        394: "군중 제어 효과에 대한 저항이 증가합니다.",
        395: "체력 재생 속도가 증가합니다.",

        // MARK: - 추가 무기 스킬 (Additional Weapon Skills)
        // 추가 검 스킬
        152: "방어 자세를 취하여 받는 피해를 감소시키고 반격 기회를 노립니다.",
        153: "회전 베기로 주변 모든 적에게 피해를 줍니다.",
        154: "결정적인 일격으로 대상에게 큰 피해를 줍니다.",
        155: "돌진 베기로 전방으로 이동하며 경로상의 적에게 피해를 줍니다.",
        156: "칼날 폭풍으로 넓은 범위에 다중 피해를 줍니다.",
        157: "최후의 일격으로 대상의 남은 체력에 비례한 피해를 줍니다.",

        // 추가 도끼 스킬
        8: "피의 광란으로 공격 속도와 생명력 흡수가 증가합니다.",

        // 추가 망치 스킬
        116: "지진 강타로 넓은 범위에 피해를 주고 적을 기절시킵니다.",
        119: "파괴의 일격으로 대상의 방어력을 무시합니다.",
        120: "충격파로 전방의 모든 적을 밀어냅니다.",

        // 추가 활 스킬
        200: "치명적인 사격으로 대상에게 큰 피해를 줍니다. 거리에 따라 피해가 증가합니다.",
        201: "다중 화살로 여러 대상을 동시에 공격합니다.",

        // 추가 신성 스킬
        73: "천상의 축복으로 아군의 방어력과 치유량이 증가합니다.",
        77: "정화의 빛으로 아군의 디버프를 제거합니다.",
        78: "신성한 불꽃으로 언데드에게 추가 피해를 줍니다.",

        // 추가 자연 스킬
        136: "자연의 분노로 가시덤불이 적에게 피해를 줍니다.",
        139: "치유의 비로 범위 내 모든 아군을 치유합니다.",
        140: "생명의 나무를 소환하여 지속적으로 아군을 치유합니다.",
        141: "뿌리 속박으로 적을 움직이지 못하게 합니다.",
        143: "자연의 힘으로 아군의 피해를 증가시킵니다.",
        146: "재생의 포자를 뿌려 범위 치유를 합니다.",
        147: "대자연의 보호로 아군에게 보호막을 부여합니다.",

        // 추가 화염 스킬
        162: "화염 폭발로 대상 주변에 광역 피해를 줍니다.",
        169: "용암 웅덩이를 생성하여 지속 피해를 줍니다.",
        172: "불꽃 정령을 소환하여 전투를 돕습니다.",
        173: "화염 방패로 근접 공격자에게 피해를 반사합니다.",
        174: "태양의 분노로 강력한 범위 피해를 줍니다.",

        // 추가 냉기 스킬
        176: "얼음 창을 발사하여 대상을 관통합니다.",
        177: "빙결 오라로 주변 적의 이동 속도를 감소시킵니다.",
        178: "눈폭풍을 소환하여 범위 피해와 둔화를 줍니다.",
        179: "얼음 장벽을 생성하여 적의 이동을 차단합니다.",
        180: "냉기 폭발로 주변 적을 동결시킵니다.",
        182: "빙결 광선으로 대상을 완전히 동결시킵니다.",
        187: "서리 갑옷으로 받는 피해를 감소시킵니다.",
        188: "얼음 정령을 소환합니다.",
        189: "절대 영도로 범위 내 모든 적을 동결시킵니다.",
        191: "얼음 비로 범위에 지속 피해를 줍니다.",
        193: "빙산을 소환하여 적을 밀어냅니다.",
        194: "냉기 충격으로 대상을 밀어내고 둔화시킵니다.",
        195: "동상으로 대상의 공격 속도를 감소시킵니다.",

        // 추가 저주 스킬
        247: "영혼 수확으로 처치한 적으로부터 체력을 흡수합니다.",
        250: "공포의 저주로 적을 도망가게 합니다.",
        251: "허약의 저주로 적의 피해를 감소시킵니다.",
        253: "고통의 고리로 범위 내 적에게 지속 피해를 줍니다.",
        256: "죽음의 표식으로 대상이 받는 피해가 증가합니다.",
        258: "영혼 폭발로 저주 충전을 소모하여 큰 피해를 줍니다.",
        259: "저주받은 땅을 생성하여 적에게 지속 피해를 줍니다.",
        260: "생명력 전환으로 자신의 체력을 소모하여 적에게 피해를 줍니다.",

        // 추가 비전 스킬
        104: "신비한 폭발로 범위 피해를 줍니다.",
        107: "마력 흡수로 적의 에너지를 빼앗습니다.",
        109: "차원 균열로 적을 다른 위치로 순간이동시킵니다.",
        110: "시간 왜곡으로 아군의 재사용 대기시간을 감소시킵니다.",
        122: "마법 폭풍으로 범위 내 적에게 다중 피해를 줍니다.",
        124: "에너지 폭발로 주변 적에게 피해를 줍니다.",
        126: "보호의 구체로 아군을 감싸 피해를 흡수합니다.",
        127: "마력 증폭으로 아군의 마법 피해를 증가시킵니다.",
        128: "혼란의 파동으로 적의 시전을 방해합니다.",
        129: "공간 이동으로 아군의 위치를 교환합니다.",
        130: "마력 고갈로 적의 에너지 회복을 차단합니다.",
        131: "신비한 화살로 여러 대상을 공격합니다.",

        // 추가 쿼터스태프 스킬
        18: "균형의 일격으로 적을 밀어내고 아군을 치유합니다.",
        21: "명상으로 에너지와 체력을 회복합니다.",
        22: "태풍 강타로 주변 적에게 피해를 주고 밀어냅니다.",
        23: "철벽 방어로 받는 피해를 크게 감소시킵니다.",
        25: "정의의 일격으로 대상에게 추가 피해를 줍니다.",

        // 추가 창 스킬
        45: "관통 찌르기로 적의 방어력을 무시합니다.",
        93: "창 투척으로 원거리 적에게 피해를 줍니다.",
        94: "창 휘두르기로 주변 적에게 피해를 줍니다.",
        96: "돌격 찌르기로 전방으로 이동하며 피해를 줍니다.",
        97: "숙련된 공격으로 연속 찌르기를 가합니다.",
        98: "영혼 폭발로 충전을 소모하여 범위 피해를 줍니다.",

        // 추가 워글러브 스킬
        28: "연속 펀치로 다중 피해를 줍니다.",
        29: "잡기 기술로 적을 붙잡아 피해를 줍니다.",
        32: "기 모으기로 다음 공격의 피해를 증가시킵니다.",
        33: "회피기로 적의 공격을 피합니다.",
        34: "반격으로 피해를 받은 후 강력한 공격을 가합니다.",
        36: "천둥 주먹으로 범위 피해를 줍니다.",
        37: "용의 발차기로 적을 밀어냅니다.",

        // 추가 철퇴 스킬
        50: "신성한 일격으로 언데드에게 추가 피해를 줍니다.",
        51: "보호의 오라로 주변 아군의 방어력을 증가시킵니다.",
        52: "정의의 심판으로 대상에게 큰 피해를 줍니다.",
        53: "치유의 손길로 아군을 치유합니다.",
        54: "축복의 망치로 공격과 동시에 아군을 치유합니다.",
        55: "신성한 분노로 공격력이 크게 증가합니다.",
        56: "정화의 일격으로 적의 버프를 제거합니다.",
        57: "수호자의 맹세로 아군을 보호합니다.",
        58: "심판의 시간으로 범위 내 적에게 피해를 줍니다.",
        59: "불굴의 의지로 군중 제어에 면역이 됩니다.",
        60: "보복의 일격으로 받은 피해에 비례하여 공격합니다.",
        61: "결사의 방어로 받는 피해를 크게 감소시킵니다.",
        62: "신성한 돌진으로 전방으로 이동하며 피해를 줍니다.",
        63: "축복받은 갑옷으로 피해 저항이 증가합니다.",
        64: "영적 연결로 아군과 체력을 공유합니다.",

        // 추가 석궁 스킬
        79: "연발 사격으로 빠르게 여러 발을 발사합니다.",
        80: "폭발 화살로 범위 피해를 줍니다.",
        81: "관통탄으로 여러 적을 관통합니다.",
        82: "저격으로 원거리 대상에게 큰 피해를 줍니다.",
        83: "산탄 사격으로 근거리 적에게 다중 피해를 줍니다.",
        84: "마비 화살로 대상을 기절시킵니다.",
        85: "화염 화살로 지속 피해를 줍니다.",
        86: "얼음 화살로 대상을 둔화시킵니다.",
        87: "독 화살로 지속 피해를 줍니다.",
        89: "명사수의 집중으로 다음 사격의 피해가 증가합니다.",

        // 추가 활 스킬
        223: "급소 사격으로 치명타 확률이 증가합니다.",
        224: "회피 사격으로 뒤로 이동하며 사격합니다.",
        225: "추적 화살로 대상을 따라가는 화살을 발사합니다.",
        226: "비 화살로 범위에 다중 화살을 발사합니다.",
        227: "속사로 공격 속도가 크게 증가합니다.",
        228: "침묵 화살로 대상의 시전을 방해합니다.",
        229: "속박 화살로 대상을 속박합니다.",
        230: "치명적 화살로 대상의 남은 체력에 비례한 피해를 줍니다.",
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

    /// 스킬 설명을 한국어로 변환
    func localizeSkillDescription(id: Int, original: String) -> String {
        // 현재 언어가 한국어가 아니면 원본 반환
        guard Locale.current.language.languageCode?.identifier == "ko" else {
            return original
        }

        // 스킬 설명 검색
        if let koreanDescription = skillDescriptions[id] {
            return koreanDescription
        }

        // 매핑이 없으면 원본 반환
        return original
    }

    /// 스킬 속성 이름을 한국어로 변환
    func localizeAttribute(_ name: String) -> String {
        // 현재 언어가 한국어가 아니면 원본 반환
        guard Locale.current.language.languageCode?.identifier == "ko" else {
            return name
        }

        // 속성 이름 검색
        if let koreanName = attributeNames[name] {
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

    var localizedDescription: String {
        ItemLocalization.shared.localizeSkillDescription(id: id, original: description)
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

    var localizedName: String {
        ItemLocalization.shared.localizeAttribute(name)
    }
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

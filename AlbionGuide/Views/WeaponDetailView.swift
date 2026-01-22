import SwiftUI
import SDWebImageSwiftUI

struct WeaponDetailView: View {
    @StateObject private var viewModel: WeaponDetailViewModel
    @EnvironmentObject private var storage: LocalStorageService
    @State private var selectedTab = 0

    init(weapon: Weapon) {
        _viewModel = StateObject(wrappedValue: WeaponDetailViewModel(weapon: weapon))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                weaponHeader

                Picker(String(localized: "info"), selection: $selectedTab) {
                    Text(String(localized: "skills")).tag(0)
                    Text(String(localized: "stats")).tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 40)
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        Task { await viewModel.loadDetails() }
                    }
                } else {
                    if selectedTab == 0 {
                        spellsContent
                    } else {
                        statsContent
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(viewModel.weapon.localizedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    storage.toggleFavoriteWeapon(viewModel.weapon.id)
                } label: {
                    Image(systemName: storage.isWeaponFavorite(viewModel.weapon.id) ? "star.fill" : "star")
                        .foregroundStyle(storage.isWeaponFavorite(viewModel.weapon.id) ? .yellow : .secondary)
                }
            }
        }
        .onAppear {
            storage.addRecentViewed(weaponId: viewModel.weapon.id)
        }
    }

    private var weaponHeader: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: viewModel.weapon.icon)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                default:
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.system(size: 50))
                        .foregroundStyle(.secondary)
                        .frame(width: 120, height: 120)
                }
            }
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 8, y: 4)

            Text(viewModel.weapon.localizedName)
                .font(.title2.bold())

            HStack(spacing: 12) {
                TierBadge(tier: viewModel.weapon.tierNumber, enchantment: viewModel.weapon.enchantment)

                Label("\(viewModel.weapon.itemPower)", systemImage: "bolt.fill")
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
            ForEach(viewModel.spellSlots) { slot in
                SpellSlotSection(slot: slot)
            }
        }
        .padding(.horizontal)
    }

    private var statsContent: some View {
        VStack(spacing: 16) {
            if !viewModel.availableEnchantments.isEmpty {
                VStack(spacing: 12) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(viewModel.availableEnchantments, id: \.self) { ench in
                                Button {
                                    viewModel.selectedEnchantment = ench
                                } label: {
                                    Text(ench == 0 ? String(localized: "base") : ".\(ench)")
                                        .font(.subheadline.bold())
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(viewModel.selectedEnchantment == ench ? Color.orange : Color(.tertiarySystemBackground))
                                        .foregroundStyle(viewModel.selectedEnchantment == ench ? .white : .primary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(viewModel.qualities, id: \.self) { quality in
                                Button {
                                    viewModel.selectedQuality = quality
                                } label: {
                                    Text(qualityName(quality))
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(viewModel.selectedQuality == quality ? qualityColor(quality) : Color(.tertiarySystemBackground))
                                        .foregroundStyle(viewModel.selectedQuality == quality ? .white : .primary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }

            if let stats = viewModel.currentStats {
                VStack(spacing: 8) {
                    ForEach(stats, id: \.name) { stat in
                        StatRow(name: stat.name, value: stat.value)
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
            } else {
                Text(String(localized: "no_stats"))
                    .foregroundStyle(.secondary)
                    .padding()
            }
        }
    }

    private func qualityName(_ quality: String) -> String {
        switch quality {
        case "Normal": return String(localized: "quality_normal")
        case "Good": return String(localized: "quality_good")
        case "Outstanding": return String(localized: "quality_outstanding")
        case "Excellent": return String(localized: "quality_excellent")
        case "Masterpiece": return String(localized: "quality_masterpiece")
        default: return quality
        }
    }

    private func qualityColor(_ quality: String) -> Color {
        switch quality {
        case "Normal": return .gray
        case "Good": return .green
        case "Outstanding": return .blue
        case "Excellent": return .purple
        case "Masterpiece": return .orange
        default: return .gray
        }
    }
}

struct SpellSlotSection: View {
    let slot: SpellSlot
    @State private var expandedSpell: Int?

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

    var slotName: String {
        switch slot.slot {
        case "First Slot": return String(localized: "q_skill")
        case "Second Slot": return String(localized: "w_skill")
        case "Third Slot": return String(localized: "e_skill")
        case "Passive": return String(localized: "passive")
        default: return slot.slot
        }
    }
}

struct SpellCardView: View {
    let spell: Spell
    let isExpanded: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: onTap) {
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: spell.icon)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            Image(systemName: "sparkles")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(width: 48, height: 48)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(spell.localizedName)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        HStack(spacing: 8) {
                            ForEach(spell.attributes.prefix(3), id: \.name) { attr in
                                Text("\(attr.name): \(attr.value)")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    if let previewURL = spell.preview, !previewURL.isEmpty {
                        WebImage(url: URL(string: previewURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            ProgressView()
                                .frame(height: 150)
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.3))
                        .frame(maxWidth: .infinity)
                    }

                    VStack(spacing: 8) {
                        ForEach(spell.attributes, id: \.name) { attr in
                            HStack {
                                Text(attr.name)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(attr.value)
                                    .font(.caption.bold())
                            }
                        }
                    }
                    .padding()
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text(cleanDescription(spell.description))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func cleanDescription(_ text: String) -> String {
        text
            .replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\n\n", with: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct StatRow: View {
    let name: String
    let value: String

    var body: some View {
        HStack {
            Text(name)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.subheadline.bold())
                .foregroundStyle(.primary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        WeaponDetailView(weapon: Weapon(
            id: 1,
            name: "Adept's Battleaxe",
            tier: "4.0",
            itemPower: 700,
            icon: "https://render.albiononline.com/v1/item/[email protected]"
        ))
    }
    .environmentObject(LocalStorageService.shared)
}

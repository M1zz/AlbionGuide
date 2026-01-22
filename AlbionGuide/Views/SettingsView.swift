import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var storage: LocalStorageService
    @State private var showingClearAlert = false
    @State private var showingClearCacheAlert = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "shield.lefthalf.filled")
                            .font(.largeTitle)
                            .foregroundStyle(.orange)

                        VStack(alignment: .leading) {
                            Text("Albion Guide")
                                .font(.headline)
                            Text("v1.0.0")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section(String(localized: "statistics")) {
                    SettingsStatRow(title: String(localized: "favorite_weapons"), value: String(localized: "\(storage.favoriteWeaponIds.count) items"))
                    SettingsStatRow(title: String(localized: "favorite_armor"), value: String(localized: "\(storage.favoriteArmorIds.count) items"))
                    SettingsStatRow(title: String(localized: "saved_builds"), value: String(localized: "\(storage.builds.count) items"))
                    SettingsStatRow(title: String(localized: "recently_viewed"), value: String(localized: "\(storage.recentViewedWeaponIds.count) items"))
                }

                Section(String(localized: "data_management")) {
                    Button {
                        showingClearCacheAlert = true
                    } label: {
                        Label(String(localized: "clear_cache"), systemImage: "arrow.triangle.2.circlepath")
                    }

                    Button(role: .destructive) {
                        showingClearAlert = true
                    } label: {
                        Label(String(localized: "clear_all_data"), systemImage: "trash")
                    }
                }

                Section(String(localized: "information")) {
                    Link(destination: URL(string: "https://openalbion.com")!) {
                        Label("OpenAlbion API", systemImage: "link")
                    }

                    Link(destination: URL(string: "https://albiononline.com")!) {
                        Label(String(localized: "official_website"), systemImage: "globe")
                    }

                    Link(destination: URL(string: "https://wiki.albiononline.com")!) {
                        Label("Albion Online Wiki", systemImage: "book")
                    }
                }

                Section {
                    Text(String(localized: "disclaimer"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(String(localized: "settings"))
            .alert(String(localized: "clear_cache"), isPresented: $showingClearCacheAlert) {
                Button(String(localized: "cancel"), role: .cancel) { }
                Button(String(localized: "reset")) {
                    Task {
                        await OpenAlbionAPI.shared.clearCache()
                    }
                }
            } message: {
                Text(String(localized: "clear_cache_message"))
            }
            .alert(String(localized: "clear_all_data"), isPresented: $showingClearAlert) {
                Button(String(localized: "cancel"), role: .cancel) { }
                Button(String(localized: "reset"), role: .destructive) {
                    storage.clearAll()
                }
            } message: {
                Text(String(localized: "clear_all_data_message"))
            }
        }
    }
}

struct SettingsStatRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LocalStorageService.shared)
}

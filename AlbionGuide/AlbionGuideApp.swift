import SwiftUI

@main
struct AlbionGuideApp: App {
    @StateObject private var storage = LocalStorageService.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storage)
        }
    }
}

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            WeaponListView()
                .tabItem {
                    Label(String(localized: "weapons"), systemImage: "shield.lefthalf.filled")
                }
                .tag(0)

            ArmorListView()
                .tabItem {
                    Label(String(localized: "armor"), systemImage: "tshirt.fill")
                }
                .tag(1)

            SearchView()
                .tabItem {
                    Label(String(localized: "search"), systemImage: "magnifyingglass")
                }
                .tag(2)

            BuildListView()
                .tabItem {
                    Label(String(localized: "builds"), systemImage: "square.stack.3d.up.fill")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    Label(String(localized: "settings"), systemImage: "gearshape.fill")
                }
                .tag(4)
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalStorageService.shared)
}

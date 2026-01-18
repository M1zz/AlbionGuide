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
                    Label("무기", systemImage: "shield.lefthalf.filled")
                }
                .tag(0)
            
            ArmorListView()
                .tabItem {
                    Label("방어구", systemImage: "tshirt.fill")
                }
                .tag(1)
            
            SearchView()
                .tabItem {
                    Label("검색", systemImage: "magnifyingglass")
                }
                .tag(2)
            
            BuildListView()
                .tabItem {
                    Label("빌드", systemImage: "square.stack.3d.up.fill")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Label("설정", systemImage: "gearshape.fill")
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

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
                
                Section("통계") {
                    SettingsStatRow(title: "즐겨찾기 무기", value: "\(storage.favoriteWeaponIds.count)개")
                    SettingsStatRow(title: "즐겨찾기 방어구", value: "\(storage.favoriteArmorIds.count)개")
                    SettingsStatRow(title: "저장된 빌드", value: "\(storage.builds.count)개")
                    SettingsStatRow(title: "최근 본 아이템", value: "\(storage.recentViewedWeaponIds.count)개")
                }
                
                Section("데이터 관리") {
                    Button {
                        showingClearCacheAlert = true
                    } label: {
                        Label("캐시 초기화", systemImage: "arrow.triangle.2.circlepath")
                    }
                    
                    Button(role: .destructive) {
                        showingClearAlert = true
                    } label: {
                        Label("모든 데이터 초기화", systemImage: "trash")
                    }
                }
                
                Section("정보") {
                    Link(destination: URL(string: "https://openalbion.com")!) {
                        Label("OpenAlbion API", systemImage: "link")
                    }
                    
                    Link(destination: URL(string: "https://albiononline.com")!) {
                        Label("Albion Online 공식 사이트", systemImage: "globe")
                    }
                    
                    Link(destination: URL(string: "https://wiki.albiononline.com")!) {
                        Label("Albion Online Wiki", systemImage: "book")
                    }
                }
                
                Section {
                    Text("이 앱은 Sandbox Interactive GmbH와 관련이 없는 비공식 팬 앱입니다. Albion Online 및 관련 로고는 Sandbox Interactive GmbH의 상표입니다.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("설정")
            .alert("캐시 초기화", isPresented: $showingClearCacheAlert) {
                Button("취소", role: .cancel) { }
                Button("초기화") {
                    Task {
                        await OpenAlbionAPI.shared.clearCache()
                    }
                }
            } message: {
                Text("캐시된 데이터를 초기화하고 새로 불러옵니다.")
            }
            .alert("모든 데이터 초기화", isPresented: $showingClearAlert) {
                Button("취소", role: .cancel) { }
                Button("초기화", role: .destructive) {
                    storage.clearAll()
                }
            } message: {
                Text("즐겨찾기, 빌드, 최근 본 아이템 등 모든 저장된 데이터가 삭제됩니다.")
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

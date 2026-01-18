import SwiftUI

struct BuildListView: View {
    @EnvironmentObject private var storage: LocalStorageService
    @State private var showingNewBuild = false
    @State private var selectedBuild: Build?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if storage.builds.isEmpty {
                    emptyBuildsView
                } else {
                    buildsList
                }
            }
            .navigationTitle("내 빌드")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewBuild = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewBuild) {
                BuildEditorView(build: nil)
            }
            .sheet(item: $selectedBuild) { build in
                BuildEditorView(build: build)
            }
        }
    }
    
    private var emptyBuildsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "square.stack.3d.up.slash")
                .font(.system(size: 60))
                .foregroundStyle(.tertiary)
            
            VStack(spacing: 8) {
                Text("저장된 빌드가 없습니다")
                    .font(.headline)
                
                Text("자신만의 장비 조합을 만들어보세요")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Button {
                showingNewBuild = true
            } label: {
                Label("새 빌드 만들기", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
    }
    
    private var buildsList: some View {
        List {
            ForEach(storage.builds) { build in
                BuildRowView(build: build)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedBuild = build
                    }
            }
            .onDelete(perform: deleteBuild)
        }
        .listStyle(.insetGrouped)
    }
    
    private func deleteBuild(at offsets: IndexSet) {
        for index in offsets {
            storage.deleteBuild(storage.builds[index])
        }
    }
}

struct BuildRowView: View {
    let build: Build
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(build.name)
                    .font(.headline)
                
                Spacer()
                
                Text(build.updatedAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            if !build.notes.isEmpty {
                Text(build.notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            HStack(spacing: 8) {
                ForEach(0..<5) { _ in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(.tertiarySystemBackground))
                        .frame(width: 36, height: 36)
                        .overlay {
                            Image(systemName: "questionmark")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct BuildEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var storage: LocalStorageService
    
    let existingBuild: Build?
    
    @State private var name: String
    @State private var notes: String
    @State private var weaponId: Int?
    @State private var headId: Int?
    @State private var chestId: Int?
    @State private var shoesId: Int?
    @State private var capeId: Int?
    
    init(build: Build?) {
        self.existingBuild = build
        _name = State(initialValue: build?.name ?? "새 빌드")
        _notes = State(initialValue: build?.notes ?? "")
        _weaponId = State(initialValue: build?.weaponId)
        _headId = State(initialValue: build?.headId)
        _chestId = State(initialValue: build?.chestId)
        _shoesId = State(initialValue: build?.shoesId)
        _capeId = State(initialValue: build?.capeId)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("기본 정보") {
                    TextField("빌드 이름", text: $name)
                    
                    TextField("메모", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("장비 구성") {
                    equipmentSlot(title: "무기", icon: "shield.lefthalf.filled", itemId: $weaponId)
                    equipmentSlot(title: "머리", icon: "crown.fill", itemId: $headId)
                    equipmentSlot(title: "갑옷", icon: "tshirt.fill", itemId: $chestId)
                    equipmentSlot(title: "신발", icon: "shoe.fill", itemId: $shoesId)
                    equipmentSlot(title: "망토", icon: "wind", itemId: $capeId)
                }
                
                Section {
                    Text("장비 선택 기능은 향후 업데이트에서 추가될 예정입니다.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(existingBuild == nil ? "새 빌드" : "빌드 수정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        saveBuild()
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func equipmentSlot(title: String, icon: String, itemId: Binding<Int?>) -> some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundStyle(.orange)
            
            Text(title)
            
            Spacer()
            
            if itemId.wrappedValue != nil {
                Text("선택됨")
                    .foregroundStyle(.secondary)
            } else {
                Text("비어있음")
                    .foregroundStyle(.tertiary)
            }
        }
    }
    
    private func saveBuild() {
        if var existing = existingBuild {
            existing.name = name
            existing.notes = notes
            existing.weaponId = weaponId
            existing.headId = headId
            existing.chestId = chestId
            existing.shoesId = shoesId
            existing.capeId = capeId
            storage.updateBuild(existing)
        } else {
            var newBuild = Build(name: name)
            newBuild.notes = notes
            newBuild.weaponId = weaponId
            newBuild.headId = headId
            newBuild.chestId = chestId
            newBuild.shoesId = shoesId
            newBuild.capeId = capeId
            storage.addBuild(newBuild)
        }
    }
}

#Preview {
    BuildListView()
        .environmentObject(LocalStorageService.shared)
}

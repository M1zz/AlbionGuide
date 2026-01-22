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
            .navigationTitle(String(localized: "my_builds"))
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
                Text(String(localized: "no_builds"))
                    .font(.headline)

                Text(String(localized: "create_build_hint"))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Button {
                showingNewBuild = true
            } label: {
                Label(String(localized: "create_new_build"), systemImage: "plus")
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
        _name = State(initialValue: build?.name ?? String(localized: "new_build"))
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
                Section(String(localized: "basic_info")) {
                    TextField(String(localized: "build_name"), text: $name)

                    TextField(String(localized: "notes"), text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section(String(localized: "equipment")) {
                    equipmentSlot(title: String(localized: "weapon"), icon: "shield.lefthalf.filled", itemId: $weaponId)
                    equipmentSlot(title: String(localized: "head"), icon: "crown.fill", itemId: $headId)
                    equipmentSlot(title: String(localized: "chest"), icon: "tshirt.fill", itemId: $chestId)
                    equipmentSlot(title: String(localized: "shoes"), icon: "shoe.fill", itemId: $shoesId)
                    equipmentSlot(title: String(localized: "cape"), icon: "wind", itemId: $capeId)
                }

                Section {
                    Text(String(localized: "equipment_selection_coming"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(existingBuild == nil ? String(localized: "new_build") : String(localized: "edit_build"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "cancel")) {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(String(localized: "save")) {
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
                Text(String(localized: "selected"))
                    .foregroundStyle(.secondary)
            } else {
                Text(String(localized: "empty"))
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

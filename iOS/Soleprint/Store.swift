import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [Block] = []
    @Published var isPro: Bool = false

    static let freeLimit = 12

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("soleprint_items.json")
    }()

    init() {
        load()
        if items.isEmpty {
            items = [
            Block(title: "Block title 1", inkColor: "Ink color 1", substrate: "Fabric/paper used 1", runCount: 10, notes: "Notes 1"),
            Block(title: "Block title 2", inkColor: "Ink color 2", substrate: "Fabric/paper used 2", runCount: 13, notes: "Notes 2"),
            Block(title: "Block title 3", inkColor: "Ink color 3", substrate: "Fabric/paper used 3", runCount: 16, notes: "Notes 3")
            ]
            save()
        }
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Block) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Block) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Block) {
        items.removeAll { $0.id == item.id }
        save()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([Block].self, from: data) {
            items = decoded
        }
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}

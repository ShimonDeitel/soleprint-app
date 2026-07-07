import Foundation

struct Block: Identifiable, Codable, Equatable {
    let id: UUID
    var dateCreated: Date
    var title: String
    var inkColor: String
    var substrate: String
    var runCount: Double
    var notes: String

    init(id: UUID = UUID(), dateCreated: Date = Date(), title: String = "", inkColor: String = "", substrate: String = "", runCount: Double = 0, notes: String = "") {
        self.id = id
        self.dateCreated = dateCreated
        self.title = title
        self.inkColor = inkColor
        self.substrate = substrate
        self.runCount = runCount
        self.notes = notes
    }
}

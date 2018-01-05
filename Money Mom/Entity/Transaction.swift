import Foundation
import CoreData

@objc class TransactionType: NSObject, NSCoding {
    static let INCOME: TransactionType = TransactionType(rawValue: 0)
    static let EXPENSE: TransactionType = TransactionType(rawValue: 1)

    let rawValue: Int

    private init(rawValue: Int) {
        self.rawValue = rawValue
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(rawValue, forKey: "rawValue")
    }

    required init?(coder aDecoder: NSCoder) {
        self.rawValue = aDecoder.decodeInteger(forKey: "rawValue")
    }
}

extension TransactionType {
    static func ==(lhs: TransactionType, rhs: TransactionType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

class Transaction: QuickRecordBase {
    func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged var location: String
    @NSManaged var type: TransactionType
    @NSManaged var quickRecord: QuickRecord?

    @objc var createdAtDay: String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.timeZone = TimeZone.current
            return formatter.string(from: createdAt)
        }
    }

}
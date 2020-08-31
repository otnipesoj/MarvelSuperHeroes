import Foundation

struct MarvelData<T: Codable>: Codable {
    let offset:  Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}

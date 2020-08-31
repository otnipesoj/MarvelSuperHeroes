import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let code : Int
    let status : String
    let data : MarvelData<T>
}

import Foundation 

enum PexelResponseKeys: String, CodingKey {
    case page
    case per_page
    case total_results
    case next_page
    case prev_page
    case photos
}

private extension String {
    func extractValue() -> Int {
        let newValue = replacingOccurrences(of: "\(Constants.api)/v1/curated/?page=", with: "")
        
        if newValue.isEmpty { return 0 }
        
        let result =  newValue.split(separator: "&")
        
        if result.isEmpty || result.count == 1 { return 0}
        
        return Int(String(result.first ?? "")) ?? 0
    }
}

extension PexelResponse {
    
    static var empty: PexelResponse {
        PexelResponse(page: 0, perPage: 0, totalResults: 0, nextPage: 0, prevPage: 0, data: [])
    }
    
    var hasData: Bool {
        get { !data.isEmpty }
    }
    
    var hasNext: Bool {
        get { nextPage > 0 }
    }
    
    var hasPrevious: Bool {
        get { prevPage > 0 }
    }
    
    var totalPage: Int {
        get { 
            return (totalResults > 0 && perPage > 0) ?  totalResults / perPage : 0
        }
    }
    
    func copyWith(page: Int?, perPage: Int?,totalResults: Int?,nextPage: Int?,prevPage: Int?,data: [Any]?) -> PexelResponse{
        PexelResponse(
            page: page ?? self.page,
            perPage:  perPage ?? self.perPage,
            totalResults:   totalResults ?? self.totalResults,
            nextPage:   nextPage ?? self.nextPage,
            prevPage:   prevPage ?? self.prevPage,
            data:  data ?? self.data)
    }
    
}

struct PexelResponse: Decodable {
    let page: Int
    let perPage: Int
    let totalResults: Int
    let nextPage: Int
    let prevPage: Int
    let data: [Any]
    
    init(page: Int, perPage: Int,totalResults: Int,nextPage: Int,prevPage: Int,data: [Any]) {
        self.page = page
        self.perPage = perPage
        self.totalResults = totalResults
        self.nextPage = nextPage
        self.prevPage = prevPage
        self.data = data
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PexelResponseKeys.self)
        page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 1
        perPage = try container.decodeIfPresent(Int.self, forKey: .per_page) ?? 20
        totalResults = try container.decodeIfPresent(Int.self, forKey: .total_results) ?? 0
        nextPage = (try container.decodeIfPresent(String.self, forKey: .next_page) ?? "").extractValue()
        prevPage = (try container.decodeIfPresent(String.self, forKey: .prev_page) ?? "").extractValue()
        if  container.contains(.photos) {
            data = try container.decodeIfPresent([PexelPhoto].self, forKey: .photos) ?? []
        }else{
            data = []
        }
       
    }
}


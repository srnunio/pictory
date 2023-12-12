//
//  Pexel.swift
//  Pictory
//
//  Created by Edvaldo Martins on 24/11/2023.
//

import Foundation 
import SwiftUI

extension PexelPhoto {

    var originalImage:String {
        src.isEmpty ? "" : src["original"] ?? ""
    }
    
    var large2xImage:String {
        src.isEmpty ? "" : src["large2x"] ?? ""
    }
    
    var largeImage:String {
        src.isEmpty ? "" : src["large"] ?? ""
    }
    
    var mediumImage:String {
        src.isEmpty ? "" : src["medium"] ?? ""
    }
    
    static var mockData: PexelPhoto {
        let jsonData = """
    {
        "id": 19092965,
        "width": 2832,
        "height": 4240,
        "url": "https://www.pexels.com/photo/people-and-fisherman-by-bosporus-in-istanbul-turkey-19092965/",
        "photographer": "emrullah ağır",
        "photographer_url": "https://www.pexels.com/@emrullah-agir-774987228",
        "photographer_id": 774987228,
        "avg_color": "#B7B7AF",
        "src": {
            "original": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg",
            "large2x": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
            "large": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
            "medium": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg?auto=compress&cs=tinysrgb&h=350",
            "small": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg?auto=compress&cs=tinysrgb&h=130",
            "portrait": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
            "landscape": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
            "tiny": "https://images.pexels.com/photos/19092965/pexels-photo-19092965.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
        },
        "liked": false,
        "alt": "Free stock photo of camii, fisherman, istanbul"
    }
 """
        return try! JSONDecoder().decode(PexelPhoto.self, from: Data(jsonData.utf8))
    }
    
    func copyWith(isFavorite: Bool?) -> PexelPhoto {
       
        PexelPhoto(
            id: id,
            width: width,
            height: height,
            avgColor: avgColor,
            alt: alt,
            src: src,
            isFavorite: isFavorite ?? self.isFavorite)
    }
}

private enum PexelPhotoKeys : String, CodingKey {
    case id, width, height, avg_color,alt,src
}

struct PexelPhoto:Identifiable, Codable, Hashable, Equatable {
    
    var id: Int64
    var width: Int
    var height: Int
    var avgColor: String
    var alt: String
    var src: [String:String]
    var isFavorite: Bool = false
    var isDownloaded: Bool = true
   
    init(id: Int64, width: Int, height: Int, avgColor: String, alt: String, src: [String : String], isFavorite: Bool) {
        self.id = id
        self.width = width
        self.height = height
        self.avgColor = avgColor
        self.alt = alt
        self.src = src
        self.isFavorite = isFavorite
    }

    init (from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: PexelPhotoKeys.self)
        id = try data.decodeIfPresent(Int64.self, forKey: .id) ?? 0
        width = try data.decodeIfPresent(Int.self, forKey: .width) ?? 0
        height = try data.decodeIfPresent(Int.self, forKey: .height) ?? 0
        avgColor = try data.decodeIfPresent(String.self, forKey: .avg_color) ?? ""
        alt = try data.decodeIfPresent(String.self, forKey: .alt) ?? ""
        src = try data.decodeIfPresent([String: String].self, forKey: .src) ?? [String: String]()
    }
}


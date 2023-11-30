//
//  PexelTests.swift
//  PictoryTests
//
//  Created by Edvaldo Martins on 25/11/2023.
//

import Foundation
import XCTest
@testable import Pictory
import ObjectMapper

final class PexelTests: XCTestCase {
//    func testParseJsonToPhoto() throws {
//        
////        let user = Mapper<PexelPhoto>().map(JSONString: JSONString)
//        let json = """
//        {
//            "id": 19202906,
//            "width": 4851,
//            "height": 4160,
//            "url": "https://www.pexels.com/photo/a-close-up-of-a-green-leafy-vegetable-19202906/",
//            "photographer": "Ellie Burgin",
//            "photographer_url": "https://www.pexels.com/@ellie-burgin-1661546",
//            "photographer_id": 1661546,
//            "avg_color": "#525E1C",
//            "src": {
//                "original": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg",
//                "large2x": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
//                "large": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
//                "medium": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=350",
//                "small": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=130",
//                "portrait": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
//                "landscape": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
//                "tiny": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
//            },
//            "liked": false,
//            "alt": ""
//        }
// """
//        
//        let photo = Mapper<PexelPhoto>().map(JSONString: json)
//        
//        if photo == nil {
//            XCTFail("Failed to decode JSON into the model:")
//        } else {
//            print(photo?.src)
//        }
//    } 
    
    func testParseJsonToPhoto() throws {
        let jsonData = """
        {
            "id": 19202906,
            "width": 4851,
            "height": 4160,
            "url": "https://www.pexels.com/photo/a-close-up-of-a-green-leafy-vegetable-19202906/",
            "photographer": "Ellie Burgin",
            "photographer_url": "https://www.pexels.com/@ellie-burgin-1661546",
            "photographer_id": 1661546,
            "avg_color": "#525E1C",
            "src": {
                "original": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg",
                "large2x": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                "large": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                "medium": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=350",
                "small": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=130",
                "portrait": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                "landscape": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                "tiny": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
            },
            "liked": false,
            "alt": ""
        }
 """
        
        let photo = try JSONDecoder().decode(PexelPhoto.self, from: Data(jsonData.utf8))
        
        print(photo.src)
    }
    
    func testParseJsonToPhotoArray() throws {
        
        let jsonData = """
             [
                    {
                        "id": 19202906,
                        "width": 4851,
                        "height": 4160,
                        "url": "https://www.pexels.com/photo/a-close-up-of-a-green-leafy-vegetable-19202906/",
                        "photographer": "Ellie Burgin",
                        "photographer_url": "https://www.pexels.com/@ellie-burgin-1661546",
                        "photographer_id": 1661546,
                        "avg_color": "#525E1C",
                        "src": {
                            "original": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg",
                            "large2x": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19201768,
                        "width": 5464,
                        "height": 8192,
                        "url": "https://www.pexels.com/photo/photo-of-james-a-st-bernard-dog-in-charlotte-nc-usa-19201768/",
                        "photographer": "Kelly",
                        "photographer_url": "https://www.pexels.com/@kelly-1179532",
                        "photographer_id": 1179532,
                        "avg_color": "#938B80",
                        "src": {
                            "original": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg",
                            "large2x": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19125311,
                        "width": 4000,
                        "height": 6000,
                        "url": "https://www.pexels.com/photo/elderly-man-on-a-plantation-field-in-black-and-white-19125311/",
                        "photographer": "Swapnil Sharma",
                        "photographer_url": "https://www.pexels.com/@hellochemo",
                        "photographer_id": 229324,
                        "avg_color": "#C0C0C0",
                        "src": {
                            "original": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg",
                            "large2x": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19094136,
                        "width": 2250,
                        "height": 3226,
                        "url": "https://www.pexels.com/photo/a-man-feeding-pigeons-19094136/",
                        "photographer": "Kamran shah Films",
                        "photographer_url": "https://www.pexels.com/@kamran-shah-films-793661",
                        "photographer_id": 793661,
                        "avg_color": "#BCBEBB",
                        "src": {
                            "original": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg",
                            "large2x": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
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
                    },
                    {
                        "id": 19198620,
                        "width": 2505,
                        "height": 4453,
                        "url": "https://www.pexels.com/photo/studio-shooting-model-19198620/",
                        "photographer": "Tural Huseyn",
                        "photographer_url": "https://www.pexels.com/@tural-huseyn-799948724",
                        "photographer_id": 799948724,
                        "avg_color": "#E4E3E7",
                        "src": {
                            "original": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png",
                            "large2x": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": "Studio Shooting Model"
                    },
                    {
                        "id": 19189624,
                        "width": 3024,
                        "height": 4032,
                        "url": "https://www.pexels.com/photo/a-hand-holding-a-flower-ring-in-front-of-some-bushes-19189624/",
                        "photographer": "Zeynep Gül Ceylan",
                        "photographer_url": "https://www.pexels.com/@zeynep-gul-ceylan-753067026",
                        "photographer_id": 753067026,
                        "avg_color": "#242623",
                        "src": {
                            "original": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg",
                            "large2x": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": "A hand holding a flower ring in front of some bushes"
                    },
                    {
                        "id": 19194603,
                        "width": 4672,
                        "height": 7008,
                        "url": "https://www.pexels.com/photo/a-person-holding-a-book-in-their-hands-with-a-flower-on-it-19194603/",
                        "photographer": "12th.5 blog",
                        "photographer_url": "https://www.pexels.com/@12th-5-blog-803104198",
                        "photographer_id": 803104198,
                        "avg_color": "#858A76",
                        "src": {
                            "original": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg",
                            "large2x": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19185994,
                        "width": 3024,
                        "height": 4032,
                        "url": "https://www.pexels.com/photo/horses-in-the-desert-19185994/",
                        "photographer": "Mehmet Turgut  Kirkgoz",
                        "photographer_url": "https://www.pexels.com/@tkirkgoz",
                        "photographer_id": 2891577,
                        "avg_color": "#A7A39A",
                        "src": {
                            "original": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg",
                            "large2x": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19180584,
                        "width": 4069,
                        "height": 6103,
                        "url": "https://www.pexels.com/photo/lost-in-the-melody-hooded-handpan-player-creating-magical-music-19180584/",
                        "photographer": "Salvatore Tonnara",
                        "photographer_url": "https://www.pexels.com/@salvatore-tonnara-804691688",
                        "photographer_id": 804691688,
                        "avg_color": "#495354",
                        "src": {
                            "original": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg",
                            "large2x": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": "Lost in the Melody: Hooded Handpan Player Creating Magical Music"
                    }
                ]
        """
        
        let photos = try JSONDecoder().decode([PexelPhoto].self, from: Data(jsonData.utf8))
        
        print(photos.count)
        
        if photos.count != 10 {
            XCTFail("size invalid")
        }
       
        
    }
    
    func testParseJsonResponse() throws {
        let jsonData = """
            {
                "page": 1,
                "per_page": 10,
                "photos": [
                    {
                        "id": 19202906,
                        "width": 4851,
                        "height": 4160,
                        "url": "https://www.pexels.com/photo/a-close-up-of-a-green-leafy-vegetable-19202906/",
                        "photographer": "Ellie Burgin",
                        "photographer_url": "https://www.pexels.com/@ellie-burgin-1661546",
                        "photographer_id": 1661546,
                        "avg_color": "#525E1C",
                        "src": {
                            "original": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg",
                            "large2x": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19202906/pexels-photo-19202906.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19201768,
                        "width": 5464,
                        "height": 8192,
                        "url": "https://www.pexels.com/photo/photo-of-james-a-st-bernard-dog-in-charlotte-nc-usa-19201768/",
                        "photographer": "Kelly",
                        "photographer_url": "https://www.pexels.com/@kelly-1179532",
                        "photographer_id": 1179532,
                        "avg_color": "#938B80",
                        "src": {
                            "original": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg",
                            "large2x": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19201768/pexels-photo-19201768.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19125311,
                        "width": 4000,
                        "height": 6000,
                        "url": "https://www.pexels.com/photo/elderly-man-on-a-plantation-field-in-black-and-white-19125311/",
                        "photographer": "Swapnil Sharma",
                        "photographer_url": "https://www.pexels.com/@hellochemo",
                        "photographer_id": 229324,
                        "avg_color": "#C0C0C0",
                        "src": {
                            "original": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg",
                            "large2x": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19125311/pexels-photo-19125311.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19094136,
                        "width": 2250,
                        "height": 3226,
                        "url": "https://www.pexels.com/photo/a-man-feeding-pigeons-19094136/",
                        "photographer": "Kamran shah Films",
                        "photographer_url": "https://www.pexels.com/@kamran-shah-films-793661",
                        "photographer_id": 793661,
                        "avg_color": "#BCBEBB",
                        "src": {
                            "original": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg",
                            "large2x": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19094136/pexels-photo-19094136.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
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
                    },
                    {
                        "id": 19198620,
                        "width": 2505,
                        "height": 4453,
                        "url": "https://www.pexels.com/photo/studio-shooting-model-19198620/",
                        "photographer": "Tural Huseyn",
                        "photographer_url": "https://www.pexels.com/@tural-huseyn-799948724",
                        "photographer_id": 799948724,
                        "avg_color": "#E4E3E7",
                        "src": {
                            "original": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png",
                            "large2x": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19198620/pexels-photo-19198620.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": "Studio Shooting Model"
                    },
                    {
                        "id": 19189624,
                        "width": 3024,
                        "height": 4032,
                        "url": "https://www.pexels.com/photo/a-hand-holding-a-flower-ring-in-front-of-some-bushes-19189624/",
                        "photographer": "Zeynep Gül Ceylan",
                        "photographer_url": "https://www.pexels.com/@zeynep-gul-ceylan-753067026",
                        "photographer_id": 753067026,
                        "avg_color": "#242623",
                        "src": {
                            "original": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg",
                            "large2x": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19189624/pexels-photo-19189624.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": "A hand holding a flower ring in front of some bushes"
                    },
                    {
                        "id": 19194603,
                        "width": 4672,
                        "height": 7008,
                        "url": "https://www.pexels.com/photo/a-person-holding-a-book-in-their-hands-with-a-flower-on-it-19194603/",
                        "photographer": "12th.5 blog",
                        "photographer_url": "https://www.pexels.com/@12th-5-blog-803104198",
                        "photographer_id": 803104198,
                        "avg_color": "#858A76",
                        "src": {
                            "original": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg",
                            "large2x": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19194603/pexels-photo-19194603.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19185994,
                        "width": 3024,
                        "height": 4032,
                        "url": "https://www.pexels.com/photo/horses-in-the-desert-19185994/",
                        "photographer": "Mehmet Turgut  Kirkgoz",
                        "photographer_url": "https://www.pexels.com/@tkirkgoz",
                        "photographer_id": 2891577,
                        "avg_color": "#A7A39A",
                        "src": {
                            "original": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg",
                            "large2x": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19185994/pexels-photo-19185994.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": ""
                    },
                    {
                        "id": 19180584,
                        "width": 4069,
                        "height": 6103,
                        "url": "https://www.pexels.com/photo/lost-in-the-melody-hooded-handpan-player-creating-magical-music-19180584/",
                        "photographer": "Salvatore Tonnara",
                        "photographer_url": "https://www.pexels.com/@salvatore-tonnara-804691688",
                        "photographer_id": 804691688,
                        "avg_color": "#495354",
                        "src": {
                            "original": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg",
                            "large2x": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                            "large": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                            "medium": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&h=350",
                            "small": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&h=130",
                            "portrait": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                            "landscape": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                            "tiny": "https://images.pexels.com/photos/19180584/pexels-photo-19180584.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
                        },
                        "liked": false,
                        "alt": "Lost in the Melody: Hooded Handpan Player Creating Magical Music"
                    }
                ],
                "total_results": 8000,
                "next_page": "https://api.pexels.com/v1/curated/?page=2&per_page=10"
            }
        """
        
        let response = try JSONDecoder().decode(PexelResponse.self, from: Data(jsonData.utf8))
        print(response.prevPage)
        print(response.nextPage)
    }
    
    
}

 

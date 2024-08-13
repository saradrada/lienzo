//
//  ExportResponse.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 13.08.24.
//

import Foundation

struct ExportResponse: Codable {
    let designID: String
    let format: String
    let urls: [String]

    enum CodingKeys: String, CodingKey {
        case designID = "design_id"
        case format
        case urls
    }
}

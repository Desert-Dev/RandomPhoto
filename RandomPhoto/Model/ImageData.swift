//
//  ImageData.swift
//  RandomPhoto
//
//  Created by Santiago Gomez del campo on 17/07/21.
//

import Foundation

struct ImageData : Decodable {
    let alt_description : String // Image Title
    let urls : ImageURLS
}

struct ImageURLS : Decodable {
    let regular : String
}

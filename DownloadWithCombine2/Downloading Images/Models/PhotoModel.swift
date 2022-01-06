//
//  PhotoModel.swift
//  DownloadWithCombine2
//
//  Created by Frank Bara on 1/3/22.
//

import Foundation

// MARK: - Photo
struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

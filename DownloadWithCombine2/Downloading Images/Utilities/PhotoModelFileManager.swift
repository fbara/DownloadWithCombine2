//
//  PhotoModelFileManager.swift
//  DownloadWithCombine2
//
//  Created by Frank Bara on 1/6/22.
//

import Foundation
import SwiftUI

// used to save to the device.  use for only smaller amounts of data.
// if the user needs to get a lot of data, use cache instead.

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "dowhloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Created folder")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        // ... / downloaded_photos/
        // ... / downloaded_photos/image_name.png
        guard let folder = getFolderPath() else {
            return nil
        }
        
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to file manager: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path) else {
                  return nil
              }
        
        return UIImage(contentsOfFile: url.path)
    }
}

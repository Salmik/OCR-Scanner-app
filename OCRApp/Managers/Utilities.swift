//
//  Utilities.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 28.04.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

final class Utilities {
    
    class func getTime() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    class func getDocuments() -> [URL] {
        var contents = [URL]()
        do {
            let docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            contents = try (FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles))
        } catch {
            print("Fetch pdfs error \(error.localizedDescription)")
        }
        return contents
    }
    
    class func checkSameName(fileName: String, documents: [URL]) -> Bool {
        for fileURL in documents {
            var title = fileURL.path.components(separatedBy: "Documents/")[1]
            title = String(Array(title)[0..<(title.count-4)])
            if fileName == title {
                return true
            }
        }
        return false
    }
}

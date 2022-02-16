//
//  FileService.swift
//  image-search
//
//  Created by Nate Hart on 2/15/22.
//

import Foundation

class FileService {

    func writeJSON(data: [String], toFile fileName: String) {
        do {
            let data = try JSONEncoder().encode(data)
            let fileURL = getFileURL(forFile: fileName, withExtension: "json")
            try data.write(to: fileURL)
            /*
             Ideally, for a real production app, we would inject a logging service into
             this class via dependency injection, and the logging service would handle
             this logging. Since this is not a real production app, and I only have a week
             to build it, I am just going to print the error instead. #YOLO ¯\_(ツ)_/¯
             */
            print("File saved: \(fileURL.absoluteURL)")
        } catch {
            // see above re: error logging
            print("Unable to save data")
        }
    }

    func readJSON(fromFile fileName: String) -> [String]? {
        do {
            let fileURL = getFileURL(forFile: fileName, withExtension: "json")
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let savedData = try Data(contentsOf: fileURL)
                let data = try JSONDecoder().decode([String].self, from: savedData)
                return data
            } else {
                return nil
            }
        } catch(let error) {
            // see above re: error logging
            print("Unable to read the file", error)
            return nil
        }
    }

    private let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    private func getFileURL(forFile fileName: String, withExtension fileExtension: String) -> URL {
        URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension(fileExtension)
    }

}

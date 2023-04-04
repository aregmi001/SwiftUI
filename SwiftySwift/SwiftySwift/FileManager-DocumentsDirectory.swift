//
//  FileManager-DocumentsDirectory.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-03.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


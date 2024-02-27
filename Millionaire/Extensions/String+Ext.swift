//
//  String+Ext.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 26.02.2024.
//

import Foundation


extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}

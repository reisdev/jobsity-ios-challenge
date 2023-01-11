//
//  StringExtension.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation

extension String {
    
    func toHtmlAttributedText() -> NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let documentType = NSAttributedString.DocumentType.html
            let characterEncoding = String.Encoding.utf8.rawValue
            return try NSMutableAttributedString(data: data, options: [.documentType: documentType, .characterEncoding: characterEncoding], documentAttributes: nil)
        } catch {
            return nil
        }
    }
}

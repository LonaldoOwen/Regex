import Foundation
import UIKit


/// Regular Expression--helper method

// 匹配字符串并高亮显示
public func highlightMatches(pattern: String, inString string: String) -> NSAttributedString {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    let matches = regex.matches(in: string, options: [], range: range)
    
    let attributedText = NSMutableAttributedString(string: string)
    
    for match in matches {
        attributedText.addAttributes([NSBackgroundColorAttributeName:UIColor.yellow], range: match.range)
    }
    
    return attributedText.copy() as! NSAttributedString
}

// 匹配字符串
public func listMatches(pattern: String, inString string: String) -> [String] {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    let matches = regex.matches(in: string, options: [], range: range)
    
    return matches.map {
        let range = $0.range
        let matchString = (string as NSString).substring(with: range)
        //print("matchString: \(matchString)")
        return matchString
    }
}

// ？？？
public func listGroups(pattern: String, inString string: String) -> [String] {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    let matches = regex.matches(in: string, options: [], range: range)
    
    var groupMatches = [String]()
    for match in matches {
        let rangeCount = match.numberOfRanges
        for group in 0..<rangeCount {
            groupMatches.append((string as NSString).substring(with: match.rangeAt(group)))
        }
    }
    
    return groupMatches
}

//
public func containsMatch(pattern: String, inString string: String) -> Bool {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    let matchString = regex?.firstMatch(in: string, options: [], range: range)
    return matchString != nil
}

// 匹配后替换字符串
public func replaceMatches(pattern: String, inString string: String, withString replacementString: String) -> String? {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    
    return regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: replacementString)
}




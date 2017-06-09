//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/// Regular Expression

// 
func highlightMatchs(pattern: String, inString string: String) -> NSAttributedString {
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
func listMatches(pattern: String, inString string: String) -> [String] {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    let matches = regex.matches(in: string, options: [], range: range)
    
    return matches.map {
        let range = $0.range
        return (string as NSString).substring(with: range)
    }
}


// Basic Examples
let quickFox = "The quick brown fox jumps over the lazy dog."

// 匹配单词“jump”
listMatches(pattern: "jump", inString: quickFox)

//
/**
 特殊符号？--匹配它前面的字符组（（s））0或1次，可以匹配‘jump’或‘jumps’
 */
listMatches(pattern: "jump(s)?", inString: quickFox)

// This one matches an HTML or XML tag:
let htmlString = "<p>This is an example <strong>html</strong> string.</p>"
listMatches(pattern: "<([a-z][a-z0-9]*)\\b[^>]*>(.*?)", inString: htmlString)


// Cheat Sheet
/**
 . matches any character. p.p matches pop, pup, pmp, p@p, and so on.
 ".":可以匹配任何字符。
 */
let anyExample = "pip, pop, p%p, paap, piip, puup, pippin"
listMatches(pattern: "p.p", inString: anyExample)

/**
 \w matches any 'word-like' character which includes the set of numbers, letters, and underscore, but does not match punctuation or other symbols. hello\w will match "hello_9" and "helloo" but not "hello!"
 "\w":匹配任何字母类型的字符，包括：数字、字母、下划线，不包括：标点符号或其他符号；
 */
let wordExample = "hello helloooooo hello_1114 hello, hello!"
listMatches(pattern: "hello\\w+", inString: wordExample)

/**
 \d matches a numeric digit, which in most cases means [0-9]. \d\d?:\d\d will match strings in time format, such as "9:30" and "12:45".
 */
let digitExample = "9:30 12:45 df:24 ag:gh"
listMatches(pattern: "\\d?\\d:\\d\\d", inString: digitExample)

/**
 
 */


/**
 
 */






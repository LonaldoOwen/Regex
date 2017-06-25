//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/// Regular Expression

// 匹配字符串并高亮显示
func highlightMatches(pattern: String, inString string: String) -> NSAttributedString {
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
        let matchString = (string as NSString).substring(with: range)
        //print("matchString: \(matchString)")
        return matchString
    }
}

// ？？？
func listGroups(pattern: String, inString string: String) -> [String] {
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
func containsMatch(pattern: String, inString string: String) -> Bool {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    let matchString = regex?.firstMatch(in: string, options: [], range: range)
    return matchString != nil
}

// 匹配后替换字符串
func replaceMatches(pattern: String, inString string: String, withString replacementString: String) -> String? {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let range = NSMakeRange(0, string.characters.count)
    
    return regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: replacementString)
}

    
// MARK: Basic Examples
// 匹配单词“jump”
/**
 This first example is about as simple as regular expressions get! It matches the word "jump" in the sample text:
 这是一个来匹配单词“jump”的正则表达式的例子:
 */
let quickFox = "The quick brown fox jumps over the lazy dog."
listMatches(pattern: "jump", inString: quickFox)
/**
 This next example uses some special characters that are available in regular expressions. The parenthesis create a group, and the question mark says "match the previous element (the group in this case) 0 or 1 times". It matches either 'jump' or 'jumps':
 这是一个略微复杂点的例子—它会匹配单词“jump”或“jumping”:
 特殊符号？--匹配它前面的字符组（（s））0或1次，可以匹配‘jump’或‘jumps’
 */
listMatches(pattern: "jump(s)?", inString: quickFox)
let chineseString = "美国,日本,澳大利亚,中国,俄罗斯,中国龙,阿萨德中国"
let chinesePattern = "(\\w)*中国(\\w)*"
listMatches(pattern: chinesePattern, inString: chineseString)

// This one matches an HTML or XML tag:
/**
 This one matches an HTML or XML tag:
 */
// 不带换行的html标签
//let htmlString = "<p>This is an example <strong>html</strong> string.</p>"
//let htmlString = "<table class=\"wikitable\">        <tr>abc</tr>This is an example <strong>html</strong> string.</table>;<strong>html</strong>"
// 带换行的html 标签
let htmlString = "<tr>\n<th>英文术语</th><th>中文翻译</th><th>详细解释\n</th></tr>"
let pattern = "<([a-z][a-z0-9]*)\\b[^>]*>(.*?)</\\1>"  // 匹配任意html tag
//let pattern = "<(table)*\\b[^>]*>\\s(.*?)</\\1>"
//let pattern = "<(table)[^>]*>(.*?)</\\1>"
//let pattern = "<(table)\\b class=\"wikitable\">"
/* 注意html标签是有换行的（\n），正则匹配时要注意 */
//let trPattern = "<(tr)>([\\s\\S]*?)</\\1>"
//let trPattern = ">(.+?)<"
listMatches(pattern: pattern, inString: htmlString)




//, MARK: Cheat Sheet
/**
 \w matches any 'word-like' character which includes the set of numbers, letters, and underscore, but does not match punctuation or other symbols. hello\w will match "hello_9" and "helloo" but not "hello!"
 "\w":匹配任何字母类型的字符，包括：数字、字母、下划线，不包括：标点符号或其他符号；
 */
let wordExample = "hello helloooooo hello_1114 hello, hello!"
listMatches(pattern: "hello\\w+", inString: wordExample)

/**
 \d matches a numeric digit, which in most cases means [0-9]. \d\d?:\d\d will match strings in time format, such as "9:30" and "12:45".
 \d 匹配数字，大部分情况下是[0-9]。\d\d?:\d\d会匹配时间格式的字符串，比如”9：30“和”12：45“。
 */
let digitExample = "9:30 12:45 df:24 ag:gh"
listMatches(pattern: "\\d?\\d:\\d\\d", inString: digitExample)

/**
 \b matches word boundary characters such as spaces and punctuation. to\b will match the "to" in "to the moon" and "to!", but it will not match "tomorrow". \b is handy for "whole word" type matching.
 \b 匹配额外的字符，例如空格，标点符号。to\b 会匹配”to the moon”和“to!”中得“to”,但是不会匹配“tomorrow”。\b 用在整个单词的匹配方面和方便。
 */
let boundaryExample = "to the moon! when to go? tomorrow? to!"
listMatches(pattern: "to\\b", inString: boundaryExample)

listMatches(pattern: "to the\\b", inString: boundaryExample)

/**
 \s matches whitespace characters such as spaces, tabs, and newlines. hello\s will match "hello " in "Well, hello there!".
 \s 会匹配空白字符，比如，空格，制表符(tab)，换行符。hello\s 会匹配“Well,hello there!”中的 “hello ”。
 */
let whitespaceExample = "Well, helloWorld, hello-World, hello there!, hello!, hello。。。<>《》, hello\n, hello<>, hello "
listMatches(pattern: "hello\\s", inString: whitespaceExample)
let SPattern = "hello\\S*"
listMatches(pattern: SPattern, inString: whitespaceExample)
let sSPattern = "hello\\s\\S"
listMatches(pattern: sSPattern, inString: whitespaceExample)
let sSStarPattern = "[\\s\\S]*"
listMatches(pattern: sSStarPattern, inString: whitespaceExample)

/**
 ^ matches at the beginning of a line. Note that this particular ^ is different from ^ inside of the square brackets! For example, ^Hello will match against the string "Hello there", but not "He said Hello".
 ^用在一行的开始。记住，这个特殊的^不同于方括号中的^（[^]）!例如，^Hello 会匹配字符串“Hello there”，而不会去匹配“He said Hello”。
 [^] 表示不包含的字符，如：[^He]表示不包含“H”或“E”
 */
let beginningExample = "Hello there! He said hello. (Hello)"
highlightMatches(pattern: "^Hello", inString: beginningExample)

highlightMatches(pattern: "[^He]", inString: beginningExample)

highlightMatches(pattern: "[^Hello]", inString: beginningExample)

highlightMatches(pattern: "[^(Hello)]", inString: beginningExample)

highlightMatches(pattern: "^(Hello)", inString: beginningExample)

/**
 $ matches at the end of a line. For example, the end$ will match against "It was the end" but not "the end was near"
 $ 用在一行的结束，例如，the end$ 会匹配“It was the end” 而不会去匹配 “the end was near”。
 */
let endExample = "The end was near. It was the end"
highlightMatches(pattern: "end$", inString: endExample)

/**
 . matches any character. p.p matches pop, pup, pmp, p@p, and so on.
 ".":可以匹配任何字符。不能匹配换行符\n
 */
let anyExample = "pp, pip, pop, p%p, paap, piip, puup, pippin, p匹皮批p, p p, p\np, p_p, p\\p"
listMatches(pattern: "p.p", inString: anyExample)


/**
 * matches the previous element 0 or more times. 12*3 will match 13, 123, 1223, 122223, and 1222222223.
 * 匹配 它之前的元素0次或多次。12*3  会匹配 13, 123, 1223, 122223, 和 1222222223。
 */
let zeroOrMoreExample = "13, 123, 1223, 122223, 1222222223, 143222343"
highlightMatches(pattern: "12*3", inString: zeroOrMoreExample)

/**
 + matches the previous element 1 or more times. 12+3 will match 123, 1223, 122223, 1222222223, but not 13.
 + 匹配 它之前的元素1次或多次. 12+3  会匹配  123, 1223, 122223, 和 1222222223。
 */
let oneOrMoreExample = "13, 123, 1223, 122223, 1222222223, 143222343"
highlightMatches(pattern: "12+3", inString: oneOrMoreExample)

/**
 ? matches the previous element 0 or 1 times. 12?3 will match 13 or 123, but not 1223.
 
 */
let possibleExample = "13, 123, 1223"
highlightMatches(pattern: "12?3", inString: oneOrMoreExample)

// (.*?)用法
/**
 
 */
// 不能匹配包含换行符（\n）
listMatches(pattern: "abc(.*?)abc", inString: "abc123egfabc45677abc")
listMatches(pattern: "abc(.*?)abc", inString: "abc\n123egfabc45677abc")
// 可以匹配任何字符，包含换行符（\n）
listMatches(pattern: "abc([\\s\\S]*?)abc", inString: "abc\n123egfabc45677abc")

/**
 Curly braces { } contain the minimum and maximum number of matches. For example, 10{1,2}1 will match both "101" and "1001" but not "10001" as the minimum number of matches is 1 and the maximum number of matches is 2. He[Ll]{2,}o will match "HeLLo" and "HellLLLllo" and any such silly variation of "hello" with lots of L’s, since the minimum number of matches is 2 but the maximum number of matches is not set — and therefore unlimited!
 */
let numberExample1 = "101 1001 10001"
let numberExample2 = "HeLLo HellLLLllo"
highlightMatches(pattern: "10{1,2}1", inString: numberExample1)
highlightMatches(pattern: "He[Ll]{2,}", inString: numberExample2)
highlightMatches(pattern: "10{2,2}1", inString: numberExample1)

/**
 () Capturing parentheses ( ) are used to group part of a pattern. For example, 3 (pm|am) would match the text "3 pm" as well as the text "3 am". The pipe character here (|) acts like an OR operator.
 () 截获圆括号（capturing parentheses） 被用作组模式的一部分。例如：3 (pm|am)会匹配文本“3 pm” ,也会匹配“3 am”。竖线字符（|）执行的是或操作。
 当你需要选择性的匹配特定的字符串时，圆括号组用起来很方便。比方说你要在一个文本中查找“November”，但是它可能被简写为“Nov”.你就能定义一个模式 Nov(ember)?,在捕获圆括号（capturing parentheses）后加上问号，意味着这个圆括号内的内容是可选的。
 */
let cinema = "Are we going to the cinema at 3 am or 5 pm?"
listMatches(pattern: "\\d (am|pm)", inString: cinema)

// 结果为什么是这样？
listGroups(pattern: "(\\d (am|pm))", inString: cinema)

let november = "I go to New York in 15th November or 20th Nov."
listMatches(pattern: "Nov(ember)?", inString: november)


/**
 You can include as many pipe characters in your regular expression as you would like. As an example, (Tom|Dick|Harry) is a valid pattern.
 竖线字符（|）执行的是或操作。只要你乐意，你可以包含多个竖线字符在你的正则表达式中。例如，(Tom|Dick|Harry)是一个有效的模式，它能匹配那三个名字中的任一个。
 */
let greeting = "Hello Tom, Dick, Harry!"
listMatches(pattern: "(Tom|Dick|Harry)", inString: greeting)
replaceMatches(pattern: "(Tom|Dick|Harry)", inString: greeting, withString: "James")

/**
 [] Character classes represent a set of possible single-character matches. Character classes appear between square brackets [ ]. As an example, the regular expression t[aeiou] will match "ta", "te", "ti", "to", or "tu". You can have as many character possibilities inside the square brackets as you like, but remember that any single character in the set will match. [aeiou] looks like five characters, but it actually means "a" or "e" or "i" or "o" or "u".
 [] 字符组（Character classes）相当于一组字符中匹配单个字符。字符组出现在中括号（[ 和 ]）之间。
 
 例如，正则表达式 t[aeiou]会匹配“ta”、“te”、“ti”、“to”或“tu”。你可以放任意多的字符在中括号中，但是请记住，只能匹配一个字符。[aeiou]看起来是五个字符，但它真实意义却是“a”或”e“或”i“或”o“或”u“。
 */
let theVowels = "ta te ti to tu th tj tk tm"
listMatches(pattern: "t[aeiou]", inString: theVowels)

/**
 You can also define a range in a character class if the characters appear consecutively. For example, to search for a number between 100 to 109, the pattern would be 10[0-9]. This returns the same results as 10[0123456789], but using ranges makes your regular expressions much cleaner and easier to understand. Ranges can also be used for characters - for example, [a-z] matches all lowercase characters, or [a-zA-Z] matches all upper and lower case.
 如果字符连续出现，你也能在字符组中定义一个范围。例如，为了搜索在100到109的数字，模式应该用10[0-9]。这和10[0123456789]会返回同样地结果，不过，使用范围来定义你的正则表达式看起来更简洁和易于理解。
 字符组不止局限于数字，你同样可以用字符来这样做。比如，[a-f]会匹配”a“，”b“，”c“，”d“，”e“或”f“。
 */
let theNumbers = "100 101 105 121 229 816"
listMatches(pattern: "10[0-9]", inString: theNumbers)
listMatches(pattern: "t[a-h]", inString: theVowels)

/**
 Character classes usually contain the characters you want to match, but what if you want to explicitly not match a character? You can also define negated character classes, which use the ^ character. For example, the pattern t[^o] will match any combination of "t" and one other character except for the single instance of "to".
 字符集通常包含你想要匹配的字符，但是如果你想明确指出不要匹配的字符该怎么办？同样你能定义除此之外的字符组，把^放在前面。例如，模式t[^o]就会匹配包含”t“并且后面紧跟的字符是非o的字符。
 */
let notClasses = "tim tam tum tom tem"
listMatches(pattern: "t[^oa]m", inString: notClasses)


///
/**
 
 */
// 不带换行的html标签
//let tableString = "<p>This is an example <strong>html</strong> string.</p>"
let tableString = "<table class=\"wikitable\">        <tr>abc<table>123</table></tr>This is an example <strong>html</strong> string.</table>;<strong>html</strong>"
// 带换行的html 标签
//let tableString = "<tr>\n<th>英文术语</th><th>中文翻译</th><th>详细解释\n</th></tr>"
let tablePattern = "<(table)*\\b[^>]*>\\s(.*?)</\\1>"
listMatches(pattern: tablePattern, inString: tableString)

/* 注意html标签是有换行的（\n），正则匹配时要注意 */
//let trPattern = "<(tr)>([\\s\\S]*?)</\\1>"
let trPattern = ">(.+?)<"
listMatches(pattern: "<([a-z][a-z0-9]*)\\b[^>]*>(.*?)</\\1>", inString: tableString)
listMatches(pattern: "<(table)*\\b[^>]*>\\s(.*?)</\\1>((.*?)</table>)*", inString: tableString)

listMatches(pattern: "<(table)[^>]*>(.*?)</\\1>", inString: tableString)
listMatches(pattern: "<(table)\\b class=\"wikitable\">", inString: tableString)
// 匹配两个字符串str1、str2间的所有字符，只匹配str2第一次出现时的内容
listMatches(pattern: "abc(.*?)efg", inString: "abc1245efg44445efgb")
// 匹配两个字符串str1、str2间的所有字符，匹配str2最后一次出现时的所有内容
listMatches(pattern: "abc(.*?)efg((.*?)efg)*", inString: "abc1245efg4efg4abc4efg45efgb")
listMatches(pattern: "<tr>(.*?)</tr>", inString: "<tr>abc,<tr>123</tr>dsfs</tr>")


// 处理第二个td
let tdChineseString = "<td><a href=\"/wiki/%E5%AD%98%E6%AC%BE%E8%AF%81\" title=\"存款证\">存款证</a></td>"

let tdChinesePattern = "[\u{4e00}-\u{9fa5}]+" // 匹配中文可行
let tdChineseResult = listMatches(pattern: tdChinesePattern, inString: tdChineseString)

// 处理第三个td
/**
 问题：
 1、CFA 协会]](CFA Institute)]](前身是AIMR(Association for Investment Management and Research)，于2004年五月正式易名)颁发的专业称号，用以证实投资专业人士的实力及诚信。应考生必须通过三级考试，考核的范围包括道德与专业标准、投资工具、资产估值及投资组合管理。（这种匹配不对）
 2、美国注册公开会计师协会（American Institute of Certified Public Accountants) 颁发的专业称号，应考生必须通过一次考试，并符合工作经验要求（这种匹配不对）
 3、//"[^>].*[^<]"无法匹配">及<"???
 解决：正则匹配，在于找到规律，有了规律就有合适的正则
 */
//let tdExplainString = "<td>持有人可收取<a href=\"/wiki/%E5%88%A9%E6%81%AF\" title=\"利息\">利息</a>的存款证书。存款证设有到期日、<a href=\"/wiki/%E5%9B%BA%E5%AE%9A%E5%88%A9%E7%8E%87\" title=\"固定利率\">固定利率</a>，并可以用任何<a href=\"/wiki/%E8%B4%A7%E5%B8%81\" title=\"货币\">货币</a>计价。存款证一般由<a href=\"/wiki/%E5%95%86%E4%B8%9A%E9%93%B6%E8%A1%8C\" title=\"商业银行\">商业银行</a>发行</td>"
let tdExplainString = "<td>实现<a href=\"/wiki/%E5%88%A9%E6%B6%A6\" title=\"利润\">利润</a>运用的资金总额<br>业务运用的所有资产的价值<br><a href=\"/wiki/%E5%9B%BA%E5%AE%9A%E8%B5%84%E4%BA%A7\" title=\"固定资产\">固定资产</a>+周转资金<br><a href=\"/wiki/%E6%80%BB%E8%B5%84%E4%BA%A7\" title=\"总资产\">总资产</a> - <a href=\"/wiki/%E6%B5%81%E5%8A%A8%E8%B4%9F%E5%80%BA\" title=\"流动负债\">流动负债</a>"
//let tdPattern = "<([a-z][a-z0-9]*)\\b[^>]*>([\u{4e00}-\u{9fa5}]+)</\\1>"
//let tdPattern = "<(\\S*?)[^>]*>.*?</>|<.*? />"
//let tdExplainPattern = "[\u{4e00}-\u{9fa5}]+([，。、；]*)[\u{4e00}-\u{9fa5}]+" // 匹配中文+标点符号
let tdExplainPattern = "(?<=>).*?(?=<)|(?<=>).*?(?=\\n)"

listMatches(pattern: "<([a-z][a-z0-9]*)\\b[^>]*>([\u{4e00}-\u{9fa5}]+)</\\1>", inString: tdExplainString)
listMatches(pattern: "<(\\S*?)[^>]*>.*?</>|<.*? />", inString: tdExplainString)
listMatches(pattern: "[\u{4e00}-\u{9fa5}]+([，。、；]*)[\u{4e00}-\u{9fa5}]+", inString: tdExplainString)
listMatches(pattern: tdExplainPattern, inString: tdExplainString)
//var newtdResult: [String] = []
//for string in tdExplainResult {
//    if newtdResult.contains(string) == false {
//        newtdResult.append(string)
//    }
//}
//print("newtdResult: \(newtdResult)")

// 处理第一个td
//let tdEnglishString = "<td><a href=\"/w/index.php?title=CEDEL&amp;action=edit\" class=\"new\" title=\"CEDEL\">CEDEL</a></td>"
//let tdEnglishString = "<td><a href=\"/w/index.php?title=Call_Loan_Rate&amp;action=edit\" class=\"new\" title=\"Call Loan Rate\">Call Loan Rate (Call-Loan Rate)</a></td>"
//let tdEnglishString = "<td><a href=\"/w/index.php?title=%E6%80%BB%E8%B5%84%E6%9C%AC%EF%BC%8C%E6%80%BB%E5%B8%82%E5%80%BC&amp;action=edit\" class=\"new\" title=\"总资本，总市值\">总资本，总市值</a></td>"
//let tdEnglishString = "<td><a href=\"/w/index.php?title=%E9%80%89%E5%87%BA%E6%9C%80%E6%9C%89%E5%88%A9%E7%9A%84%EF%BC%88%E6%8A%95%E8%B5%84%E7%AD%89%EF%BC%89&amp;action=edit\" class=\"new\" title=\"选出最有利的（投资等）\">选出最有利的（投资等）</a></td>"
//let tdEnglishString = "<td>持有人、可收取<a href=\"/wiki/%E5%88%A9%E6%81%AF\" title=\"利息\">利息</a>的存款证书。存款证设有到期日、<a href=\"/wiki/%E5%9B%BA%E5%AE%9A%E5%88%A9%E7%8E%87\" title=\"固定利率\">固定利率</a>，并可以用任何<a href=\"/wiki/%E8%B4%A7%E5%B8%81\" title=\"货币\">货币</a>计价。存款证一般由<a href=\"/wiki/%E5%95%86%E4%B8%9A%E9%93%B6%E8%A1%8C\" title=\"商业银行\">商业银行</a>发行</td>"
//let tdEnglishString = "<td>CFA 协会]](CFA Institute)]](前身是AIMR(Association for Investment Management and Research)，于2004年五月正式易名)颁发的专业称号，用以证实<a href=\"/wiki/%E6%8A%95%E8%B5%84\" title=\"投资\">投资</a>专业人士的实力及<a href=\"/wiki/%E8%AF%9A%E4%BF%A1\" title=\"诚信\">诚信</a>。应考生必须通过三级考试，考核的范围包括道德与专业标准、投资工具、<a href=\"/wiki/%E8%B5%84%E4%BA%A7\" title=\"资产\">资产</a>估值及<a href=\"/wiki/%E6%8A%95%E8%B5%84%E7%BB%84%E5%90%88%E7%AE%A1%E7%90%86\" title=\"投资组合管理\">投资组合</a>管理。\n</td>"
let tdEnglishString = "<tr>\n<td><a href=\"/w/index.php?title=Barrel%27s_per_Day&amp;action=edit\" class=\"new\" title=\"Barrel's per Day\">Barrel's per Day</a></td><td><a href=\"/w/index.php?title=%E6%AF%8F%E6%97%A5%E4%BA%A7%E9%87%8F&amp;action=edit\" class=\"new\" title=\"每日产量\">每日产量</a>（桶）</td><td>评估石油产量的常用统计单位\n</td></tr>"
//let tdEnglishString = "<tr>\n<td><a href=\"/w/index.php?title=Barrel%27s_per_Day&amp;action=edit\" class=\"new\" title=\"Barrel's per Day\">Barrel's per Day</a></td>"
//let tdEnglishPattern = ">(\\w+)(\\s+)?(\\w+)<" //只能匹配两个单词
//let tdEnglishPattern = ">[([(\\w+（）)、，-])(\\s+)]+<"  //匹配多个单词，包含连接符（-）
//let tdEnglishPattern = ">(.*?)<" // 匹配'><'之间的所有字符(不含换行\n,)(包含><)
let tdEnglishPattern = "(?<=>)(.*?)(?=<)" // 匹配'><'之间的所有字符(不含换行\n,)(不包含><,)
//let tdEnglishPattern = "(?<=>).*?(?=<)|(?<=>).*?(?=\\n)" //匹配'><'或'>\n'之间的所有字符(不包含><,>\n)
let tdEnglishResult = listMatches(pattern: tdEnglishPattern, inString: tdEnglishString)
highlightMatches(pattern: tdEnglishPattern, inString: tdEnglishString)
listMatches(pattern: ">(\\w+)(\\s+)?(\\w+)<", inString: tdEnglishString)
listMatches(pattern: ">[([(\\w+（）)、，-])(\\s+)]+<", inString:tdEnglishString)
listMatches(pattern: ">(.*?)<", inString: tdEnglishString)
listMatches(pattern: "(?<=>).*?(?=<)|(?<=>).*?(?=\\n)", inString: tdEnglishString)

//let wordPattern = "[^>].*[^<]"
//let wordResult = listMatches(pattern: wordPattern, inString: tdEnglishResult[0])

listMatches(pattern: "<td>([\\s\\S]*?)(<table>[\\s\\S].*?</table>)</td>", inString: "<td>12345\n<table>abc<td>xyz</td></table></td>")
listMatches(pattern: "<td>([\\s\\S]*?)(<table>[\\s\\S].*?</table>)*</td>", inString: "<td>\n1234, <td>12345\n<table>abc<td>xyz</td></table></td>9876</td>")
listMatches(pattern: "<td>([\\s\\S]*)</td>", inString: "<td>\n1234, <td>12345\n<table>abc<td>xyz</td></table></td>9876</td>") // ()* 非懒惰模式，
listMatches(pattern: "<td>([\\s\\S]*?)</td>", inString: "<td>\n1234, <td>12345\n<table>abc<td>xyz</td></table></td>9876</td>") // ()*? 懒惰模式，匹配尽量少的次数
listMatches(pattern: "<tr>\n(<td>([\\s\\S]*?)(<table>[\\s\\S].*?</table>)</td>)</tr>", inString: "<tr>\n<td>td1</td><td>td2</td><td>td3\n<table>abc<td>xyz</td></table></td></tr>")
listMatches(pattern: "<tr>((<td>([\\s\\S]*?)</td>){3,3})</tr>", inString: "<tr><td>td1</td><td>td2</td><td>td3</td></tr>")
listMatches(pattern: "<tr>\n(<td>[([\\s\\S]*?)(<table>[\\s\\S].*?</table>)</td>])</tr>", inString: "<tr>\n<td>td1</td><td>td2</td><td>td3</td></tr>")

// 嵌套HTML标签匹配
// "<(?<HtmlTag>[\\w]+)[^>]*\\s[^>]*>((?<Nested><\\k<HtmlTag>[^>]*>)|</\\k<HtmlTag>>(?<-Nested>)|.*?)*</\\k<HtmlTag>>"
// "<(?<HtmlTag>td)>(.*?)</\\1<HtmlTag>>"

// Backreferences \1
listMatches(pattern: "<(td)>(.*?)</\\1>", inString: "<td>1234, </td>")
// Named Groups and Backreferences
listMatches(pattern: "<(?<HtmlTag>td)>(.*?)</\\k<HtmlTag>>", inString: "<td>1234, </td>")
//listMatches(pattern: "<(?'HtmlTag'td)>(.*?)</\\k'HtmlTag'>", inString: "<td>1234, </td>")
//listMatches(pattern: "<(?<HtmlTag>tr)>((?<Nested><\\k<HtmlTag>)|</\\k<HtmlTag>>(?<-Nested>)|.*?)*</\\k<HtmlTag>>", inString: "<tr><td>1234,<tr>999</tr> </td></tr>")
//listMatches(pattern: "<(?<HtmlTag>tr)>(?<Nested><\\k<HtmlTag>)</\\k<HtmlTag>>(?-<Nested>)</\\k<HtmlTag>>", inString: "<tr><td><tr></tr></td></tr>")
//listMatches(pattern: "<(?<HtmlTag>[\\w]+)[^>]*\\s[^>]*>((?<Nested><\\k<HtmlTag>[^>]*>)|</\\k<HtmlTag>>(?<N-Nested>)|.*?)*</\\k<HtmlTag>>", inString: "<tr><td><tr></tr></td></tr>")







// () capturing group 捕获 组
/**
 普通捕获组的情况下，捕获组的编号是按照“(”出现的顺序，从左到右，从1开始进行编号的,0表示的是整个 
 (\d{4})-(\d{2}-(\d\d))
 那么分组的编号是
 0 (\d{4})-(\d{2}-(\d\d))
 1 (\d{4})
 2 (\d{2}-(\d\d))
 3 (\d\d)
 */
listMatches(pattern: "<((tr)|(td))>(.*?)</\\3>", inString: "<tr>abc<td>1234, </td></tr>")

//listMatches(pattern: "<((tr)|(td))>(.*?)</$3>", inString: "<tr>abc<td>1234, </td></tr>")
listMatches(pattern: "^(\\w+\\s+ID:\\s+)(\\d{3})-(\\d{4})$", inString: "Bob ID: 143-5546")
replaceMatches(pattern: "^(\\w+\\s+ID:\\s+)(\\d{3})-(\\d{4})$", inString: "Bob ID: 143-5546", withString: "$1$3 -- $2-----$2") // $ 引用捕获的内容
replaceMatches(pattern: "(<tr>)(<td>)(<p>)", inString: "<tr><td><p>", withString: "$3$2$1")

listMatches(pattern: "(abc)", inString: "abc123abc456")

listMatches(pattern: "(?:abc)", inString: "abc123abc456")

//
listMatches(pattern: "Set(Value)?", inString: "Set, SetValue, set")
replaceMatches(pattern: "Set(Value)?", inString: "Set, SetValue, set", withString: "$1")
listMatches(pattern: "Set(?:Value)?", inString: "Set, SetValue, set")
replaceMatches(pattern: "Set(?:Value)?", inString: "Set, SetValue, set", withString: "$1")

listMatches(pattern: "(?i:TEST)", inString: "test")
listMatches(pattern: "(?-i:TEST)", inString: "test")

// http://blog.csdn.net/wanglei19880622/article/details/7204492
// https://www.crifan.com/files/doc/docbook/regular_expression/release/html/regular_expression.html#how_cal_group_index_for_embedded_parentheses
listMatches(pattern: "a((?<o>a)|(?<-o>b)|[^ab]+)+b", inString: "xxxxaxxaxxaxxbxxbxxbxxxx")





// ???
/**
 ?<= 
 ?=
 */
//let tdString = "<td><a href=\"/w/index.php?title=%E9%80%89%E5%87%BA%E6%9C%80%E6%9C%89%E5%88%A9%E7%9A%84%EF%BC%88%E6%8A%95%E8%B5%84%E7%AD%89%EF%BC%89&amp;action=edit\" class=\"new\" title=\"选出最有利的（投资等）\">选出最有利的（投资等）</a></td>"

let tdString = ">及<"
//let tdPattern = "[^>][([(\\w+（）)，-])(\\s+)]+[^<]"
//let tdPattern = "[^>].*[^<]" //"[^>].*[^<]"无法匹配">及<"???
let tdPattern = "(?<=>).*(?=<)" //
var tdResult = listMatches(pattern: tdPattern, inString: tdString)

listMatches(pattern: "[^>][([(\\w+（）)，-])(\\s+)]+[^<]", inString: tdString)
listMatches(pattern: "[^>].*[^<]", inString: tdString)

listMatches(pattern: "(?=>).{1,2}", inString: ">abcd<")

listMatches(pattern: "(?!>).{1,2}", inString: ">abcd<")


/// 数组去重
// 无序去重
var tempArray: [String] = ["a", "b", "b", "c", "d", "d"]
var tempDic: [String: String] = [:]
var result1: [String] = []
//

for string in tempArray {
    tempDic[string] = string
}
print("tempDic: \(tempDic)")
result1 = [String](tempDic.keys)
// 有序去重
var result2: [String] = []
for string in tempArray {
    if result2.contains(string) == false {
        result2.append(string)
    }
}
print("result2: \(result2)")


/// Optional type
var someString: String
someString = "abc"
print(someString)

var someOptionalString: String?
someOptionalString = "abc"
print(someOptionalString)
if someOptionalString == nil {
    print("nil")
} else {
    print(someOptionalString!)
}

/**
 
 */


/**
 
 */


/**
 
 */


/**
 
 */









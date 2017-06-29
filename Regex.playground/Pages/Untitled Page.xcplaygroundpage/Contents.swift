//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/// Regular Expression





/// 处理抓取HTML tag
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
//listMatches(pattern: "a((?<o>a)|(?<-o>b)|[^ab]+)+b", inString: "xxxxaxxaxxaxxbxxbxxbxxxx")





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




/**
 
 */


/**
 
 */


/**
 
 */


/**
 
 */









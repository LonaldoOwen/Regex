//: [Previous](@previous)

/*:
 ## Basic Examples
 // 匹配单词“jump”
*/
/*:
 ### #匹配单词“jump”
 This first example is about as simple as regular expressions get! It matches the word "jump" in the sample text:
 
 这是一个来匹配单词“jump”的正则表达式的例子:
 */
let quickFox = "The quick brown fox jumps over the lazy dog."
listMatches(pattern: "jump", inString: quickFox)

/*:
 ### #匹配单词“jump”或“jumping”
 This next example uses some special characters that are available in regular expressions. The parenthesis create a group, and the question mark says "match the previous element (the group in this case) 0 or 1 times". It matches either 'jump' or 'jumps':
 这是一个略微复杂点的例子—它会匹配单词“jump”或“jumping”:
 特殊符号？--匹配它前面的字符组（（s））0或1次，可以匹配‘jump’或‘jumps’
 */
listMatches(pattern: "jump(s)?", inString: quickFox)
let chineseString = "美国,日本,澳大利亚,中国,俄罗斯,中国龙,阿萨德中国"
let chinesePattern = "(\\w)*中国(\\w)*"
listMatches(pattern: chinesePattern, inString: chineseString)

/*:
 ### #手机号
 
 */
highlightMatches(pattern: "1[387][0-9]{9}", inString: "12345131555512349999186000011118888")

/*:
 ### #邮箱
 
 */
highlightMatches(pattern: "[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+", inString: "123chenty@cct.cn, 123@qq.com, 456_abc@sina.com.cn, 4444")

/*: 
 ### #matches an HTML or XML tag:
 This one matches an HTML or XML tag:
 */
// 不带换行的html标签
//let htmlStringWithEnter = "<p>This is an example <strong>html</strong> string.</p>"
let htmlStringWithEnter = "<table class=\"wikitable\">        <tr>abc</tr>This is an example <strong>html</strong> string.</table>;<strong>html</strong>"
// 带换行的html 标签
let htmlString = "<tr>\n<th>英文术语</th><th>中文翻译</th><th>详细解释\n</th></tr>"

let pattern = "<([a-z][a-z0-9]*)\\b[^>]*>(.*?)</\\1>"  // 匹配任意html tag
//let pattern = "<(table)*\\b[^>]*>\\s(.*?)</\\1>"
//let pattern = "<(table)[^>]*>(.*?)</\\1>"
//let pattern = "<(table)\\b class=\"wikitable\">"
/* 注意html标签是有换行的（\n），正则匹配时要注意 */
//let trPattern = "<(tr)>([\\s\\S]*?)</\\1>"
//let trPattern = ">(.+?)<"
listMatches(pattern: pattern, inString: htmlStringWithEnter)
listMatches(pattern: pattern, inString: htmlString)

/*:
 ### #不包含某字符串
 
 */
listMatches(pattern: "or", inString: "matches an HTML or XML tag")
listMatches(pattern: "(.+)", inString: "how to matches an HTML or XML tag")



//: [Next](@next)

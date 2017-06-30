//: [Previous](@previous)

/*: 
 # Cheat Sheet
 
 //速记理解技巧
 . [ ] ^ $
 四个字符是所有语言都支持的正则表达式，所以这个四个是基础的正则表达式。正则难理解因为里面有一个等价的概念，这个概念大大增加了理解难度，让很多初学者看起来会蒙，如果把等价都恢复成原始写法，自己书写正则就超级简单了，就像说话一样去写你的正则了：
 ## 参考
 * [ICU Regular Expressions](http://userguide.icu-project.org/strings/regexp)
 * [regular-expressions.info](regular-expressions.info)
 
 ## 二级标题
 matches any 'word-like' character which
 匹配任何字母类型的字符，包括
 
 ### 三级标题
 matches any 'word-like' character which
 匹配任何字母类型的字符，包括
*/
/*:
 ### # \w=[A-Za-z_0-9] 匹配任何字母类的字符
 \w matches any 'word-like' character which includes the set of numbers, letters, and underscore, but does not match punctuation or other symbols. hello\w will match "hello_9" and "helloo" but not "hello!"
 
 "\w":匹配任何字母类型的字符，包括：数字、字母、下划线，不包括：标点符号或其他符号；
 */
let wordExample = "hello , helloooooo, hello_1114, hello, hello!"
listMatches(pattern: "hello\\w+", inString: wordExample)

/*:
 ### # \d=[0-9]
 \d matches a numeric digit, which in most cases means [0-9]. \d\d?:\d\d will match strings in time format, such as "9:30" and "12:45".
 
 \d 匹配数字，大部分情况下是[0-9]。\d\d?:\d\d会匹配时间格式的字符串，比如”9：30“和”12：45“。
 */
let digitExample = "9:30 12:45 df:24 ag:gh"
listMatches(pattern: "\\d?\\d:\\d\\d", inString: digitExample)

/*:
 ### # \b
 \b matches word boundary characters such as spaces and punctuation. to\b will match the "to" in "to the moon" and "to!", but it will not match "tomorrow". \b is handy for "whole word" type matching.
 
 \b 匹配字边界的字符，例如空格，标点符号。to\b 会匹配”to the moon”和“to!”中得“to”,但是不会匹配“tomorrow”。\b 用在整个单词的匹配方面和方便。
 */
let boundaryExample = "to the moon! when to go? tomorrow? to!, to_do, to-go"
highlightMatches(pattern: "to\\b", inString: boundaryExample)
listMatches(pattern: "to\\b", inString: boundaryExample)

listMatches(pattern: "to the\\b", inString: boundaryExample)

/*:
 ### # \s
 \s matches whitespace characters such as spaces, tabs, and newlines. hello\s will match "hello " in "Well, hello there!".
 
 \s 会匹配空白字符，比如，空格，制表符(tab)，换行符(\n)。hello\s 会匹配“Well,hello there!”中的 “hello ”。
 */
let whitespaceExample = "Well, helloWorld, hello-World, hello there!, hello!, hello。。。<>《》, hello\n, hello<>, hello "
listMatches(pattern: "hello\\s", inString: whitespaceExample)

listMatches(pattern: "hello\\S*", inString: whitespaceExample)

listMatches(pattern: "hello\\s\\S", inString: whitespaceExample)

listMatches(pattern: "[\\s\\S]*", inString: whitespaceExample)

listMatches(pattern: "[\\s\\S]+", inString: whitespaceExample)
/*:
 ### # ^
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

/*:
 ### # $
 $ matches at the end of a line. For example, the end$ will match against "It was the end" but not "the end was near"
 
 $ 用在一行的结束，例如，the end$ 会匹配“It was the end” 而不会去匹配 “the end was near”。
 */
let endExample = "The end was near. It was the end"
highlightMatches(pattern: "end$", inString: endExample)

/*:
 ### #.
 . matches any character. p.p matches pop, pup, pmp, p@p, and so on.
 
 ".":可以匹配任何字符。不能匹配换行符\n
 */
let anyExample = "pp, pip, pop, p%p, paap, piip, puup, pippin, p匹皮批p, p p, p\np, p_p, p\\p"
listMatches(pattern: "p.p", inString: anyExample)


/*:
 ### # * = {0,}
 \* matches the previous element 0 or more times. 12*3 will match 13, 123, 1223, 122223, and 1222222223.
 
 \* 匹配 它之前的元素0次或多次。12*3  会匹配 13, 123, 1223, 122223, 和 1222222223。
 */
let zeroOrMoreExample = "13, 123, 1223, 122223, 1222222223, 143222343"
highlightMatches(pattern: "12*3", inString: zeroOrMoreExample)
highlightMatches(pattern: "12{0,}3", inString: zeroOrMoreExample)

/*:
 ### # +={1,}
 + matches the previous element 1 or more times. 12+3 will match 123, 1223, 122223, 1222222223, but not 13.
 + 匹配 它之前的元素1次或多次. 12+3  会匹配  123, 1223, 122223, 和 1222222223。
 */
let oneOrMoreExample = "13, 123, 1223, 122223, 1222222223, 143222343"
highlightMatches(pattern: "12+3", inString: oneOrMoreExample)
highlightMatches(pattern: "12{1,}3", inString: oneOrMoreExample)

/*:
 ### # ?={0,1}
 ? matches the previous element 0 or 1 times. 12?3 will match 13 or 123, but not 1223.
 
 */
let possibleExample = "13, 123, 1223"
highlightMatches(pattern: "12?3", inString: oneOrMoreExample)
highlightMatches(pattern: "12{0,1}3", inString: oneOrMoreExample)

// (.*?)用法
/**
 
 */
highlightMatches(pattern: "12(.*)3", inString: oneOrMoreExample)
listMatches(pattern: "12(.*)3", inString: oneOrMoreExample)
highlightMatches(pattern: "12(.*?)3", inString: oneOrMoreExample)

// 不能匹配包含换行符（\n）
listMatches(pattern: "abc(.*?)abc", inString: "abc123egfabc45677abc")
listMatches(pattern: "abc(.*?)abc", inString: "abc\n123egfabc45677abc")
// 可以匹配任何字符，包含换行符（\n）
listMatches(pattern: "abc([\\s\\S]*?)abc", inString: "abc\n123egfabc45677abc")

/*:
 ### # { } {m,n}, {n}
 Curly braces { } contain the minimum and maximum number of matches. For example, 10{1,2}1 will match both "101" and "1001" but not "10001" as the minimum number of matches is 1 and the maximum number of matches is 2. He[Ll]{2,}o will match "HeLLo" and "HellLLLllo" and any such silly variation of "hello" with lots of L’s, since the minimum number of matches is 2 but the maximum number of matches is not set — and therefore unlimited!
 */
let numberExample1 = "101 1001 10001"
let numberExample2 = "HeLLo HellLLLllo"
highlightMatches(pattern: "10{1,2}1", inString: numberExample1) // {m,n}
highlightMatches(pattern: "He[Ll]{2,}", inString: numberExample2)
highlightMatches(pattern: "10{2}1", inString: numberExample1)   // {n}

/*:
 ### # ()
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


/*:
 ### # |
 You can include as many pipe characters in your regular expression as you would like. As an example, (Tom|Dick|Harry) is a valid pattern.
 
 竖线字符（|）执行的是或操作。只要你乐意，你可以包含多个竖线字符在你的正则表达式中。例如，(Tom|Dick|Harry)是一个有效的模式，它能匹配那三个名字中的任一个。
 */
let greeting = "Hello Tom, Dick, Harry!"
listMatches(pattern: "(Tom|Dick|Harry)", inString: greeting)
replaceMatches(pattern: "(Tom|Dick|Harry)", inString: greeting, withString: "James")

/*:
 ### # [ ]
 [] Character classes represent a set of possible single-character matches. Character classes appear between square brackets [ ]. As an example, the regular expression t[aeiou] will match "ta", "te", "ti", "to", or "tu". You can have as many character possibilities inside the square brackets as you like, but remember that any single character in the set will match. [aeiou] looks like five characters, but it actually means "a" or "e" or "i" or "o" or "u".
 
 [] 字符组（Character classes）相当于一组字符中匹配单个字符。字符组出现在中括号（[ 和 ]）之间。
 
 例如，正则表达式 t[aeiou]会匹配“ta”、“te”、“ti”、“to”或“tu”。你可以放任意多的字符在中括号中，但是请记住，只能匹配一个字符。[aeiou]看起来是五个字符，但它真实意义却是“a”或”e“或”i“或”o“或”u“。
 */
let theVowels = "ta te ti to tu th tj tk tm"
listMatches(pattern: "t[aeiou]", inString: theVowels)

/*:
 \# [m-n]
 
 You can also define a range in a character class if the characters appear consecutively. For example, to search for a number between 100 to 109, the pattern would be 10[0-9]. This returns the same results as 10[0123456789], but using ranges makes your regular expressions much cleaner and easier to understand. Ranges can also be used for characters - for example, [a-z] matches all lowercase characters, or [a-zA-Z] matches all upper and lower case.
 如果字符连续出现，你也能在字符组中定义一个范围。例如，为了搜索在100到109的数字，模式应该用10[0-9]。这和10[0123456789]会返回同样地结果，不过，使用范围来定义你的正则表达式看起来更简洁和易于理解。
 字符组不止局限于数字，你同样可以用字符来这样做。比如，[a-f]会匹配”a“，”b“，”c“，”d“，”e“或”f“。
 */
let theNumbers = "100 101 105 121 229 816"
listMatches(pattern: "10[0-9]", inString: theNumbers)
listMatches(pattern: "t[a-h]", inString: theVowels)

/*:
 \# [^x]
 
 Character classes usually contain the characters you want to match, but what if you want to explicitly not match a character? You can also define negated character classes, which use the ^ character. For example, the pattern t[^o] will match any combination of "t" and one other character except for the single instance of "to".
 字符集通常包含你想要匹配的字符，但是如果你想明确指出不要匹配的字符该怎么办？同样你能定义除此之外的字符组，把^放在前面。例如，模式t[^o]就会匹配包含”t“并且后面紧跟的字符是非o的字符。
 */
let notClasses = "tim tam tum tom tem"
listMatches(pattern: "t[^oa]m", inString: notClasses)



//: [Next](@next)

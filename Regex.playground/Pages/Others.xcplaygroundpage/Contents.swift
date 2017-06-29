//: [Previous](@previous)
/*:
 ## 数组去重
*/
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
if someOptionalString == nil {
    print("nil")
} else {
    print(someOptionalString!)
}

//: [Next](@next)

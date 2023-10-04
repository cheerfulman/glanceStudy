//
//  Words.swift
//  study_word
//
//  Created by ByteDance on 2023/10/3.
//

import Foundation
import AppKit
import Foundation

// Identifiable 需要集成该类，确定遍历的ID
class Word:Identifiable {
    var id: Int
    var word: String
    var translation: String
//    var phonetic: String
    
    init(id:Int, word: String, translation: String) {
        self.id = id
        self.word = word
        self.translation = translation
    }
    
//    init(id:Int, word: String, phonetic:String, translation: String) {
//        self.id = id
//        self.word = word
//        self.translation = translation
//        self.phonetic = phonetic
//    }
}


// 菜单栏显示相关
class MenuBarExtraManager: ObservableObject {
    private static var sharedSingleton: MenuBarExtraManager?
    
    @Published var time: String = ""
    public static var resourcePath: String = "CET-4"
//    public var resourceBookNameMap = ["CET-4":"四级乱序", "CET-zheng":"四级正序"]
    
    
    @Published var currentLine = 0
    @Published var wordsLen = 2
    @Published var withTimeIntervalSecond = 10
//    @Published var selectedWordBook = "CET-4"
    
    @Published var WordList: [Word] = [
//        Word(id: 1, word: "study", translation: "学习"),
//        Word(id: 2, word: "happy", translation: "开心")
    ]
    
    // 不同单词本对应的单词列表
    @Published var WordListMap = [String:[Word]]()
    // 不同单词本 显示到哪一个 单词下标
    @Published var WordIdxMap = [String:Int]()
    // 不同单词本 对应的总单词长度
    @Published var WordsLenMap = [String:Int]()
    
    @Published var word = "access"
    @Published var translation = "n.通道，入口"
    @Published var phonetic = ""
    
    
    
    private var timer: Timer?
    init() {
        start()
        readWordsFromText()
//        readWords()
    }
    
    
    // 公共静态方法，返回唯一的实例
    static func shared() -> MenuBarExtraManager {
        if let existingInstance = sharedSingleton {
            return existingInstance
        } else {
            sharedSingleton = MenuBarExtraManager()
            return sharedSingleton!
        }
    }
    
//    public func readWords() {
//        readWordsFromFile(resourcePath: "CET-4")
//        readWordsFromFile(resourcePath: "CET-zheng")
//    }
    
//    public func disPlayWord(selectedBook:String) -> String {
//        var word: String
//        var translation: String
//        print("selected:\(selectedBook)")
//        let curIdx = self.WordIdxMap[selectedBook] ?? 0
//        
//        
//        word = self.WordListMap[selectedBook]?[curIdx].word ?? ""
//        translation = self.WordListMap[selectedBook]?[curIdx].translation ?? ""
//        print("\(word) \(translation)")
//        
//        return "\(word) \(translation)"
//    }

    
    public func readWordsFromFile(resourcePath: String) {
        var wordList: [Word] = []
        // 指定要读取的文件的路径
        if let filePath = Bundle.main.path(forResource: resourcePath, ofType: nil) {
            do {
                let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
                // 将文件内容分割成行
                let lines = fileContent.components(separatedBy: .newlines)
                
                // 逐行处理
                for (i,line) in lines.enumerated() {
                    if line.count <= 1 {
                        continue
                    }
                    // 按空格分割每行内容
                    let words = line.components(separatedBy: .whitespaces)

                    if words.count <= 1 {
                        continue
                    }
                    
                    // 将单词后面的字符串全部拼接到译释中
                    var tran = ""
                    for (j, v) in words.enumerated() {
                        if j >= 1 {
                            tran = tran + v
                        }
                    }
                    wordList.append(Word(id: i, word: words[0], translation: tran))
                }
                self.WordListMap[resourcePath] = wordList
                self.WordsLenMap[resourcePath] = wordList.count
            } catch {
                print("无法读取文件: \(error)")
            }
        } else {
            print("文件不存在")
        }
    }
    
    public func readWordsFromText() {
        self.WordList = []
        self.currentLine = 0
        // 指定要读取的文件的路径
        if let filePath = Bundle.main.path(forResource: MenuBarExtraManager.resourcePath, ofType: nil) {
            do {
                let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
                // 将文件内容分割成行
                let lines = fileContent.components(separatedBy: .newlines)
                
                // 逐行处理
                var idx = 0
                for line in lines {
                    if line.count <= 1 {
                        continue
                    }
                    // 按空格分割每行内容
                    let words = line.components(separatedBy: .whitespaces)

                    if words.count <= 1 {
                        continue
                    }
                    
                    var tran = ""
                    for (i, v) in words.enumerated() {
                        if i >= 1 {
                            tran = tran + v
                        }
                    }
                    
                    self.WordList.append(Word(id: idx, word: words[0], translation: tran))
                    idx = idx + 1
                }
                self.wordsLen = self.WordList.count
//                print(self.WordList)
                
            } catch {
                print("无法读取文件: \(error)")
            }
        } else {
            print("文件不存在")
        }
    }
    
    public func start() {
        timer?.invalidate()
        print("重新开启定时器时间 \(self.withTimeIntervalSecond)")
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.withTimeIntervalSecond), repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }

    private func updateTime() {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        self.time = formatter.string(from: Date())
        
//        var curIdx = self.WordIdxMap[self.selectedWordBook]
//        curIdx = (curIdx ?? 0) + 1
//        if curIdx! >= self.WordsLenMap[self.selectedWordBook]! {
//            curIdx = 0
//        }
//        self.WordIdxMap[self.selectedWordBook] = curIdx
//        
//        self.word = self.WordListMap[self.selectedWordBook]?[curIdx ?? 0].word ?? ""
//        self.translation = self.WordListMap[self.selectedWordBook]?[curIdx ?? 0].translation ?? ""
        
        self.currentLine += 1
        if self.currentLine >= self.wordsLen {
            self.currentLine = 0
        }
        self.word = self.WordList[self.currentLine].word
        self.translation = self.WordList[self.currentLine].translation
//        self.phonetic = self.WordList[self.currentLine].phonetic
    }
}


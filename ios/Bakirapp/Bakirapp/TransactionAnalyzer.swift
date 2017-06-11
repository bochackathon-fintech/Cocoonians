//
//  TransactionAnalyzer.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import Foundation
import CoreML

class TransactionAnalyzer{
    
    static let shared = TransactionAnalyzer()
    
    var activated:Bool = false
    
    func setOfWords(strings: [String]) -> Set<String> {
        var wordSet = Set<String>()
        let tagger = NSLinguisticTagger(tagSchemes: [.lemma, .language, .lexicalClass], options: 0)
        
        for string in strings{
            let range = NSRange(location: 0, length: string.utf16.count)
            
            tagger.string = string
            
            tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: [.omitPunctuation, .omitWhitespace]) { tag, tokenRange, _ in
                //let token = (string as NSString).substring(with: tokenRange)
                // Each word of the text is inserted into the result set (in lowercase form).
                //wordSet.insert(token.lowercased())
                if let lemma = tag?.rawValue {
                    // If there is a lemma, it is also inserted into the result set (in lowercase form).
                    wordSet.insert(lemma.lowercased())
                }
            }
        }
        
        
        return wordSet
    }
    
    func getWordType(word:String)->NSLinguisticTag{
        let string = word
        
        var type:NSLinguisticTag = .otherWord
        
        let tagger = NSLinguisticTagger(tagSchemes: [.lemma, .language, .lexicalClass], options: 0)
        let range = NSRange(location: 0, length: string.utf16.count)
        tagger.string = string
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: [.omitPunctuation, .omitWhitespace]) { tag, tokenRange, _ in
            if let tag = tag{
                type = tag
            }
        }
        return type
    }
    
    func countWords(strings: [String]) -> [String:Int] {
        var wordsCount:[String:Int] = [:]
        let tagger = NSLinguisticTagger(tagSchemes: [.lemma, .language, .lexicalClass], options: 0)
        
        for string in strings{
            let range = NSRange(location: 0, length: string.utf16.count)
            
            tagger.string = string
            
            tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: [.omitPunctuation, .omitWhitespace]) { tag, tokenRange, _ in
                let token = (string as NSString).substring(with: tokenRange)
                let type = getWordType(word: token)
                
                if type == .adverb || type == .verb || type == .otherWord || type == .noun {
                    if let lemma = tag?.rawValue {
                        if lemma.lowercased() != "purchase" && lemma.lowercased() != "withdrawal" && lemma.lowercased() != "deposit" {
                            if let count = wordsCount[lemma]{
                                wordsCount[lemma] = count + 1
                            }
                            else{
                                wordsCount[lemma] = 1
                            }
                        }
                    }
                }
                
            }
        }
        return wordsCount
    }
    
}

//
//  AsyncDataframe.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

enum AsyncDataframe<T>{
    case nodata
    case received(T)
}

public class AsyncArray<T>{
    typealias Operation = () -> Void
    
    private var semaphore: Int = 0
    private let threadQueue: DispatchQueue = DispatchQueue(label: UUID().uuidString, attributes: .concurrent)
    private var rawArray: [T] = []
    private var operations: [Operation] = []
    
    convenience init(_ with: [T]) {
        self.init()
        self.rawArray = with
    }
    
    var array: [T]? {
        var head: [T]?
        threadQueue.sync {
            head = self.rawArray
        }
        return head
    }
    
    var first: T?{
        var head: T?
        threadQueue.sync {
            head = self.rawArray.first
        }
        return head
    }
    
    var last: T?{
        var head: T?
        threadQueue.sync {
            head = self.rawArray.last
        }
        return head
    }
    
    var count: Int{
        var count: Int = 0
        threadQueue.sync {
            count = self.rawArray.count
        }
        return count
    }
    
    func lock(){
        threadQueue.sync(flags: .barrier) {
            self.semaphore += 1
        }
    }
    
    func unlock(){
        threadQueue.sync(flags: .barrier) {
            if self.semaphore > 0 {
                self.semaphore -= 1
            }
            
            if self.semaphore == 0{
                while self.operations.count > 0{
                    let operation = self.operations.remove(at: 0)
                    self.threadQueue.async(flags: .barrier){
                        operation()
                    }
                }
            }
        }
    }
    
    func first(where predicate: (T) -> Bool) -> T? {
        var result: T?
        threadQueue.sync { result = self.rawArray.first(where: predicate) }
        return result
    }
    
    
    func filter(_ isIncluded: (T) -> Bool) -> [T] {
        var result = [T]()
        threadQueue.sync { result = self.rawArray.filter(isIncluded) }
        return result
    }
    
      func firstIndex(where predicate: (T) -> Bool) -> Int? {
          var result: Int?
          threadQueue.sync { result = self.rawArray.firstIndex(where: predicate) }
          return result
      }

      func sorted(by areInIncreasingOrder: (T, T) -> Bool) -> [T] {
          var result = [T]()
          threadQueue.sync { result = self.rawArray.sorted(by: areInIncreasingOrder) }
          return result
      }

      
      func flatMap<ElementOfResult>(_ transform: (T) -> ElementOfResult?) -> [ElementOfResult] {
          var result = [ElementOfResult]()
          threadQueue.sync { result = self.rawArray.compactMap(transform) }
          return result
      }

     
      func forEach(_ body: (T) -> Void) {
          threadQueue.sync { self.rawArray.forEach(body) }
      }
    
    func contains(where predicate: (T) -> Bool) -> Bool {
        var result = false
        threadQueue.sync { result = self.rawArray.contains(where: predicate) }
        return result
    }
    
    subscript(index: Int) -> T? {
        get {
            var result: T?
            
            threadQueue.sync {
                guard self.rawArray.startIndex..<self.rawArray.endIndex ~= index else { return }
                result = self.rawArray[index]
            }
            
            return result
        }
        set {
            guard let newValue = newValue else { return }
            
            let op = { self.rawArray[index] = newValue }
            handleWriteOperation(op)
        }
    }
    
    func handleWriteOperation(_ op: @escaping AsyncArray.Operation) {
        threadQueue.sync {
            if self.semaphore > 0 {
                self.operations.append { op() }
            } else {
                threadQueue.async(flags: .barrier) {
                    op()
                }
            }
        }
    }
    
    func append( _ element: T) {
        let op = { self.rawArray.append(element) }
        handleWriteOperation(op)
    }
    
    func append( _ elements: [T]) {
        let op = { self.rawArray += elements }
        handleWriteOperation(op)
    }
    
    func insert( _ element: T, at index: Int) {
        let op = { self.rawArray.insert(element, at: index) }
        handleWriteOperation(op)
    }
    
    func remove(at index: Int, completion: ((T) -> Void)? = nil) {
        let op = {
            let element = self.rawArray.remove(at: index)
            DispatchQueue.main.async {
                completion?(element)
            }
        }
        handleWriteOperation(op)
    }
    
    
    func remove(where predicate: @escaping (T) -> Bool, completion: ((T) -> Void)? = nil) {
        let op = {
            guard let index = self.rawArray.firstIndex(where: predicate) else { return }
            let element = self.rawArray.remove(at: index)
            DispatchQueue.main.async {
                completion?(element)
            }
        }
        handleWriteOperation(op)
    }
    
    func removeAll(completion: (([T]) -> Void)? = nil) {
        let op = {
            let elements = self.rawArray
            self.rawArray.removeAll()
            DispatchQueue.main.async {
                completion?(elements)
            }
        }
        handleWriteOperation(op)
    }
}

extension AsyncArray where T: Equatable{
    func contains(_ element: Element) -> Bool {
        var result = false
        threadQueue.sync { result = self.rawArray.contains(element) }
        return result
    }
}

extension AsyncArray: Sequence{
    public func makeIterator() -> Iterator {
        return Iterator(self.array)
    }
    
    public struct Iterator: IteratorProtocol {
        private var index: Int
        private var arr: [T]?
        
        init(_ array: [T]?) {
            self.arr = array
            index = 0
        }
        
        mutating public func next() -> T? {
            guard let arr = self.arr, arr.count > index else { return nil }
            let returnValue = arr[index]
            index += 1
            return returnValue
        }
    }
}

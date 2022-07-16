//
//  DisplayRepository.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/14.
//

import Foundation
import TinyNetworking
import os.log



protocol DisplayRepository {
    func requestSections()
    
    var onUpdate: ([Datum]) -> Void { get set }
}

final class DisplayRepositoryImplement: DisplayRepository {
    
    var onUpdate: ([Datum]) -> Void = { _ in }
    private var entry: [Datum] = Array<Datum>(repeating: Datum(), count: 4)
    
    private let provider = TinyNetworking<MusinsaTarget>()
    private var sections: Section? {
        didSet {
            self.distributeDatum()
            self.onUpdate(self.entry)
        }
    }
    
    
    init() {
        self.requestSections()
    }
    
    private func distributeDatum() {
        guard let sections = sections else {
            os_log(.default, "%@", "\(#file) sections is nil")
            return
        }
        sections.data.forEach {
            switch $0.contents.type {
            case "BANNER":
                self.entry[0] = $0
            case "GRID":
                self.entry[1] = $0
            case "SCROLL":
                self.entry[2] = $0
            case "STYLE":
                self.entry[3] = $0
            default:
                break
            }
        }
    }
    
    // MARK: - Scene 에서 요청됨
    func requestSections() {
        provider.request(resource: .sections) { [unowned self] result in
            switch result {
            case let .success(response):
                guard let sections = try? response.map(to: Section.self) else { return }
                self.sections = sections
            case let .failure(error):
                os_log(.error, "networkError::  %@", "\(error)")
                fatalError("\(#function) has an error")
            }
        }
    }
}

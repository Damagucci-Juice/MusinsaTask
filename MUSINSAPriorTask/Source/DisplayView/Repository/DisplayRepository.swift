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
    
    var onUpdate: () -> Void { get set }
}

final class DisplayRepositoryImplement: DisplayRepository {
    
    private let provider = TinyNetworking<MusinsaTarget>()
    
    var onUpdate: () -> Void = { }
    
    private var sections: Section? {
        didSet {
            self.distributeDatum()
            self.onUpdate()
        }
    }
    private(set) var bannerSection: Datum?
    private(set) var girdSection: Datum?
    private(set) var scrollSection: Datum?
    private(set) var stylesSection: Datum?
    
    init() {
        self.requestSections()
    }
    
    private func distributeDatum() {
        guard let sections = sections else {
//            os_log("%@", log: .default, type: .error, )
            os_log(.default, "%@", "\(#file) sections is nil")
            return
        }
        sections.data.forEach {
            switch $0.contents.type {
            case "BANNER":
                self.bannerSection = $0
            case "GRID":
                self.girdSection = $0
            case "SCROLL":
                self.scrollSection = $0
            case "STYLE":
                self.stylesSection = $0
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

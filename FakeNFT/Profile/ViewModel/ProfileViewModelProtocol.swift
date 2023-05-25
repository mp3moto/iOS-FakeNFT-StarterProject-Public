//
//  ProfileViewModelProtocol.swift
//  FakeNFT
//

import Foundation

protocol ProfileViewModelProtocol {

    var nameObservable: Observable<String> { get }
    var avatarURLObservable: Observable<URL?> { get }
    var descriptionObservable: Observable<String> { get }
    var websiteObservable: Observable<String> { get }
    var nftsObservable: Observable<[Int]> { get }
    var likesObservable: Observable<String> { get }

    func getProfile()
}

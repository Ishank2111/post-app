//
//  Post.swift
//  PostsApp
//
//  Created by Ishank on 18/10/25.
//

import Foundation

struct Post: Identifiable, Codable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

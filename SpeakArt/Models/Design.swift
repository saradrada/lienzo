//
//  Design.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import Foundation

struct Design: Codable, Identifiable {
    let id: String
    let title: String?
    let thumbnail: Thumbnail
    let urls: URLs

    struct Thumbnail: Codable {
        let width: Int
        let height: Int
        let url: String
    }

    struct URLs: Codable {
        let editURL: String
        let viewURL: String

        enum CodingKeys: String, CodingKey {
            case editURL = "edit_url"
            case viewURL = "view_url"
        }
    }
}


struct DesignMocks {
    static let designs: [Design] = [
        Design(
            id: "DAFVztcvd9z",
            title: "My summer holiday - Really long long long long title. Super long long long.",
            thumbnail: Design.Thumbnail(
                width: 595,
                height: 335,
                url: "https://document-export.canva.com/qhVEY/DAGNcmqhVEY/3/thumbnail/0001.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQYCGKMUHWDTJW6UD%2F20240810%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240810T055908Z&X-Amz-Expires=27871&X-Amz-Signature=5747b3881b6498b9f494db6dd1001ffaeea05338561fa3f2349bfb1608a60e84&X-Amz-SignedHeaders=host&response-expires=Sat%2C%2010%20Aug%202024%2013%3A43%3A39%20GMT"
            ),
            urls: Design.URLs(
                editURL: "https://www.canva.com/api/design/{token}/edit",
                viewURL: "https://www.canva.com/api/design/{token}/view"
            )
        ),
        Design(
            id: "ABCD1234EFG",
            title: "Winter Wonderland",
            thumbnail: Design.Thumbnail(
                width: 800,
                height: 450,
                url: "https://document-export.canva.com/Qb2S8/DAF_mZQb2S8/2/thumbnail/0001.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQYCGKMUHWDTJW6UD%2F20240809%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240809T130136Z&X-Amz-Expires=89762&X-Amz-Signature=9afd36d4cecb84cc9a60a39b4121408aec90822a3a00241e2ea2db34769aa03f&X-Amz-SignedHeaders=host&response-expires=Sat%2C%2010%20Aug%202024%2013%3A57%3A38%20GMT"
            ),
            urls: Design.URLs(
                editURL: "https://www.canva.com/api/design/{token2}/edit",
                viewURL: "https://www.canva.com/api/design/{token2}/view"
            )
        )
    ]
}

//
//  ARVisualizer.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct ARVisualizer: View {
    let design: Design

    var body: some View {
        VStack {
            Text("Design Visualizer")
            ARViewContainer(design: design)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ARVisualizer(design: Design(
        id: "DAFVztcvd9z",
        title: "My summer holiday",
        thumbnail: Design.Thumbnail(
            width: 595,
            height: 335,
            url: "https://document-export.canva.com/qhVEY/DAGNcmqhVEY/3/thumbnail/0001.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQYCGKMUHWDTJW6UD%2F20240810%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240810T055908Z&X-Amz-Expires=27871&X-Amz-Signature=5747b3881b6498b9f494db6dd1001ffaeea05338561fa3f2349bfb1608a60e84&X-Amz-SignedHeaders=host&response-expires=Sat%2C%2010%20Aug%202024%2013%3A43%3A39%20GMT"
        ),
        urls: Design.URLs(
            editURL: "https://www.canva.com/api/design/{token}/edit",
            viewURL: "https://www.canva.com/api/design/{token}/view"
        )
    ))
}

//
//  HomepageView.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 09.08.24.
//
import SwiftUI

struct HomepageView: View {
    @State private var showingSheet = false
    @StateObject var homePageViewModel = HomePageViewModel()
    @State private var selection = 2

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        header
                            .padding(.bottom)
                        myDesignsSection
                            .padding(.bottom)
                        Spacer()
                            .frame(height: 100)
                    }
                }
                .ignoresSafeArea()
            }
        }
    }

    private var myDesignsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My Designs")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading)
                .padding(.bottom, 8)
            DesignListView(designs: homePageViewModel.designs)
        }
    }

    private var header: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient:
                            Gradient(colors: [
                                .cPurple.opacity(0.1),
                                .cPurple]),
                           startPoint: .bottomTrailing,
                           endPoint: .center)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .shadow(radius: 10)
            .edgesIgnoringSafeArea(.all)

            Image("logohf")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 190)
                .offset(CGSize(width: 90, height: 65))

            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome,")
                    Text("Emma")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.bottom, 4)

                    Text("What will you \ndesign today?")
                        .font(.title2)
                        .bold()

                }
                Spacer()
            }
            .padding(.top, 60)
            .foregroundStyle(.white)
            .padding(.leading, 30)

        }
        .frame(height: 190)
    }
}

#Preview {
    HomepageView()
}

import SwiftUI

struct HomepageWithMenuView: View {
    @State private var showingSheet = false
    @StateObject var homePageViewModel = HomePageViewModel()
    @State private var selection = 2

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                Image("settings")
                    .tabItem {
                        Image(systemName: "checkmark.circle")
                        Text("Folders")
                    }
                    .tag(1)

                HomepageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)

                Image("profile")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .tint(.cPurple)
        }
    }
}

#Preview {
    HomepageWithMenuView()
}

import SwiftUI

struct PersonalizationView: View {
    @State private var isExpandedFirstList = false
    @State private var isExpandedSecondList = false
    @State private var selectedDate = Date()
    @State private var selectedArtist: Artist?
    @State private var isArtistProfilePresented = false
    @Environment(\.customColorScheme) var customColorScheme: CustomColorScheme
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var artistModel: ArtistModel // Added artistModel as an EnvironmentObject
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")

    struct ListItem {
        let name: String
        let imageName: String
    }

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:
                                                                    UIColor.init(Secondary)]

    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                        .frame(minHeight: 1)
                        .background(Secondary)

                    // First Disclosure Group - For Followed Artists
                    DisclosureGroup(
                        isExpanded: $isExpandedFirstList,
                        content: {
                            ForEach(dataModel.followedArtists) { item in
                                Button(action: {
                                    if let artist = artistModel.findArtistByName(name: item.name) {
                                                self.selectedArtist = artist
                                                self.isArtistProfilePresented = true
                                            }
                                }) {
                                    HStack {
                                        if let url = URL(string: item.imageName) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 40, height: 40)
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Secondary, lineWidth: 2))
                                                    .padding(.leading, 5)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        } else {
                                            Image(systemName: "guitars.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Secondary, lineWidth: 2))
                                                .padding(.leading, 5)
                                        }

                                        Spacer()

                                        Text(item.name)
                                            .foregroundColor(Secondary)
                                            .multilineTextAlignment(.center)

                                        Spacer()
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        },
                        label: {
                            Text("Followed Artists:")
                                .foregroundColor(Secondary)
                                .bold()
                            
                        }
                    )
                    .padding()
                    .accentColor(Secondary)

                    Divider()
                        .frame(minHeight: 1)
                        .background(Secondary)

                    // Second Disclosure Group - For Followed Concerts
                    DisclosureGroup(
                        isExpanded: $isExpandedSecondList,
                        content: {
                            ForEach(dataModel.followedConcerts) { item in
                                VStack {
                                    HStack {
                                        Text(item.name) // Venue name or concert name
                                            .foregroundColor(Secondary)
                                        Text("Date: \(item.date)")
                                            .foregroundColor(Secondary)
                                            .font(.subheadline)
                                        Text("Time: \(item.time)")
                                            .foregroundColor(Secondary)
                                            .font(.subheadline)
                                    }
                                    Divider()
                                        .frame(height: 2)
                                        .background(Secondary)
                                }
                                .padding(.vertical, 8)
                            }
                        },
                        label: {
                            Text("Followed Concerts:")
                                .foregroundColor(Secondary)
                                .bold()
                        }
                    )
                    .padding()
                    .accentColor(Secondary)
                }
                Divider()
                    .frame(minHeight: 1)
                    .background(Secondary)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Secondary)
                
            }
            .navigationTitle("Follows")
        }
        .environment(\.colorScheme, .dark)
        .sheet(isPresented: $isArtistProfilePresented) {
            if let artist = selectedArtist {
                ArtistProfile(artist: artist)
            } else {
                Text("Artist details not available.")
            }
        }
    }

    private func setNavigationBarAppearance() {
        let primaryUIColor = UIColor(customColorScheme.primaryColor)
        let secondaryUIColor = UIColor(customColorScheme.accentColor)

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: secondaryUIColor]
        UINavigationBar.appearance().backgroundColor = primaryUIColor
    }
}

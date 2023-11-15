import SwiftUI

struct PersonalizationView: View {
    @State private var isExpandedFirstList = false
    @State private var isExpandedSecondList = false
    @State private var selectedDate = Date()
    @Environment(\.customColorScheme) var customColorScheme: CustomColorScheme
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    
    struct ListItem {
            let name: String
            let imageName: String
        }
    
    init(){
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
                    DisclosureGroup(
                                            isExpanded: $isExpandedFirstList,
                                            content: {
                                                ForEach(DataModel.firstListItems, id: \.name) { item in
                                                    HStack {
                                                        Image(item.imageName) // Use your image logic here
                                                            .resizable()
                                                            .scaledToFill() // Ensures the image fills the frame
                                                            .frame(width: 40, height: 40) // Set the frame size
                                                            .clipShape(Circle())
                                                        
                                                        Text(item.name)
                                                            .foregroundColor(Secondary)
                                                    }
                                                }
                                            },
                                            label: {
                                                Text("Followed Artists:")
                                                    .foregroundColor(Secondary)
                                            }
                                        )
                                        .padding()
                                        .accentColor(Secondary)

                                        // Second Disclosure Group
                                        DisclosureGroup(
                                            isExpanded: $isExpandedSecondList,
                                            content: {
                                                ForEach(DataModel.secondListItems, id: \.name) { item in
                                                    HStack {
                                                        Image(item.imageName) // Use your image logic here
                                                            .resizable()
                                                            .scaledToFill() // Ensures the image fills the frame
                                                            .frame(width: 40, height: 40) // Set the frame size
                                                            .clipShape(Circle())
                                                        Text(item.name)
                                                            .foregroundColor(Secondary)
                                                    }
                                                }
                                            },
                                            label: {
                                                Text("Followed Concerts:")
                                                    .foregroundColor(Secondary)
                                                
                                            }
                                        )
                                        .padding()
                                        .accentColor(Secondary)
                    
                }
                Divider()
                    .frame(minHeight: 1)
                    .background(Secondary)
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle()) // This gives you a calendar view
                            .padding()
                            .accentColor(Secondary)
            }
            .navigationTitle("Follows")
//            .onAppear {
//                            setNavigationBarAppearance()
//                        }
        }
        .environment(\.colorScheme, .dark)
    }
    private func setNavigationBarAppearance() {
            let primaryUIColor = UIColor(customColorScheme.primaryColor)
            let secondaryUIColor = UIColor(customColorScheme.accentColor)
            
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: secondaryUIColor]
            UINavigationBar.appearance().backgroundColor = primaryUIColor
        }
    }



struct PersonalizationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationView()
    }
}

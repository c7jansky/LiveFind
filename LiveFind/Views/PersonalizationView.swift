import SwiftUI

struct PersonalizationView: View {
    @State private var isExpandedFirstList = false
    @State private var isExpandedSecondList = false
    @State private var selectedDate = Date()
    @Environment(\.customColorScheme) var customColorScheme: CustomColorScheme
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:
                                                                    UIColor.init(Secondary)]
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    DisclosureGroup(
                        isExpanded: $isExpandedFirstList,
                        content: {
                            ForEach(DataModel.firstListItems, id: \.self) { item in
                                Text(item)
                            }
                        },
                        label: {
                            Text("Followed Artists:")
                                .foregroundColor(Secondary) // Set the title color to Secondary
                        }
                    )
                    .padding()
                    .accentColor(Secondary) // Also set accent color if needed
                    
                    // Second Disclosure Group
                    DisclosureGroup(
                        isExpanded: $isExpandedSecondList,
                        content: {
                            ForEach(DataModel.secondListItems, id: \.self) { item in
                                Text(item)
                            }
                        },
                        label: {
                            Text("Followed Concerts:")
                                .foregroundColor(Secondary) // Set the title color to Secondary
                        }
                    )
                    .padding()
                    .accentColor(Secondary) // Also set accent color if needed
                }
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

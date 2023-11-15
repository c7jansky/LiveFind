import SwiftUI

struct PersonalizationView: View {
    @State private var isExpandedFirstList = false
    @State private var isExpandedSecondList = false
    @State private var selectedDate = Date()
    let Primary = Color("PrimaryColor")
    let Secondary = Color("SecondaryColor")
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:
                                                                    UIColor.init(Secondary)]
        UINavigationBar.appearance().backgroundColor = UIColor.init(Primary)
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // First Disclosure Group
                    DisclosureGroup("Followed Artists:", isExpanded: $isExpandedFirstList) {
                        ForEach(DataModel.firstListItems, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .padding()
                    .accentColor(.blue)

                    // Second Disclosure Group
                    DisclosureGroup("Followed Concerts:", isExpanded: $isExpandedSecondList) {
                        ForEach(DataModel.secondListItems, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .padding()
                    .accentColor(.blue)
                    
                }
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle()) // This gives you a calendar view
                            .padding()
            }
            .navigationTitle("Follows")
        }
    }
}

struct PersonalizationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationView()
    }
}

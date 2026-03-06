import Foundation

class KitManager: ObservableObject {
    @Published var items: [KitItem] = []
    
    let defaultItems = [
        "Water (1 gallon per person per day)",
        "Non-perishable food (3-day supply)",
        "Flashlight and extra batteries",
        "First aid kit",
        "Whistle (To signal for help)",
        "Dust mask (To help filter contaminated air)",
        "Moist towelettes, garbage bags",
        "Wrench or pliers (To turn off utilities)",
        "Manual can opener",
        "Local maps",
        "Cell phone with chargers and a backup battery"
    ]
    
    init() {
        load()
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "savedKitItems"),
           let decoded = try? JSONDecoder().decode([KitItem].self, from: data) {
            items = decoded
        } else {
            items = defaultItems.map { KitItem(name: $0, isPacked: false) }
            save()
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "savedKitItems")
        }
    }
    
    func toggle(item: KitItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isPacked.toggle()
            save()
        }
    }
    
    func addItem(_ name: String) {
        let newItem = KitItem(name: name, isPacked: false)
        items.insert(newItem, at: 0)
        save()
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }
}

import SwiftUI

struct KitBuilderView: View {
    @StateObject private var kitManager = KitManager()
    @State private var newItemName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add custom item", text: $newItemName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        if !newItemName.isEmpty {
                            withAnimation(.spring()) {
                                kitManager.addItem(newItemName)
                            }
                            newItemName = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding()
                
                let packedCount = kitManager.items.filter({ $0.isPacked }).count
                let totalCount = kitManager.items.count
                let progress = totalCount > 0 ? Double(packedCount) / Double(totalCount) : 0.0
                
                VStack(alignment: .leading) {
                    Text("\(packedCount) of \(totalCount) packed")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    ProgressView(value: progress)
                        .tint(.green)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(kitManager.items) { item in
                        HStack {
                            Text(item.name)
                                .strikethrough(item.isPacked, color: .secondary)
                                .foregroundColor(item.isPacked ? .secondary : .primary)
                            Spacer()
                            Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isPacked ? .green : .gray)
                                .font(.title2)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        kitManager.toggle(item: item)
                                    }
                                    let style: UIImpactFeedbackGenerator.FeedbackStyle = item.isPacked ? .light : .medium
                                    UIImpactFeedbackGenerator(style: style).impactOccurred()
                                }
                        }
                    }
                    .onDelete(perform: kitManager.deleteItems)
                }
            }
            .navigationTitle("Emergency Kit")
        }
    }
}

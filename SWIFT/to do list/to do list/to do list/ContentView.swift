import SwiftUI
import UserNotifications

struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var task: String
    var isCompleted: Bool = false
}

struct ToDoListApp: App {
    @StateObject private var taskStore = TaskStore()

    var body: some Scene {
        WindowGroup {
            ContentView(taskStore: taskStore)
        }
    }
}

class TaskStore: ObservableObject {
    @Published var tasks: [TaskItem] = []

    init() {
        loadTasks()
    }

    func addTask(_ task: TaskItem) {
        tasks.append(task)
        saveTasks()
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }

    func toggleCompletion(for taskItem: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == taskItem.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }

    private func saveTasks() {
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }
    }

    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decodedTasks = try? JSONDecoder().decode([TaskItem].self, from: data) {
            tasks = decodedTasks
        }
    }
}

struct ContentView: View {
    @ObservedObject var taskStore: TaskStore
    @State private var newTask = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Task", text: $newTask)
                    Button(action: addTask) {
                        Text("Add")
                    }
                }
                .padding()

                List {
                    ForEach(taskStore.tasks) { taskItem in
                        HStack {
                            Button(action: {
                                taskStore.toggleCompletion(for: taskItem)
                            }) {
                                Image(systemName: taskItem.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(taskItem.isCompleted ? .green : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle())

                            Text(taskItem.task)
                                .strikethrough(taskItem.isCompleted, color: .gray)
                                .foregroundColor(taskItem.isCompleted ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationBarTitle("To-Do List")
            .navigationBarItems(trailing: EditButton())
        }
    }

    func addTask() {
        if !newTask.isEmpty {
            let task = TaskItem(task: newTask)
            taskStore.addTask(task)
            newTask = ""
        }
    }

    func deleteTask(at offsets: IndexSet) {
        taskStore.deleteTask(at: offsets)
    }
}

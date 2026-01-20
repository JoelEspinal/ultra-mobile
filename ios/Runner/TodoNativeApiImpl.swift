import Foundation
import Flutter

class TodoNativeApiImpl: NSObject, TodoNativeApi {
    func fetchTodoDetail(id: Int64, completion: @escaping (Result<TodoDetailNative, Error>) -> Void) {
        // Mocking some extended data based on the ID
        // In a real app, this might come from a local database or a platform-specific storage
        
        let detail = TodoDetailNative(
            id: id,
            description: "Detailed description for task \(id) fetched from native iOS bridge.",
            category: id % 2 == 0 ? "Work" : "Personal",
            priority: Int64(id % 3), // mapped to Priority enum in Flutter: 0: High, 1: Medium, 2: Low
            dueDate: Int64(Date().addingTimeInterval(86400 * 7).timeIntervalSince1970 * 1000), // 7 days from now
            imageUrl: "https://picsum.photos/id/\(id % 100)/400/200"
        )
        
        // Simulating a slight delay to mimic network or database fetch
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(.success(detail))
        }
    }
}

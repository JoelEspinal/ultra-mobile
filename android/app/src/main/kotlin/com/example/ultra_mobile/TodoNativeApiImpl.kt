package com.example.ultra_mobile

import com.example.ultra_mobile.TodoDetailNative
import com.example.ultra_mobile.TodoNativeApi

class TodoNativeApiImpl : TodoNativeApi {
    override fun fetchTodoDetail(id: Long, callback: (kotlin.Result<TodoDetailNative>) -> Unit) {
        // In a real app, this might fetch from a native database or another service.
        // For this challenge, we simulate providing extended details for the Task.
        
        val detail = TodoDetailNative(
            id = id,
            description = "This is a detailed description for task #$id, provided natively by Android. It includes more context than the simple task title seen on the main list.",
            category = if (id % 2 == 0L) "Work" else "Personal",
            priority = (id % 3).toLong(),
            dueDate = System.currentTimeMillis() + (86400000 * 7), // Due in 7 days
            imageUrl = "https://picsum.photos/seed/$id/600/400"
        )
        
        callback(kotlin.Result.success(detail))
    }
}

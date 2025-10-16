// lib/todo_detail_page.dart (Stateless Conversion)

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/todo.dart';
import './todo_detail_cubit.dart';
import 'todo_detail_status.dart';

enum TodoDetailStatus { loading, success, failure }

class TodoDetailPage extends StatelessWidget {
  final Todo todo;

  const TodoDetailPage({super.key, required this.todo});

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  String _getPriorityLabel(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'High Priority';
      case Priority.medium:
        return 'Medium Priority';
      case Priority.low:
        return 'Low Priority';
    }
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  // --- BUILD METHOD ---

  @override
  Widget build(BuildContext context) {
    context.read<TodoDetailCubit>().loadTodoDetail(todo);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
        actions: [
          BlocBuilder<TodoDetailCubit, TodoDetailState>(
            builder: (context, state) {
              if (state.todoDetail != null) {
                return IconButton(
                  onPressed: () {
                    context.read<TodoDetailCubit>().toggleFavorite();
                  },
                  icon: Icon(
                    (state.todoDetail != null)
                        ? (state.todoDetail?.isFavorite != null &&
                                  state.todoDetail?.isFavorite == true)
                              ? Icons.star
                              : Icons.star_border
                        : Icons.star_border,
                    color: (state.todoDetail != null)
                        ? (state.todoDetail?.isFavorite != null &&
                                  state.todoDetail?.isFavorite == true)
                              ? Colors.amber
                              : Colors.white
                        : Colors.white,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Pending implementation of save functionality
              // context.read<TodoDetailCubit>().saveTodo();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving changes...')),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<TodoDetailCubit, TodoDetailState>(
        listener: (context, state) {
          if (state.status == TodoDetailStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
          // Controller update logic removed as controllers are no longer used.
        },
        builder: (context, state) {
          if (state.status == TodoDetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.todoDetail == null) {
            return const Center(child: Text('No todo found'));
          }

          if (state.status == TodoDetailStatus.success) {}

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                _buildSectionTitle('Title'),
                // Replaced TextEditingController with initialValue and onChanged
                TextFormField(
                  // Key ensures the TextFormField is reset/rebuilt when the BLoC state object changes
                  key: ValueKey(todo.id),
                  initialValue: todo.todo,
                  onChanged: (value) {
                    context.read<TodoDetailCubit>().updateTitle(value);
                  },
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter todo title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Completed Status (Logic unchanged)
                Card(
                  child: CheckboxListTile(
                    title: const Text('Mark as Completed'),
                    value: todo.completed,
                    onChanged: (_) {
                      context.read<TodoDetailCubit>().toggleCompleted();
                    },
                    secondary: Icon(
                      todo.completed
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: todo.completed ? Colors.green : null,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Description Section
                _buildSectionTitle('Description'),
                // Replaced TextEditingController with initialValue and onChanged
                TextFormField(
                  key: ValueKey('${todo.id}_desc'),
                  initialValue: todo.description,
                  onChanged: (value) {
                    context.read<TodoDetailCubit>().updateDescription(value);
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Enter detailed description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Due Date Section (Logic unchanged)
                _buildSectionTitle('Due Date'),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                      todo.dueDate != null
                          ? DateFormat('MMM dd, yyyy').format(todo.dueDate!)
                          : 'No due date set',
                    ),
                    trailing: todo.dueDate != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              context.read<TodoDetailCubit>().updateDueDate(
                                null,
                              );
                            },
                          )
                        : null,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: todo.dueDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365 * 5),
                        ),
                      );
                      if (date != null) {
                        context.read<TodoDetailCubit>().updateDueDate(date);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Priority Section (Logic unchanged)
                _buildSectionTitle('Priority'),
                Card(
                  child: Column(
                    children: Priority.values.map((priority) {
                      return RadioListTile<Priority>(
                        title: Text(_getPriorityLabel(priority)),
                        value: priority,
                        groupValue: Priority.values.firstWhere(
                          (p) => p == todo.priority,
                          orElse: () => Priority.medium,
                        ),
                        onChanged: (Priority? value) {
                          if (value != null) {
                            context.read<TodoDetailCubit>().updatePriority(
                              value,
                            );
                          }
                        },
                        secondary: Icon(
                          Icons.flag,
                          color: _getPriorityColor(priority),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Category Section
                _buildSectionTitle('Category'),
                // Replaced TextEditingController with initialValue and onChanged
                TextFormField(
                  key: ValueKey('${todo.id}_category'),
                  initialValue: todo.category,
                  onChanged: (value) {
                    context.read<TodoDetailCubit>().updateCategory(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter category (e.g., Work, Personal)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                ),
                const SizedBox(height: 24),

                // Image Attachment Section (Using imagePath property)
                _buildSectionTitle('Attachment'),
                // Added a check to ensure the file exists before attempting to load
                if (todo.imagePath != null &&
                    File(todo.imagePath!).existsSync()) ...[
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(todo.imagePath!),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black54,
                          ),
                          onPressed: () {
                            context.read<TodoDetailCubit>().removeImage();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.read<TodoDetailCubit>().pickImageFromCamera();
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Camera'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<TodoDetailCubit>()
                              .pickImageFromGallery();
                        },
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Gallery'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Reminder Section (Logic unchanged)
                _buildSectionTitle('Reminder'),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(
                      todo.reminderTime != null
                          ? DateFormat(
                              'MMM dd, yyyy - hh:mm a',
                            ).format(todo.reminderTime!)
                          : 'No reminder set',
                    ),
                    trailing: todo.reminderTime != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              context.read<TodoDetailCubit>().setReminder(null);
                            },
                          )
                        : null,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: todo.reminderTime ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );

                      if (date != null && context.mounted) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                            todo.reminderTime ?? DateTime.now(),
                          ),
                        );

                        if (time != null) {
                          final reminderDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                          context.read<TodoDetailCubit>().setReminder(
                            reminderDateTime,
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

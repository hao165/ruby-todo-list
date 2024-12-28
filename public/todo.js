const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

const app = Vue.createApp({
    data() {
        return {
            todos: [],
            newTodoTitle: '',
            loading: false,
            error: null,
        };
    },
    methods: {
        // 加載 TODO 項目
        async loadTodos() {
            try {
                this.loading = true;
                const response = await fetch('http://localhost:3000/api/todos'); // 這是 API 的 URL
                const data = await response.json();
                this.todos = data;
            } catch (err) {
                this.error = 'Failed to fetch todos';
            } finally {
                this.loading = false;
            }
        },
        // 創建新的 TODO 項目
        async createTodo() {
            try {
                if (!this.newTodoTitle) return; // 防止創建空白 TODO
                const response = await fetch('http://localhost:3000/api/todos', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': csrfToken,
                    },
                    body: JSON.stringify({
                        title: this.newTodoTitle,
                        completed: false,
                    }),
                });
                const newTodo = await response.json();
                this.todos.push(newTodo); // 更新 TODO 列表
                this.newTodoTitle = ''; // 清空輸入框
            } catch (err) {
                this.error = 'Failed to create todo';
            }
        },
        // 更新 TODO 項目狀態
        async toggleTodoStatus(todo) {
            try {
                const response = await fetch(`http://localhost:3000/api/todos/${todo.id}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': csrfToken,
                    },
                    body: JSON.stringify({
                        title: todo.title,
                        completed: !todo.completed,
                    }),
                });
                const updatedTodo = await response.json();
                todo.completed = updatedTodo.completed;
            } catch (err) {
                this.error = 'Failed to update todo';
            }
        },
        // 刪除 TODO 項目
        async deleteTodo(todoId) {
            try {
                const response = await fetch(`http://localhost:3000/api/todos/${todoId}`, {
                    method: 'DELETE',
                    headers: {
                        'X-CSRF-Token': csrfToken,
                    },
                });
                if (response.ok) {
                    this.todos = this.todos.filter(todo => todo.id !== todoId); // 刪除項目
                }
            } catch (err) {
                this.error = 'Failed to delete todo';
            }
        },
    },
    created() {
        this.loadTodos(); // 加載 TODO 項目
    },
});

app.mount('#app');

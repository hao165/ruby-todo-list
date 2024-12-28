# TODO List API

首次建立 Ruby on Rails (RoR) 練習專案。

遵守 MVC 架構，並撰寫 TestCase

---

## 目錄結構

```plaintext
rails-todo-api/
├── Dockerfile                # 構建應用的 Docker 映像
├── docker-compose.yml        # Docker Compose 配置檔案
├── Gemfile                   # Rails 專案的 gem 依賴
├── Gemfile.lock              # 記錄具體版本的 gem 鎖定檔案
├── app/                      # 應用程式程式碼
│   ├── controllers/          # 控制器，負責處理 HTTP 請求，並返回對應的響應
│   │   └── todos_controller.rb  # 管理 TODO 項目的控制器
│   ├── models/               # 模型，負責處理業務邏輯和與資料庫的交互
│   │   └── todo.rb           # TODO 項目的模型
├── config/                   # 配置檔案
│   ├── database.yml          # 數據庫配置
│   └── routes.rb             # 定義 API 路由
├── db/                       # 數據庫相關檔案
│   ├── migrate/              # 數據庫遷移檔案
│   │   └── *_create_todos.rb # 創建 TODO 表的遷移檔案
│   └── seeds.rb              # 用於填充初始數據的種子檔案
├── test/                     # 測試文件
│   ├── controllers/          # 控制器的單元測試
│   ├── models/               # 模型的單元測試
│   └── fixtures/             # 用於測試的假資料
└─
```

---

## 需求

- Docker
- Docker Compose
- Git

---

## 環境
- Ruby 3.3
- Rails 7.0
- PostgreSQL 12

---

## 安裝

### 1. 複製專案

從 GitHub 克隆這個專案到你的本地機器：

```bash
git clone https://github.com/hao165/ruby-todo-list.git
cd ruby-todo-list
```

### 2. 建立 Docker 映像並啟動容器
使用 Docker Compose 來建立和啟動應用程式和 PostgreSQL 數據庫容器。

```bash
docker-compose up --build
```

### 3. 設定數據庫
啟動容器後，運行以下命令來設定數據庫（包含創建、遷移和種子數據）：

```bash
docker-compose exec app rails db:create
docker-compose exec app rails db:migrate
```

### 4. 檢查應用運行狀況
應用程式應該會在 Docker 容器內部運行，並且暴露在預設端口。根據你設置的端口，使用以下 URL 在瀏覽器中檢查應用程序：

**查看所有 TODO 項目**
```bash
curl http://localhost:3000/todos
```

**新增 TODO 項目**
```bash
curl -X POST -H "Content-Type: application/json" -d '{"title": "Learn Ruby", "completed": false}' http://localhost:3000/todos
```

**更新 TODO 項目**
```bash
curl -X PUT -H "Content-Type: application/json" -d '{"completed": true}' http://localhost:3000/todos/1
```

**刪除 TODO 項目**
```bash
curl -X DELETE http://localhost:3000/todos/1
```

### 5. 執行測試

```bash
docker-compose exec app rails test
```

### 6. 停止 Docker 容器

```bash
docker-compose down
```

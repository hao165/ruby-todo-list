require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:one) # 使用 fixtures，預設應在 test/fixtures/todos.yml 中配置
  end

  # 測試 index 動作
  test "should get index" do
    get todos_url, as: :json
    assert_response :success
  end

  # 測試 show 動作
  test "should show todo" do
    get todo_url(@todo), as: :json
    assert_response :success

    # 驗證回傳的 JSON 資料
    json_response = JSON.parse(response.body)
    assert_equal @todo.title, json_response["title"]
    assert_equal @todo.completed, json_response["completed"]
  end

  # 測試 create 動作
  test "should create todo" do
    assert_difference("Todo.count") do
      post todos_url, params: { todo: { title: "New Todo", completed: false } }, as: :json
    end
    assert_response :created
  end

  # 測試 update 動作
  test "should update todo" do
    patch todo_url(@todo), params: { todo: { title: "Updated Title", completed: true } }, as: :json
    assert_response :success

    # 驗證資料是否更新
    @todo.reload
    assert_equal "Updated Title", @todo.title
    assert @todo.completed
  end

  # 測試 destroy 動作
  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo), as: :json
    end
    assert_response :no_content
  end
end

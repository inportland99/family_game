require 'test_helper'

class PointsSpentsControllerTest < ActionController::TestCase
  setup do
    @points_spent = points_spents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:points_spents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create points_spent" do
    assert_difference('PointsSpent.count') do
      post :create, points_spent: { rewards_id: @points_spent.rewards_id, user_id: @points_spent.user_id, xp_spent: @points_spent.xp_spent }
    end

    assert_redirected_to points_spent_path(assigns(:points_spent))
  end

  test "should show points_spent" do
    get :show, id: @points_spent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @points_spent
    assert_response :success
  end

  test "should update points_spent" do
    put :update, id: @points_spent, points_spent: { rewards_id: @points_spent.rewards_id, user_id: @points_spent.user_id, xp_spent: @points_spent.xp_spent }
    assert_redirected_to points_spent_path(assigns(:points_spent))
  end

  test "should destroy points_spent" do
    assert_difference('PointsSpent.count', -1) do
      delete :destroy, id: @points_spent
    end

    assert_redirected_to points_spents_path
  end
end

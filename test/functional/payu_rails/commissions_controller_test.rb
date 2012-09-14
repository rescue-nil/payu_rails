require 'test_helper'

module PayuRails
  class CommissionsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
    test "should get update" do
      get :update
      assert_response :success
    end
  
  end
end

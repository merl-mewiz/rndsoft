require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
    fixtures :posts

    test "show posts list" do
        get posts_url
        assert_response :success
        assert_not_nil assigns(:posts)
    end

    test "show one post" do
        get post_url(1)
        assert_response :success
        assert_not_nil assigns(:post)
    end

    test "index should render correct template and layout" do
        get posts_url
        assert_template :index
        assert_template layout: "layouts/application"
    end

end

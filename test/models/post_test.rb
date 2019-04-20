require 'test_helper'

class PostTest < ActiveSupport::TestCase
    fixtures :posts

    test "test posts model" do
        test_post = Post.new :title => 'test post title',
            :description => 'test post description',
            :body => 'test post body'

        assert test_post.save

        test_post_copy = Post.find(test_post.id)

        assert_equal test_post.title, test_post_copy.title

        test_post.title = "Testing post"

        assert test_post.save
        assert test_post.destroy
    end

    test "should not save post without title" do
        post = Post.new
        assert_not post.save, "Saved the post without a title"
    end
end

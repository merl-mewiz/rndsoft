class PostsController < ApplicationController
    load_and_authorize_resource

    def index
        if params[:myposts] == '1'
            @posts = Post.where(user_id: current_user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
        else
            @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
        editForm_params
    end

    def edit
        @post = Post.find(params[:id])
        editForm_params(@post.id)
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            editForm_params(@post.id)
            flash[:notice] = "Пост «#{@post.title}» успешно создан"
            redirect_to edit_post_path(@post)
        else
            editForm_params
            flash.now[:alert] = blogShowErrors(@post)
            render :new
        end
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            editForm_params(@post.id)
            flash[:notice] = "Пост «#{@post.title}» успешно обновлен"
            redirect_to edit_post_path(@post)
        else
            editForm_params(@post.id)
            flash.now[:alert] = blogShowErrors(@post)
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        deltitle = @post.title
        if @post.destroy
            flash[:notice] = "Пост «#{deltitle}» успешно удален"
            redirect_to posts_path
        else
            editForm_params(@post.id)
            flash.now[:alert] = blogShowErrors(@post)
            render :edit
        end
    end

    private
        def post_params
            params.require(:post).permit(:title, :description, :body)
        end

        def editForm_params(id = nil)
            unless id.blank?
                @blog_form_url = post_path(id)
                @blog_form_method = "patch"
            else
                @blog_form_url = posts_path
                @blog_form_method = "post"
            end
        end
end

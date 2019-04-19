class NewsController < ApplicationController
    before_action only: [:new, :edit, :create, :update, :destroy] do
        check_auth()
    end

    def index
        @news = News.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    end

    def show
        @one_news = News.find(params[:id])
    end

    def new
        @one_news = News.new
        @digest_default = 2
        editForm_params
    end

    def edit
        @one_news = News.find(params[:id])
        @digest_default = @one_news.mail_digest
        editForm_params(@one_news.id)
    end

    def create
        @one_news = News.new(news_params)
        if @one_news.save
            editForm_params(@one_news.id)
            flash[:notice] = "Новость «#{@one_news.title}» успешно создана"
            redirect_to edit_news_path(@one_news)
        else
            editForm_params
            flash.now[:alert] = blogShowErrors(@one_news)
            render :new
        end
    end

    def update
        @one_news = News.find(params[:id])
        if @one_news.update(news_params)
            editForm_params(@one_news.id)
            flash[:notice] = "Новость «#{@one_news.title}» успешно обновлена"
            redirect_to edit_news_path(@one_news)
        else
            editForm_params(@one_news.id)
            flash.now[:alert] = blogShowErrors(@one_news)
            render :edit
        end
    end

    def destroy
        @one_news = News.find(params[:id])
        deltitle = @one_news.title
        if @one_news.destroy
            flash[:notice] = "Новость «#{deltitle}» успешно удалена"
            redirect_to news_index_path
        else
            editForm_params(@one_news.id)
            flash.now[:alert] = blogShowErrors(@one_news)
            render :edit
        end
    end

    private
        def news_params
            params.require(:one_news).permit(:title, :mail_digest, :body)
        end

        def editForm_params(id = nil)
            unless id.blank?
                @blog_form_url = news_path(id)
                @blog_form_method = "patch"
            else
                @blog_form_url = news_index_path
                @blog_form_method = "post"
            end
        end
end

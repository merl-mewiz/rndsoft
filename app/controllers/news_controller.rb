class NewsController < ApplicationController
    load_and_authorize_resource

    def index
        @news = News.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    end

    def show
        @one_news = News.find(params[:id])
    end

    def new
        @one_news = News.new
        editForm_params
    end

    def edit
        @one_news = News.find(params[:id])
        editForm_params(@one_news.id)
    end

    def create
        @one_news = News.new(news_params)
        if @one_news.save
            editForm_params(@one_news.id)
            redirect_to edit_news_path(@one_news), :notice => 'Новость успешно создана'
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
            redirect_to edit_news_path(@one_news), :notice => 'Новость успешно обновлена'
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
            redirect_to news_index_path, :notice => 'Новость успешно удалена'
        else
            editForm_params(@one_news.id)
            flash.now[:alert] = blogShowErrors(@one_news)
            render :edit
        end
    end

    private
        def news_params
            params.require(:one_news).permit(:title, :body)
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

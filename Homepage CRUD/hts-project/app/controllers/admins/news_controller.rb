class Admins::NewsController < ApplicationController

	before_action :authenticate_admin!

	layout 'admin'

	def index
		@news = News.all
		@news = News.order(created_at: :desc)
	end

	def new
		@news = News.new
	end

	def create
		news = News.new(news_params)
		if news.save
			redirect_to admins_news_index_path
			flash[:notice] = "Newsitem succesvol aangemaakt"
		else
			redirect_to new_admins_news_path

			news.errors.messages.each do |c|
				flash[:alert] = c[1].first
			end
		end
	end

	def edit
		@news = News.find(params[:id])
	end

	def update
		@news = News.find(params[:id])
		@news.update(news_params)
		if @news.save
			redirect_to admins_news_index_path
			flash[:notice] = "Nieuwsitem succesvol aangepast"
		else
			redirect_to edit_admins_news_path(params[:id])

			@news.errors.messages.each do |c|
				flash[:alert] = c[1].first
			end
		end
		
	end

	def destroy
		@news = News.find(params[:id])
		@news.destroy
		
		redirect_to admins_news_index_path
	end



	private

	def news_params
		params.require(:news).permit(:title, :content, :image, :before)
	end

end

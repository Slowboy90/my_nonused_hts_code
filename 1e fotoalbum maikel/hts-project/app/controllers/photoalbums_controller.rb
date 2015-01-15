class PhotoalbumsController < ApplicationController
	def index
		@photoalbums = Photoalbum.all
		@photoalbums = Photoalbum.order(name: :asc) 
	end

	def show
		@photoalbum = Photoalbum.find(params[:id])
	end

	def new
		@photoalbum = Photoalbum.new
	end

	def create
		@photoalbum = Photoalbum.new(user_params)

		if @photoalbum.save
			redirect_to root_path
		else
			redirect_to new_photoalbum_path
		end
	end

	def edit
		@photoalbum = Photoalbum.find(params[:id])
	end

	def update
		@photoalbum = Photoalbum.find(params[:id])
		@photoalbum.update(user_params)

		if @photoalbum.save
			redirect_to root_path
		else
			redirect_to edit_photoalbum_path 
		end
	end

	def destroy
		@photoalbum = Photoalbum.find(params[:id])
		@photoalbum.photos.each do |c|
			c.destroy
		end

		@photoalbum.destroy

		redirect_to root_path
	end


	private
	def user_params														# parameters hebben een photoalbum nodig en laten je alleen de naam veranderen.
		params.require(:photoalbum).permit(:name)
	end
end

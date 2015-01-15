class PhotoalbumsController < ApplicationController
	def index
		@photoalbums = Photoalbum.all
		@photoalbums = Photoalbum.order(created_at: :desc)
	end

	def show
		begin
			photoalbum = Photoalbum.find(params[:id])
			@photoalbum = photoalbum.photos.paginate(:page => params[:page], :per_page => 6)
			@newphoto = Photoalbum.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to photoalbums_path
		end
	end
end

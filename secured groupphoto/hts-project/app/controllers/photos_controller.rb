class PhotosController < ApplicationController
	def index
		@photoalbum = Photoalbum.find(params[:photoalbum_id])

	end

	def create
	    @photoalbum = Photoalbum.find(params[:photoalbum_id])
	    @photo = @photoalbum.photos.new(photo_params)
		if @photo.save
			redirect_to photoalbum_path(@photoalbum)
			flash[:notice] = "Foto succesvol geupload"
		else
			@photo.errors.messages.each do |c|
				flash[:alert] = c[1].first
			end
			redirect_to photoalbum_path(@photoalbum)
		end
	end

	def destroy
		@photoalbum= Photoalbum.find(params[:photoalbum_id])
		@photo = Photo.find(params[:id])
		@photo.destroy

		redirect_to photoalbum_path(@photoalbum)
	end
 
  private
    def photo_params
      params.fetch(:photo, {}).permit(:file_name)
    end
end

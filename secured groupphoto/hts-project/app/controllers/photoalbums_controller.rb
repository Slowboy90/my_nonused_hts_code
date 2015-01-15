class PhotoalbumsController < ApplicationController
	
	# Check if admin is loged in.
	before_action :authenticate_admin!, :except => [:index, :show]

	def index
		@photoalbums = Photoalbum.all
		@photoalbums = Photoalbum.order(created_at: :desc)
	end

	def show
		photoalbum = Photoalbum.find(params[:id])
		@photoalbum = photoalbum.photos.paginate(:page => params[:page], :per_page => 6)
		@newphoto = Photoalbum.find(params[:id])
	end

	def new
		@photoalbum = Photoalbum.new
	end

	def create
		photoalbum = Photoalbum.new(photoalbum_params)
		if photoalbum.save
			redirect_to photoalbums_path
			flash[:notice] = "Fotoalbum succesvol aangemaakt"
		else
			redirect_to new_photoalbum_path

			photoalbum.errors.messages.each do |c|
				flash[:alert] = c[1].first
			end		
		end

	end

	def edit
		@photoalbum = Photoalbum.find(params[:id])
	end

	def update
		@photoalbum = Photoalbum.find(params[:id])
		@photoalbum.update(photoalbum_params)
		if @photoalbum.save
			redirect_to photoalbums_path
			flash[:notice] = "Fotoalbum succesvol aangepast"
		else
			redirect_to edit_photoalbum_path(params[:id])
			
			@photoalbum.errors.messages.each do |c|
				flash[:alert] = c[1].first
			end		
		end
	end

	def destroy
		@photoalbum = Photoalbum.find(params[:id])
		@photoalbum.photos.each do |c|
			c.destroy
		end
		@photoalbum.destroy

		redirect_to photoalbums_path
	end

	private

	 def photoalbum_params
	 	params.require(:photoalbum).permit(:name)
	 end
end

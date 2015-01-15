class GroupphotosController < ApplicationController

	before_action :authenticate_user!, except: :public_index

	def index
		@groupphotos = Groupphoto.where(:person_id => current_user.person_id)
	end

	def public_index
		if Person.exists?(:unique_code => params[:q])
			@groupphotos = Groupphoto.where(:person_id => Person.where(:unique_code => params[:q]).first.id)
		else
			redirect_to groupphotos_path
		end
	end
end

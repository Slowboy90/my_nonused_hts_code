class GroupphotosController < ApplicationController

	before_action :authenticate_user!

	def index
		@groupphotos = Groupphoto.where(:person_id => current_user.person_id)
	end
end

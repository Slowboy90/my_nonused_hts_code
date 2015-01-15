class Admins::PagesController < ApplicationController
	# Check if admin is loged in.
	before_action :authenticate_admin!

	layout 'admin'

	def index
		
	end
	
	def json_query
		@names = []
		@first_name = Person.all
		@last_name = Person.select(:last_name)
		@first_name.each do |n|
			name = n.first_name.to_s
			name += " "
			name += n.last_name.to_s
			@names.push(name)
		end
		# @suggestions += " "
		# @suggestions += Person.select(:last_name)
  		render json: @names
	end
end

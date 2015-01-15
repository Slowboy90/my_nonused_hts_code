class ChartsController < ApplicationController
	def index
		@graduation_year = Person.where.not(graduation_year: 0).group("graduation_year").count		
		if(params['year'])			
			@major = Person.where(:graduation_year => params['year']).group("major").count
		else
			@major = Person.group("major").count
		end
		render :layout => false;
	end
end

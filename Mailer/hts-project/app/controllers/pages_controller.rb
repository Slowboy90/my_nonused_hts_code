class PagesController < ApplicationController

	def index
		@major = Person.where.not("major = ?", "").group(:major).count
		@year = Person.where.not("graduation_year = ?", 0).group(:graduation_year).count
	end
end

class HomeController < ApplicationController

	before_action :authenticate_user!
	
	# Welcome Page
	def index
	end	

end
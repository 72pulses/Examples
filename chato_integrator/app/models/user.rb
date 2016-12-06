class User < ApplicationRecord
	require 'httparty'
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable

	after_create :get_uuid

	def get_uuid
		url = "http://localhost:8000/apis/users.json"
		result = HTTParty.post(url, 
								    :body => { :email => email, 
								               :username => full_name
								             }.to_json,
								    :headers => { 
								    		'Content-Type' => 'application/json',
								    		'Authorization' => 'Token token=c494c0c8-a5fa-45ef-a0dc-c228f742f430'
								    	} )
		
		if result["success"].present? && result["success"] == true
			self.uid = result["user"]["uuid"]
			self.save
		end	
	end
end

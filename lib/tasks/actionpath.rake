namespace :actionpath do

  desc "Copy the ACTION_PICKED_REQUEST_TYPE detail over to the install table"
  task set_install_request_type_from_log: :environment do
  	Install.all.each do |install|
  		if install.logged_action? Log::ACTION_PICKED_REQUEST_TYPE
  			# copy over they latest request type choice
        picked_request_type_log = install.logs.where(
  				:action=>Log::ACTION_PICKED_REQUEST_TYPE).order(timestamp: :desc).first
  			request_type = picked_request_type_log[:details]
  			install.update_column :request_type, request_type
  			Rails.logger.info("Set #{install.device_id} to #{request_type}")
  		end
  	end
  end

end

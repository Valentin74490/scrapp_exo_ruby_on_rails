require "google_drive"

puts "DEBUG: google_drive.rb initializer is loading..."

if Rails.env.development? || Rails.env.production?
  puts "DEBUG: We are in dev or production environment."
  credentials_path = Rails.root.join(ENV["GOOGLE_APPLICATION_CREDENTIALS_PATH"]).to_s
  puts "DEBUG: credentials_path = #{credentials_path}"

  GOOGLE_DRIVE_SESSION = GoogleDrive::Session.from_service_account_key(credentials_path)

  puts "DEBUG: GOOGLE_DRIVE_SESSION is defined."
end

puts "DEBUG: google_drive.rb initializer finished."

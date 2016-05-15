crumb :root do
  link "Home", root_path
end

crumb :oauth_applications do
  link "Developer Console", oauth_applications_path
end

crumb :oauth_application do |application|
  link application.name, oauth_application_path(application)
  parent :oauth_applications
end

crumb :edit_oauth_application do |application|
  link 'Edit', edit_oauth_application_path(application)
  parent :oauth_application, application
end

crumb :new_oauth_application do
  link 'New Application', new_oauth_application_path
  parent :oauth_applications
end

crumb :profile do
  link "Preferences", profile_path
end

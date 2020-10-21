require './config/environment'

use Rack::MethodOverride
use UsersController
use PlacesController
run ApplicationController

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end


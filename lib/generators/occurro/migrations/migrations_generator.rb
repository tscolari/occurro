module Occurro
  class MigrationsGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../../../../../db/migrate', __FILE__)

    def copy_migration
      migration_template 'create_occurro_counters.rb', "db/migrate/create_occurro_counters.rb"
      sleep 1
      migration_template 'create_occurro_daily_counters.rb', "db/migrate/create_occurro_daily_counters.rb"
    end

    private

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

  end
end

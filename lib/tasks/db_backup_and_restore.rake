namespace :recons do

  namespace :db do

    db_config = Rails.configuration.database_configuration
    user = db_config[Rails.env]['username']
    password = db_config[Rails.env]['password']
    host = db_config[Rails.env]['host']
    database = db_config[Rails.env]['database']

    task :dump do

      hostname = `hostname`.strip
      filename = "recons-#{hostname}-#{Rails.env}-#{Time.now.strftime('%Y-%m-%d_%Hh%M')}.sql"

      command = 'pg_dump -c'
      command += " -U #{user}"
      command += " -h #{host}" unless host.blank?
      command += " -d #{database}"
      command += " > #{filename}"

      sh command

      sh "tar -czf #{filename}.tgz #{filename}"
      File.delete filename

    end


    task :restore do

      unless ENV.has_key?('db_file')
        abort '"db_file" was not specified. Correct syntax is "rake recons:db:restore db_file=mydump.sql"'
      end

      db_file = ENV['db_file']

      command = 'psql'
      command += " -U #{user}"
      command += " -h #{host}" unless host.blank?
      command += " -d #{database}"
      command += " < #{db_file}"

      sh command

    end

  end

end
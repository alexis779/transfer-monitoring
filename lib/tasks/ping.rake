namespace :ping do

  task :inserts, [:ping_file] => [:environment] do |t, args|
    Pings::Creator.new.print_inserts(args[:ping_file])
  end

end

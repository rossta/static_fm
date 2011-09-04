namespace :static do

  task :usage do
    puts "static <library>"
  end

  namespace :install do

    desc 'Update backbone'
    task :backbone do
      dir = File.dirname(File.expand_path(__FILE__))
      StaticFM::Updater.update! do |u|
        u.url = "http://documentcloud.github.com/backbone"
        u.dir = File.join("public", "javascripts")
        u.files << "backbone.js"
        u.files << "backbone-min.js"
      end
    end

    desc 'Update underscore'
    task :underscore do
      StaticFM::Updater.update!.update! do |u|
        u.url = "http://documentcloud.github.com/underscore"
        u.dir = Rails.root.join("public", "javascripts", "vendor")
        u.files << "underscore.js"
        u.files << "underscore-min.js"
      end
    end

  end

end
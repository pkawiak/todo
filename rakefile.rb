require 'coffee-script'

namespace :js do
  desc "compile coffee-scripts from ./coffee to ./public/scripts"
  task :compile do
    source = "#{File.dirname(__FILE__)}/coffee/"
    javascripts = "#{File.dirname(__FILE__)}/public/scripts/"
    FileUtils.mkdir_p javascripts
    puts " >>>>>>>>>>>>>> 1"
    Dir.foreach(source) do |cf|
      unless cf == '.' || cf == '..'
        puts " >>>>>>>>>>>>>> 2"
        js = CoffeeScript.compile File.read("#{source}#{cf}") 
        open "#{javascripts}#{cf.gsub('.coffee', '.js')}", 'w' do |f|
          f.puts js
        end 
      end 
    end
  end
end
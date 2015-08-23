#!/usr/bin/ruby -w
require 'csv'

csv=CSV.open("/home/test_dir/folder_list.csv", "wb")
#hdd_folder="/media/sradhu/2C12264E12261D78/Movies/"
#main_folder="/home/test_dir/movies"
list=[]
Dir.chdir(hdd_folder)
list=Dir.glob(['**/*.avi','**/*.mp4','**/*.flv','**/*.mkv'])
list.each {|mv| csv << [mv,File.basename(mv),File.size(mv)/1000000]}


#subdir_list=Dir["*"].reject{|o| not File.directory?(o)}

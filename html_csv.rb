#!/usr/bin/ruby -w

require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'csv'
require 'zip'


def get_tot_link(url,search_string)
root_adr=url.split(/\//)[2]
page= Nokogiri::HTML(open(url))
link=page.css('a').select{|lin| lin.text==search_string}[0]["href"]
return File.join("http://",root_adr,link)
end
final_link=get_tot_link('http://www.nseindia.com/content/equities/cmbhav.htm','Download file in csv format')
#count=0
# down load the zip file.
unless final_link.match(/csv.zip/) == nil 
bhav_ar=final_link.split(/\//)
dest_path=File.join('/home/test_dir/',bhav_ar[-3],bhav_ar[-2])
zip_file=File.join(dest_path,bhav_ar[-1])
FileUtils.mkdir_p(File.dirname(dest_path)) unless Dir::exist?(dest_path) # it didnt create dir when it is not present.
File.open(zip_file, 'wb') do |fo|
  fo.print open(final_link).read 
end
end
#zip file is downloaded.
def unzip_file(file, destination)
 Zip::File.open(file)  do |zip_file|
        zip_file.each do |f|
            f_path=File.join(destination, f.name)
           # 
            f.extract(f_path)# unless File.exist?(f_path)
        end
    end
end

#unzip_file(zip_file,dest_path)  # unzip to csv file.
# Reading the above CSV file starts
def search_in_csv(input_csv,search_arr,output_csv)
   data = {}
  #read the csv file and store it in temp hash. 
   CSV.foreach(input_csv) do |row|
   sym=row[0]
   data.store(sym, row)
   end
   
fil=File.open('/home/test_dir/log.txt',"a")
   search_arr.each do |symb|
   fil.puts data[symb].class
   fil.puts data[symb]
   end
=begin  
 CSV.open(output_csv, "wb") do |csv|  
	search_arr.each do |symb|
		 csv << data[symb]  
	end
 end	
=end
end
search_criteria = ['TCS','RELIANCE','ONGC','INFY','IOB','ITC','NTPC'].sort
search_in_csv("/home/test_dir/2015/FEB/cm24FEB2015bhav.csv",search_criteria,"/home/test_dir/2015/FEB/main_list.csv")
# Reading the above CSV file ends

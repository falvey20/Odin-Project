require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def open_csv
  contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
  )
end

def clean_phone_number(phone_number)
  phone_number.tr!('^0-9', '')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == 1
    phone_number[1..10]
  else
    "Invalid Phone Number"
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def most_common_hour
  contents = open_csv
  reg_hour_arr = []
  contents.each do |row|
    reg_date = row[:regdate]
    # date format example 11/12/08 13:30
    reg_hour = Time.strptime(reg_date, '%m/%d/%Y %k:%M').strftime('%k')
    reg_hour_arr.push(reg_hour)
  end
  reg_hour_arr.max_by {|h| reg_hour_arr.count(h)}
end

def most_common_day_of_week
  weekdays = {0=>"Sunday",1=>"Monday",2=>"Tuesday",3=>"Wednesday",4=>"Thursday",5=>"Friday",6=>"Saturday"}

  contents = open_csv
  reg_day_of_week_arr = []
  contents.each do |row|
    reg_date = Date.strptime(row[:regdate].split[0], '%m/%d/%Y')
    reg_day_of_week_arr.push(weekdays[reg_date.wday])
  end
  reg_day_of_week_arr.max_by {|d| reg_day_of_week_arr.count(d)}
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

# open_csv

# template_letter = File.read('form_letter.erb')
# erb_template = ERB.new template_letter

# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])
#   phone_number = clean_phone_number(row[:homephone])
#   legislators = legislators_by_zipcode(zipcode)
  
#   # form_letter = erb_template.result(binding)
#   # save_thank_you_letter(id,form_letter)

# most common reg hour
puts "Most Common Registration Hour: #{most_common_hour}:00"

# most common reg day of the week
puts "Most Common Registration Day of Week: #{most_common_day_of_week}"


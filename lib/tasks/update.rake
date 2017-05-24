namespace :db do
  desc "Download latest project list and import csv"
  task :update => :environment do
    require 'csv'
    require 'open-uri'

    puts "Starting import..."
    record_count = 0

    filename = "http://infrastructure.gc.ca/alt-format/opendata/project-list-liste-de-projets-bil.csv"

    CSV.parse(open(filename, 'r:iso-8859-1:utf-8'){|f| f.read}, headers: true, header_converters: :symbol) do |row|

      project_number = row[0]
      project_title_en = row[1]
      project_title_fr = row[2]

      program_title_en = row[5]
      program_title_fr = row[6]

      category_en = row[7]
      category_fr = row[8]

      location_en = row[9]
      location_fr = row[10]

      region = row[11]

      approved_date = row[12]
      construction_start_date = row[13]
      construction_end_date = row[14]
      federal_contribution = row[15]
      total_eligible_cost = row[16]
      ultimate_recipient_en = row[17]
      ultimate_recipient_fr = row[18]
      forecasted_construction_start_date = row[19]
      forecasted_construction_end_date = row[20]

      program = Program.find_or_create_by(title_en:program_title_en)  
        program.title_en = program_title_en
        program.title_fr = program_title_fr
      program.save!

      program_id = Program.find_by(title_en:program_title_en).id

      category = Category.find_or_create_by(title_en:category_en)  
        category.title_en = category_en
        category.title_fr = category_fr
      category.save!

      category_id = Category.find_by(title_en:category_en).id

      region_code = Region.find_or_create_by(code:region)  
      region_code.save!

      region_id = Region.find_by(code:region).id

      location = Location.find_or_create_by(name_en:location_en, region_id: region_id)  
        location.name_fr = location_fr
      location.save!

      location_id = Location.find_by(name_en:location_en, region_id: region_id).id

      project = Project.find_or_create_by(number:project_number)
        project.title_en = project_title_en
        project.title_fr = project_title_fr
        project.federal_contribution = federal_contribution
        project.total_eligible_cost = total_eligible_cost
        project.ultimate_recipient_en = ultimate_recipient_en
        project.ultimate_recipient_fr = ultimate_recipient_fr
        project.forecasted_construction_start_date = forecasted_construction_start_date
        project.forecasted_construction_end_date = forecasted_construction_end_date
        project.approved_date = approved_date
        project.construction_start_date = construction_start_date
        project.construction_end_date = construction_end_date
        project.program_id = program_id
        project.category_id = category_id
        project.location_id = location_id
        project.region_id = region_id
        project.save!

      record_count = record_count + 1
    end

    puts "#{record_count} project records imported"
  end
end
#     !/usr/bin/env /home/openfoundry/of/script/rails runner

#def nsc_review
  nsc_file = File.join(Rails.root, "nsc_upload_dir", "nsc_review.txt")
  nsc_data = []
  nsc_find = ""

  File.open(nsc_file).each_line("\n") do |line|
    line.gsub!(/\n/, "") 
    nsc_data << line.split(",")
  end 
  #puts nsc_data.class
  nsc_data.each do |row|
    ps = Project.find_tagged_with("NSC#{row[3]}")
    find = "#{row[0]},#{row[1]},#{row[2]},#{row[3]}" 
    has_project = 0
    ps.each do |p|
      if p.status == Project::STATUS[:READY] || p.status == Project::STATUS[:APPLYING] || p.status == Project::STATUS[:PENDING] 
        find += ",#{p.name}"
        find += "(#{Project.status_to_s(p.status)})" if p.status != Project::STATUS[:READY]
        has_project += 1
      end
    end 
    if has_project == 0
      find += ",none"
    end
    puts find
    nsc_find << find + "\n"
  end

  f = File.new(File.join(Rails.root, "nsc_upload_dir", "nsc_review_find.txt"), "w+")
  f.puts nsc_find 
  f.close

#end

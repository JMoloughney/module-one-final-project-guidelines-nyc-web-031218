crime_data.each do |complaint|
	Crime.create(offense: complaint["ofns_desc"], type: complaint["law_cat_cd"], date: complaint["cmplnt_fr_dt"], completed_crime: complaint["crm_atpt_cptd_cd"], complaint["complaint_num"])
end



crime_data.each do |complaint|
	Location.create(name: complaint["boro_nm"], scene_of_crime: complaint["prem_typ_desc"], in_or_out: complaint["loc_of_occur_desc"], complaint["latitude"])
end


crime_data.each do |complaint|
	act = CriminalAct.new(complaint_num: complaint["cmplnt_num"], complaint["latitude"])
	act.location = Location.find_by(latitude: act["latitude"])
	act.crime = Crime.find_by(complaint_num: act["cmplnt_num"])
	act.save
end



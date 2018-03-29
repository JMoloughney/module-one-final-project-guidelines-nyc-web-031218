require_relative '../config/environment'
require 'pry'




crime_data.each do |complaint|
	x = Crime.create(offense: complaint["ofns_desc"],
		severity: complaint["law_cat_cd"],
		date_of_crime: complaint["cmplnt_fr_dt"],
		completed_crime: complaint["crm_atpt_cptd_cd"])
	y = Location.create(name: complaint["boro_nm"],
		scene_of_crime: complaint["prem_typ_desc"],
		in_or_out: complaint["loc_of_occur_desc"])
	 CriminalAct.create(complaint_num: complaint["cmplnt_num"],
		crime_id: x.id, location_id: y.id)
end

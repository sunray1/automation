import GBIF
using DataFrames

import CSV


sp_name = "Amphiprion"
sp = GBIF.taxon(sp_name, strict=false)


# Get 900 occurrences
occ = GBIF.occurrences(sp, "hasCoordinate" => "true", "limit" => 300)
GBIF.occurrences!(occ)
GBIF.occurrences!(occ)
GBIF.occurrences!(occ)
GBIF.occurrences!(occ)
GBIF.occurrences!(occ)
GBIF.occurrences!(occ)

raw_data = DataFrame(occ)
raw_data = raw_data[raw_data.rank .== "SPECIES", :]
ok_names = "Amphiprion ".*["melanopus", "ocellaris", "clarkii"]
ok_index = map(f -> in(f, ok_names), raw_data.names)
raw_data = raw_data[ok_index, :]

data = select(raw_data, [:name, :longitude, :latitude])

first(data, 5)

CSV.write("occurrences.csv", data; writeheader=true)


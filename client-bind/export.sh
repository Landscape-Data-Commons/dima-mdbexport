#!/bin/bash
# mdbarr=()
# lenarr=${#mdbarr[@]}
mdbtestvar="test-ok"

# for f in /client-bind/*; do
#      mdbarr+=("$f")
# echo "$lenarr"
# for ((j=0; j<lenarr; j++));
# do
#      printf "hmm index: %d and val: %s\n" $j "${mdbarr[$j]}"
# # for el in "${mdbarr[@]}";do
# #      echo "$el"
# done

echo "$mdbarr"



tablearray=('tblPlots' 
      'tblLines' 
      'tblLPIDetail' 
      'tblLPIHeader' 
      'tblGapDetail' 
      'tblGapHeader' 
      'tblQualHeader' 
      'tblQualDetail' 
      'tblSoilStabHeader' 
      'tblSoilStabDetail' 
      'tblSoilPitHorizons' 
      'tblSoilPits' 
      'tblSpecRichHeader' 
      'tblSpecRichDetail' 
      'tblPlantProdHeader' 
      'tblPlantProdDetail' 
      'tblPlotNotes' 
      'tblPlantDenHeader' 
      'tblPlantDenDetail' 
      'tblSpecies' 
      'tblSpeciesGeneric' 
      'tblSites' 
      'tblBSNE_Box' 
      'tblBSNE_BoxCollection' 
      'tblBSNE_Stack' 
      'tblBSNE_TrapCollection' 
      'tblCompactDetail' 
      'tblCompactHeader' 
      'tblDKDetail' 
      'tblDKHeader' 
      'tblDryWtCompYield' 
      'tblDryWtDetail' 
      'tblDryWtHeader' 
      'tblESDDominantPerennialHeights' 
      'tblESDRockFragments' 
      'tblESDWaypoints' 
      'tblInfiltrationDetail' 
      'tblInfiltrationHeader' 
      'tblLICDetail' 
      'tblLICHeader' 
      'tblLICSpecies' 
      'tblNestedFreqDetail' 
      'tblNestedFreqHeader' 
      'tblNestedFreqSpeciesDetail' 
      'tblNestedFreqSpeciesSummary' 
      'tblOcularCovDetail' 
      'tblOcularCovHeader' 
      'tblPlantDenQuads' 
      'tblPlantDenSpecies' 
      'tblPlantLenDetail' 
      'tblPlantLenHeader' 
      'tblPlotHistory' 
      'tblPTFrameDetail' 
      'tblPTFrameHeader' 
      'tblQualDetail' 
      'tblQualHeader' 
      'tblSpeciesGrowthHabits' 
      'tblSpeciesRichAbundance' 
      'tblTreeDenDetail' 
      'tblTreeDenHeader'
)

contains_true (){
     local array=$1[@]
     local seeking=$2
     local in=1
     for element in "${!array}"; 
     do
          if [[ $element == "$seeking" ]]; 
          then 
               in=0
               break
          fi
     done 
     return $in
}

# for each file in x directory:
## for each table inside each file:
### mdb-csv to xdirectory/file-table 

# puta
for mdbfile in client-bind/mdbs/* 
do
declare "mdb_tables=$( mdb-tables $mdbfile )" #wrong number of arguments but works?
# trimming file extension from filename
declare "no_extension=${mdbfile%.*}"
# trimming whitespace from filename
declare "no_whitespace=$(echo "$no_extension" | tr -d ' ')"
# trimming path from filename
declare "no_path=${no_whitespace##*/}"
echo "Currently working on mdb: ${no_path}"
# if dir does not exist, create it
[ -d "/client-bind/${no_path}" ] || mkdir "/client-bind/${no_path}"
     echo "File is: ${mdbfile}"
     for table in $mdb_tables
     do
          echo "Working on table: $table from mdb: $mdbfile"
          # para cada mdb, si la tabla existe en el array principal,
          # extraer a csv
          contains_true tablearray "$table" && mdb-export -D '%Y-%m-%d %H:%M:%S' "$mdbfile" "$table" > \
          "client-bind/${no_path}/${no_path}-${table}.csv" || echo "$table NOT EXPORTED"
     done
done

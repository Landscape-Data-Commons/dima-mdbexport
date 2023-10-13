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
     local mdbfile=$3
     local dirname=$4
     local in=1
     for element in "${!array}"; 
     do
     echo "using table array of: ${array}"
     echo "using mdbfile: ${mdbfile}"
     echo "using table: ${seeking}"
     echo "exporting to directory: /client-bind/${dirname}/"
          if [[ $element == "$seeking" ]]; 
          then 
               echo "table ${seeking} found in approved-tables array"
               mdb-export -D '%Y-%m-%d %H:%M:%S' "$mdbfile" "$seeking" > \
          "client-bind/${dirname}/${dirname}-${seeking}.csv"
               in=0
               break
          else 
               echo "table ${seeking} not found in approved-tables array"
               break
          fi
     done 
     return $in
}

# for each file in x directory:
## for each table inside each file:
### mdb-csv to xdirectory/file-table 

for mdbfile in client-bind/mdbs/* 
do
# triming file extension from filename
declare "no_extension=${mdbfile%.*}"
# triming whitespace from filename
declare "no_whitespace=$(echo "$no_extension" | tr -d ' ')"
# trimming path from filename
declare "no_path=${no_whitespace##*/}"
echo "Currently working on mdb: ${no_path}"
# if dir does not exist, create it
[ -d /client-bind/${no_path}] || mkdir /client-bind/${no_path}
     for table in $(mdb-tables $mdbfile)
     do
     echo "Currently exporting table: ${table} from mdb: ${no_path}"
          # para cada mdb, si la tabla existe en el array principal,
          # extraer a csv
          contains_true tablearray "$table" "$mdbfile" "$no_path"
     done
done

<?php
// Copyright (c) Isaac Gouy 2005

// FUNCTIONS ///////////////////////////////////////////////////

function ReadCsv($FileName,$HasHeading=TRUE){
      $t0 = GetMicroTime();
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }
   
   $count = 0;
   $dset = array();
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }  
            
      settype($row[DATA_ID],'integer');      
      $tag = $row[DATA_TEST]."-".$row[DATA_LANG]."-".$row[DATA_ID]; 
      $value = $row[DATA_FULLCPU];    
      
      if (isset($dset[$tag])){      
         if ($value < 0){ $dset[$tag] = $value; }            
      }
      else {
         $dset[$tag] = $value;      
      }
      $count++;          
   }
   @fclose($f);       
      $t1 = GetMicroTime();          
   return array($dset,$count,$t1-$t0);
}



function ReadLogFiles($dirPath){
   $prefix = 30; // PROGRAM OUTPUTLF==============LF
   
   $logs = array();   
   $dh = opendir($dirPath);
   while($fn = readdir($dh)){
      $ext = strpos($fn,'.log');
      $tag = substr($fn,0,$ext);   
      if ($tag){ 
         if ( sizeof(explode('-',$tag)) < 3 ){ $tag .= '-0'; }    
         
         $byteSize = filesize(LOG_PATH.$fn);
         
         $code = 0;         
         if ($byteSize > 0){                  
            $f = fopen(LOG_PATH.$fn,'r');
            $s = fread($f,$byteSize);
            fclose($f);
                        
            if (strpos($s,'Permission denied')){ $code = PROGRAM_EXCLUDED; }         
            elseif (strpos($s,'TIMEOUT')){ $code = PROGRAM_TIMEOUT; }
            elseif (strpos($s,'FAILED')){ $code = PROGRAM_ERROR; }            
            else {
               if ($i = strpos($s,'PROGRAM OUTPUT')){               
                  if ($i+$prefix == strlen($s)){ $code = NO_PROGRAM_OUTPUT; }
               }
               else { $code = NO_PROGRAM_OUTPUT; }
            }   
         }      
         else { $code = NO_PROGRAM_OUTPUT; }                    
                            
         $logs[$tag] = array($code,$byteSize);                            
      }
   }
   closedir($dh);   
   return $logs;
}


function PrettyTag($k){
   $a = explode('-',$k);
   $s = $a[0]." ".$a[1];
   if ($a[2]>0){ $s .= " #".$a[2]; }
   return $s;
}

function CompareLogFileSize($a, $b){
   if ($a[1] == $b[1]) return 0;
   return  ($a[1] > $b[1]) ? -1 : 1;
}

?>
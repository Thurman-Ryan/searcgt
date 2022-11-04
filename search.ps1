function search-filez {param ([System.Array] $branchesandleaves, [System.Object] $arr, [System.ValueType] $filesizzze)
     $bigfolds=@()
     $branchesandleaves | foreach {
         $aa=($_.fullname -split "\\")
         $gungho='$arr'
         For ($i=1;$i -lt ($aa.count);$i++) {$gungho+='.($aa['+"$i])"}
         if($_.fullname -ne "C:\Windows\servicing" -and $_.fullname -ne "C:\Windows\WinSxS"){
       try{$testie=(get-childitem $_.fullname -ErrorAction SilentlyContinue)
       #insert what to do in each
         if ($testie -ne $null){
           Invoke-expression($gungho+'=@{}')
           Invoke-expression($gungho+'.size=((get-childitem $_.fullname -file  | measure-object -Property length -sum).sum)')
           Invoke-expression($gungho+'.cumsize=((get-childitem $_.fullname -file | measure-object -Property length -sum).sum)')
         }
         $testie=(get-childitem $_.fullname -directory -ErrorAction SilentlyContinue)
         if ($testie -ne $null){
           search-filez -branchesandleaves $testie -arr $arr -filesizzze $filesizzze
           Invoke-expression(($gungho -replace '\.\(\$aa\[\d\]\)$')+".cumsize+=$gungho"+".cumsize")
         }
         if ((Invoke-expression($gungho+".cumsize")) -gt $filesizzze){
           $bigfolds+=($_.fullname)
         }
       }
       catch{}
     }
   }
   return $bigfolds
 }
$test=@{}
search-filez -branchesandleaves (get-childitem "C:\") -arr $test -filesizzze 10000000000

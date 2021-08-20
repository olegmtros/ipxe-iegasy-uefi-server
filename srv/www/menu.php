<?php

require_once('params.php');

echo ":menu\n";
echo $header;


title ("windows install like CDROM", "hp");

//item("win_peCD", "win_pe", "wimbootCD.php", "hp");
item("win_pe_uefi_CD", "win_peUEF", "win_peueficd.php", "hp");
item("win_pe_legasy_CD", "win_peleg", "win_pelegcd.php", "hp");


echo "item --gap\n";
echo "item backtotop Back to top\n";
echo "item signin Sign in as a different user\n";
echo $default;

foreach ($entries as $i) {
    echo "{$i}\n";
}
echo ":backtotop\n";
echo "goto menu\n";
echo ":signin\n";
echo "chain --replace --autofree {$url}boot.php\n";

?>

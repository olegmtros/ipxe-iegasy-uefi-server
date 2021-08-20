<?php

require_once('params.php');



echo "dhcp\n";
echo "kernel {$url}winpe/wimboot gui\n";
echo "initrd --name bcd {$url}winpe/BCD BCD\n";
echo "initrd --name boot.sdi {$url}winpe/boot.sdi boot.sdi\n";
echo "initrd --name boot.wim {$url}winpe/boot.wim boot.wim\n";
echo "boot\n";
?>

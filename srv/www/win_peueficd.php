<?php

require_once('params.php');

echo "dhcp\n";
echo "kernel {$url}efipe/wimboot gui\n";
echo "initrd --name bootx64 {$url}efipe/bootx64.efi\n";
echo "initrd --name bcd {$url}efipe/BCD BCD\n";
echo "initrd --name boot.sdi {$url}efipe/boot.sdi boot.sdi\n";
echo "initrd --name boot.wim {$url}efipe/boot.wim boot.wim\n";
echo "boot\n";
?>
